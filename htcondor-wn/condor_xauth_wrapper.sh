#!/bin/bash

# Walk up the process tree until we find the second sshd which rewrites cmdline to "sshd: user@tty".
# The first sshd is our parent process which does not log itself.
SSHD_PID=$$
SSHD_CNT=0
while true; do
  IFS= read -r -d '' CMDLINE </proc/${SSHD_PID}/cmdline || [[ $cmdline ]]
  echo "Checking ID ${SSHD_PID}, cmdline ${CMDLINE^^}" > /tmp/condor_xauth_wrapper.log
  SSHD_MATCHER="^SSHD: "
  if [[ ${CMDLINE^^} =~ ${SSHD_MATCHER} ]]; then
    # We found the sshd!
    SSHD_CNT=$(( SSHD_CNT + 1))
    if [ ${SSHD_CNT} -gt 1 ]; then
      break;
    fi
  fi
  SSHD_PID=$(ps -o ppid= -p ${SSHD_PID} | awk '{print $1}')
  if [ ${SSHD_PID} -eq 1 ]; then
    # We arrived at the INIT process, something very wrong... Let's stop and alert the user.
    echo "Error: Could not determine sshd process, X11 forwarding will not work!" >> /tmp/condor_xauth_wrapper.log
    echo "       Please let your admins know you got this error!" >> /tmp/condor_xauth_wrapper.log
    exit 0
  fi
done
echo "SSHD PID is ${SSHD_PID}." >> /tmp/condor_xauth_wrapper.log

# Find sshd.log, checking through fds.
FOUND_SSHD_LOG=0
for FD in $(ls -1 /proc/${SSHD_PID}/fd/); do
  FILE=$(readlink -f /proc/${SSHD_PID}/fd/$FD)
  echo "Checking FD $FD, file is $FILE" >> /tmp/condor_xauth_wrapper.log
  SSHD_LOG_MATCHER="sshd\.log$"
  if [[ "${FILE}" =~ ${SSHD_LOG_MATCHER} ]]; then
    echo "Found ${FILE}!" >> /tmp/condor_xauth_wrapper.log
    FOUND_SSHD_LOG=1
    SSH_TO_JOB_DIR=$(dirname ${FILE})
    JOB_WORKING_DIR=$(dirname ${SSH_TO_JOB_DIR})
    break;
  fi
done

if [ ${FOUND_SSHD_LOG} -eq 0 ]; then
  # We could not identify sshd.log, let's stop and alert the user.
  echo "Error: Could not determine sshd process' (PID: ${SSHD_PID}) log, X11 forwarding will not work!" >> /tmp/condor_xauth_wrapper.log
  echo "       Please let your admins know you got this error!" >> /tmp/condor_xauth_wrapper.log
  exit 0
fi

# Finally, if we arrive here, all is well.

# This does NOT work, since env.sh is sourced as forced command, too early.
#echo "export DISPLAY=${DISPLAY}" >> ${SSH_TO_JOB_DIR}/env.sh

# Ugly hack needed with HTCondor 8.8.10 which does not yet pass through DISPLAY or TERM.
echo "export DISPLAY=${DISPLAY}" > ${JOB_WORKING_DIR}/.display
echo "export TERM=${TERM}" >> ${JOB_WORKING_DIR}/.display

export XAUTHORITY=${JOB_WORKING_DIR}/.Xauthority
/usr/bin/xauth "$@" </dev/stdin
