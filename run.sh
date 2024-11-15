#!/bin/bash

ansible-playbook -i hosts/inventory playbooks/infratructure.yml
ansible-playbook -i hosts/inventory playbooks/copie_project_to_hosts.yml
ansible-playbook -i hosts/inventory playbooks/install_docker.yml
ansible-playbook -i hosts/inventory playbooks/run.yml
