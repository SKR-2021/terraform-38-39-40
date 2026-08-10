#!bin/bash

component=$1
dnf install ansible -y
sudo ansible-pull -U https://github.com/daws-86s/ansible-roboshop-roles-tf.git -e component=$component main.yaml