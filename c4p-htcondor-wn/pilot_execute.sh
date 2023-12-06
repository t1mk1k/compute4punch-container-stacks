#!/bin/bash -l
cd /srv/ansible_config && ansible-playbook -i hosts.ini container_config.yaml && cd /srv && condor_master -f
