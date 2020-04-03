#!/usr/bin/env bash

set -e
cd $( dirname "${BASH_SOURCE[0]}" )/..
patch < multipass.patch
multipass delete --all --purge
multipass launch --name pi --cloud-init cloud-init.yaml
patch -R < multipass.patch
sleep 60

set -x
multipass exec pi -- sudo docker stack ls
inspec exec tests --shell --shell-command='multipass exec pi sudo sh'
