echo "environment variables before sourcing 10-fixup_singularity.sh" > /tmp/condor_10-fixup_singularity.log
echo "TERM = $TERM" >> /tmp/condor_10-fixup_singularity.log
echo "LANG = $LANG" >> /tmp/condor_10-fixup_singularity.log

# Dirty hack for issue: https://github.com/sylabs/singularity/issues/1419
if [ ! -e /dev/fd ]; then
  echo "symbolic links NOT properly defined for the file descriptors" >> /tmp/condor_10-fixup_singularity.log
  echo "now defined by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log 
  echo "" >> /tmp/condor_10-fixup_singularity.log
  ln -s /proc/self/fd /dev/fd
  ln -s /proc/self/fd/0 /dev/stdin
  ln -s /proc/self/fd/1 /dev/stdout
  ln -s /proc/self/fd/2 /dev/stderr
else
  echo "symbolic links properly defined for the file descriptors" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
  echo "$(ls -la /dev | grep -E "fd|stdin|stdout|stderr")" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
fi

# Dirty hack for issue: https://github.com/sylabs/singularity/issues/3670
if [ ! -e /dev/tty -a -e /dev/pts/0 ]; then
  echo "symbolic links NOT properly defined for tty" >> /tmp/condor_10-fixup_singularity.log
  echo "now defined by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
  ln -s /dev/pts/0 /dev/tty
else
  echo "symbolic links properly defined for tty" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
fi

# If environment was destroyed, e.g. by changing interpreter (to "script"), fixup things.
if [ -z "${HOME}" ]; then
  echo "environment NOT properly defined" >> /tmp/condor_10-fixup_singularity.log
  echo "now defined by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
  export HOME=${SINGULARITY_HOME}
  # Also do a TERM definition only here, only want to do that if we are in a known-broken environment.
  export TERM="linux"
else
  echo "environment properly defined" >> /tmp/condor_10-fixup_singularity.log
  echo "HOME = $HOME" >> /tmp/condor_10-fixup_singularity.log
  echo "TERM = $TERM"  >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
fi

# If TERM is dumb, also "upgrade" that to "linux". Seems to happen when using unprivileged sshd + nsenter.
if [ "x${TERM}" = "xdumb" ]; then
  echo "TERM NOT set to linux" >> /tmp/condor_10-fixup_singularity.log
  echo "now set by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
  export TERM="linux"
fi

# If LD_LIBRARY_PATH does not contain the Singularity specific bind mount target, add that.
# Usually done in /.singularity.d/env/99-base.sh, but we might not have sourced that.
if [ -d "/.singularity.d/libs" ] && [[ ":$LD_LIBRARY_PATH:" != *":/.singularity.d/libs:"* ]]; then
  echo "Singularigy-specific bind mount target NOT included in LD_LIBRARY_PATH" >> /tmp/condor_10-fixup_singularity.log
  echo "now included by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log         
  echo "" >> /tmp/condor_10-fixup_singularity.log
  # Prepend only if not present yet, see https://superuser.com/a/39995/858025 .
  LD_LIBRARY_PATH="/.singularity.d/libs${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
else
  echo "Singularigy-specific bind mount target already included in LD_LIBRARY_PATH" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
fi

# Singularity sets "C" locale in "-C" (i.e. full containment) mode. We prefer something with utf8.
if [ -z "${LANG}" -o "x${LANG}" = "xC" ]; then
  echo "LANG NOT set to en_US.utf8" >> /tmp/condor_10-fixup_singularity.log
  echo "now set by 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log 
  echo "" >> /tmp/condor_10-fixup_singularity.log
  export LANG=en_US.utf8
else
  echo "LANG already set to en_US.utf8" >> /tmp/condor_10-fixup_singularity.log
  echo "" >> /tmp/condor_10-fixup_singularity.log
fi

echo "environment variables after sourcing 10-fixup_singularity.sh" >> /tmp/condor_10-fixup_singularity.log
echo "TERM = $TERM" >> /tmp/condor_10-fixup_singularity.log
echo "LANG = $LANG" >> /tmp/condor_10-fixup_singularity.log

