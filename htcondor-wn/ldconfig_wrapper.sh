#!/bin/bash
echo "executing script ldconfig_wrapper.sh from htcondor-wn" > /tmp/condor_htcondor_ldconfig_wrapper.log
/sbin/ldconfig -C /scratch/ld.so.cache "$@"
