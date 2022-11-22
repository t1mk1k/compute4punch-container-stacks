#!/bin/sh

die() {
  echo $1
  exit 1
}

save() {
  echo $1 >> /tmp/condor_ssh_to_job_sshd_setup.log
}

base_dir="$1"
ssh_to_job_shell_setup="$2"
sshd_config_template="$3"
ssh_keygen="$4"

echo "base_dir = $base_dir" > /tmp/condor_ssh_to_job_sshd_setup.log
save "ssh_to_job_shell_setup = $ssh_to_job_shell_setup"
save "sshd_config_template = $sshd_config_template"
save "ssh_keygen = $ssh_keygen"

# create sshd session directory
num=1
while [ 1 ]; do
  sshd_dir="${base_dir}/.condor_ssh_to_job_${num}"
  if /bin/mkdir "${sshd_dir}" > /dev/null 2>&1; then
    save "${sshd_dir} created successfully"
    break
  fi
  if [ -e "${sshd_dir}" ]; then
    num=$(($num+1))
    continue
  fi
  save "Failed to create ${sshd_dir}"
  # die "Failed to create ${sshd_dir}"
done

# save environment so that ssh_to_job_shell_setup can restore it
# do not preserve the job's DISPLAY environment variable, because
# that will conflict with X forwarding in the ssh session
unset DISPLAY
export -p > "${sshd_dir}/env.sh"

if [ -x /bin/sed ]; then
  SED=/bin/sed
elif [ -x /usr/bin/sed ]; then
  SED=/usr/bin/sed
else
  SED=sed
fi

sshkey="${sshd_dir}/sshkey"
# modify ssh-keygen command string
# replace %% --> %, %f --> ${sshkey}
ssh_keygen=$(echo "${ssh_keygen}" | "${SED}" 's|\([^%]\)%f|\1'"${sshkey}"'|g;s|%%|%|g')

# run ssh-keygen
eval $ssh_keygen > "${sshd_dir}/keygen.log" 2>&1

if [ $? != 0 ]; then
  /bin/cat "${sshd_dir}/keygen.log"
  # die "Failed to create ssh key ${sshkey} with command ${ssh_keygen}"
  save "Failed to create ssh key ${sshkey} with command ${ssh_keygen}"
fi

# inject our shell setup command into authorized keys options
force_command="${ssh_to_job_shell_setup} ${sshd_dir}/env.sh"
/bin/echo -n "command=\"${force_command}\" " > "${sshd_dir}/authorized_keys" \
#  || die "Failed to create ${sshd_dir}/authorized_keys"
  || save "Failed to create ${sshd_dir}/authorized_keys"
/bin/cat "${sshkey}.pub" >> "${sshd_dir}/authorized_keys" \
#  || die "Failed to append ${sshkey}.pub to ${sshd_dir}/authorized_keys."
  || save "Failed to append ${sshkey}.pub to ${sshd_dir}/authorized_keys."
# create sshd_config by substituting into our template
sshd_config="${sshd_dir}/sshd_config"
"${SED}" \
   < "${sshd_config_template}" \
   > "${sshd_config}" \
     "s|_INSERT_HOST_KEY_|${sshkey}|g;
      s|_INSERT_AUTHORIZED_KEYS_FILE_|${sshd_dir}/authorized_keys|g;
      s|_INSERT_FORCE_COMMAND_|${force_command}|g"\
# || die "Failed to create ${sshd_config}"
 || save "Failed to create ${sshd_config}"
sshd_user=`/usr/bin/whoami` || save "Failed to run /usr/bin/whoami"
# || die "Failed to run /usr/bin/whoami"

# now transmit stuff back to our caller on stdout
# the caller expects specific markers before and after each item

echo "condor_ssh_to_job_sshd_setup SSHD USER BEGIN"
echo "${sshd_user}"
echo "condor_ssh_to_job_sshd_setup SSHD USER END"

echo "condor_ssh_to_job_sshd_setup SSHD DIR BEGIN"
echo "${sshd_dir}"
echo "condor_ssh_to_job_sshd_setup SSHD DIR END"

save "condor_ssh_to_job_sshd_setup SSHD USER BEGIN"
save "${sshd_user}"
save "condor_ssh_to_job_sshd_setup SSHD USER END"

save "condor_ssh_to_job_sshd_setup SSHD DIR BEGIN"
save "${sshd_dir}"
save "condor_ssh_to_job_sshd_setup SSHD DIR END"

echo "condor_ssh_to_job_sshd_setup PUBLIC SERVER KEY BEGIN"
save "condor_ssh_to_job_sshd_setup PUBLIC SERVER KEY BEGIN"

/bin/cat "${sshkey}.pub" \
#  || die "Failed to read ${sshkey}.pub"
  || save "Failed to read ${sshkey}.pub"

echo "condor_ssh_to_job_sshd_setup PUBLIC SERVER KEY END"
save "condor_ssh_to_job_sshd_setup PUBLIC SERVER KEY END"

echo "condor_ssh_to_job_sshd_setup AUTHORIZED CLIENT KEY BEGIN"
save "condor_ssh_to_job_sshd_setup AUTHORIZED CLIENT KEY BEGIN"

/bin/cat "${sshkey}" \
#  || die "Failed to read ${sshkey}"
  || save "Failed to read ${sshkey}"

echo "condor_ssh_to_job_sshd_setup AUTHORIZED CLIENT KEY END"
save "condor_ssh_to_job_sshd_setup AUTHORIZED CLIENT KEY END"

echo "condor_ssh_to_job_sshd_setup SUCCESS"
save "condor_ssh_to_job_sshd_setup SUCCESS"
