#!/bin/bash

apt-get update
cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys