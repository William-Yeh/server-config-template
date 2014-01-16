#!/bin/sh

echo "*Simple wrapper for 'ssh-copy-id'*\n"

echo "Please input the address of remote machine & superuser's account, \
then the program will install your public key '$HOME/.ssh/id_rsa.pub' \
in the remote machine's authorized_keys.\n\n"

read -p "Input the remote machines address (IP or FQDN): " host
read -p "Input a superuser's account: " name


target=$name@$host 
echo "Copying to" $target " ...\n"

ssh-copy-id  -i $HOME/.ssh/id_rsa.pub  $target

