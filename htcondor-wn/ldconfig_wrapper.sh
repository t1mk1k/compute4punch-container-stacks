#!/bin/bash
echo "executing script ldconfig_wrapper.sh" > /tmp/condor_ldconfig_wrapper.log
/sbin/ldconfig -C /scratch/ld.so.cache "$@"
