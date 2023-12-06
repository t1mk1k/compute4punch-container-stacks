# Fix potentially broken environment.
if [ -z "${HOME}" ]; then
  export HOME=${SINGULARITY_HOME}
  export TERM="linux"
fi

# If TERM is dumb, upgrade it to linux.
# Seems to happen when using unprivileged sshd + nsenter.
if [ "x${TERM}" = "xdumb" ]; then
  export TERM="linux"
fi

# Add the Singularity specific bind mount target to LD_LIBRARY_PATH if not yet present.
if [ -d "/.singularity.d/libs" ] && [[ ":$LD_LIBRARY_PATH:" != *":/.singularity.d/libs:"* ]]; then
  LD_LIBRARY_PATH="/.singularity.d/libs${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
fi

# Set LANG to utf8.
if [ -z "${LANG}" -o "x${LANG}" = "xC" ]; then
  export LANG=en_US.utf8
fi


