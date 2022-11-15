#!/bin/bash
echo "executing script ldconfig_wrapper.sh from wlcg-wn" > /tmp/condor_wlcg_ldconfig_wrapper.log
/sbin/ldconfig -C /scratch/ld.so.cache "$@"
#/sbin/ldconfig -C /srv/ld.so.cache "$@"
