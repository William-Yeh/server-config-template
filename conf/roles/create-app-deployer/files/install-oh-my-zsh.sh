#!/bin/sh
# simple script to install oh-my-zsh
#
# @see https://github.com/robbyrussell/oh-my-zsh
#

owner=$1
path_prefix=$2


# 1. Clone the repository
git clone git://github.com/robbyrussell/oh-my-zsh.git $path_prefix/.oh-my-zsh
chown -hR  $owner:wheel  $path_prefix/.oh-my-zsh


# 2. OPTIONAL Backup your existing ~/.zshrc file
#cp $path_prefix/.zshrc $path_prefix/.zshrc.orig


# 3. Create a new zsh config by copying the zsh template we’ve provided.
cp -pu  $path_prefix/.oh-my-zsh/templates/zshrc.zsh-template  $path_prefix/.zshrc


exit 0

