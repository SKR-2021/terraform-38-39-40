#!bin/bash
component=$1
dnf install ansible -y
sudo ansible-pull -U https://github.com/SKR-2021/ansible-dotmart-roles-tf.git -e component=$component main.yaml