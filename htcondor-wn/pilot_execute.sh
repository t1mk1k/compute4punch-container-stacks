#!/bin/bash -l
# Set X509 Grid CA Path accordingly before starting HTCondor
export X509_CERT_DIR=/cvmfs/grid.cern.ch/etc/grid-security/certificates

cd /srv/ansible_config && ansible-playbook -i hosts.ini container_config.yaml && cd /srv && condor_master -f
