#!/usr/bin/bash
#
# Script to install, configure, and deploy a new RHEL 7 Workstation with my own
# custom configurations and changes.
#
# * Author: Justin W. Flory (@jflory7)
# * Date: 2017-10-04
#

# [CONFIGURATION OPTIONS] Change these if your system doesn't follow defaults
CONF_DIR="$HOME/git/conf"


# [INSTALL] Packages for all software
sudo yum install -y epel-release
sudo yum install -y dunst git i3 i3lock i3status task tmux vim

# Just for CentOS / RHEL…
sudo yum install -y python34 python34-pip
sudo pip3 install powerline


# [CREATE] Conf directory, if it doesn't exist yet
if [ ! -d "$CONF_DIR" ]; then
    git clone -q https://github.com/jflory7/conf.git $CONF_DIR
fi


# [CONFIGURE] i3wm
if [ ! -d "$HOME/.i3" ]; then
    mkdir $HOME/.i3
else
    rm $HOME/.i3/config
fi

ln -s $CONF_DIR/i3wm/config $HOME/.i3/config
ln -s $CONF_DIR/i3wm/fuzzy_lock.sh $HOME/.i3/fuzzy_lock.sh
ln -s $CONF_DIR/i3wm/i3exit.sh $HOME/.i3/i3exit.sh
ln -s $CONF_DIR/i3wm/i3status.conf $HOME/.i3status.conf


# [CONFIGURE] bash
if [ -f $HOME/.bashrc ]; then
    rm $HOME/.bashrc
fi
ln -s $CONF_DIR/bash/bashrc $HOME/.bashrc

if [ -f $HOME/.bash_profile ]; then
    rm $HOME/.bash_profile
fi
ln -s $CONF_DIR/bash/bash_profile $HOME/.bash_profile

if [ ! -d "$HOME/wkspc" ]; then
    mkdir -p $HOME/wkspc
fi


# [CONFIGURE] dunst
if [ ! -d "$HOME/.config/dunst" ]; then
    mkdir -p $HOME/.config/dunst
fi
ln -s $CONF_DIR/dunst/dunstrc $HOME/.config/dunst/dunstrc


# [CONFIGURE] git
if [ -f "$HOME/.gitconfig" ]; then
    rm $HOME/.gitconfig
fi
ln -s $CONF_DIR/git/gitconfig $HOME/.gitconfig


# [CONFIGURE] ssh
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p $HOME/.ssh
fi
if [ -f "$HOME/.ssh/config" ]; then
    rm $HOME/.ssh/config
fi
ln -s $CONF_DIR/ssh/config $HOME/.ssh/config


# [CONFIGURE] task
if [ -f "$HOME/.taskrc" ]; then
    rm $HOME/.taskrc
fi
ln -s $CONF_DIR/taskwarrior/taskrc.rhel $HOME/.taskrc

if [ ! -d "$HOME/.bash_completion.d" ]; then
    mkdir -p $HOME/.bash_completion.d
fi
ln -s $CONF_DIR/taskwarrior/task.sh $HOME/.bash_completion.d/task.sh


# [CONFIGURE] tmux
if [ -f "$HOME/.tmux.conf" ]; then
    rm $HOME/.tmux.conf
fi
ln -s $CONF_DIR/tmux/tmux.conf $HOME/.tmux.conf


# [CONFIGURE] vim
if [ -f "$HOME/.vimrc" ]; then
    rm $HOME/.vimrc
fi
ln -s $CONF_DIR/vim/vimrc $HOME/.vimrc

## Set up all vim plugins
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone -q https://github.com/ekalinin/Dockerfile.vim.git $HOME/.vim/bundle/Dockerfile
git clone -q https://github.com/alvan/vim-closetag.git $HOME/.vim/bundle/vim-closetag
git clone -q https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround
