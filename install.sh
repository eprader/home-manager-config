#!/bin/bash
echo "running nixsetup.sh"
./utils/nixsetup.sh
echo "nixsetup.sh finished"
echo "running sshsetup.sh"
./utils/sshsetup.sh
echo "sshsetup.sh finished"
echo "switching home-manager-config repo to ssh"
git remote set-url origin git@github.com:eprader/home-manager-config.git
echo "switched repo to ssh please add ssh key to github to be able to push changes"
echo "setup finished!"
