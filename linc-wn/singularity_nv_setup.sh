#!/bin/bash
# --nv flag does not work in nested singularity containers
# this workaround ensures that --nv even works in nested singularity containers
# details can be found in https://github.com/apptainer/singularity/issues/5759 

[[ :$LD_LIBRARY_PATH: == *":/.singularity.d/libs:"* ]] || LD_LIBRARY_PATH=/.singularity.d/libs:${LD_LIBRARY_PATH}
/usr/local/bin/ldconfig /.singularity.d/libs
