#!/bin/bash
initial_word_dir=$(pwd) 
script_dir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
cd "$script_dir"
echo "running nixsetup.sh"
./utils/nixsetup.sh
echo "nixsetup.sh finished"
echo "running sshsetup.sh"
#scriptDir/utils/sshsetup.sh
echo "sshsetup.sh finished"
echo "switching home-manager-config repo to ssh"
git remote set-url origin git@github.com:eprader/home-manager-config.git
echo "switched repo to ssh please add ssh key to github to be able to push changes"
echo "setup finished!"
cd "$initial_word_dir"
