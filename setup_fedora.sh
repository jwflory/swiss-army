#!/usr/bin/bash
#
# Script to install, configure, and deploy a new Fedora Workstation with my own
# custom configurations and changes.
#
# * Author: Justin W. Flory (@jflory7)
# * Date: 2018-06-05
#

# [CONFIGURATION OPTIONS] Change these if your system doesn't follow defaults
CONF_DIR="$HOME/git/conf"


# [INSTALL] Packages for all software
sudo dnf install -y \
    dunst \
    git \
    gnome-shell-extension-pomodoro \
    i3 \
    i3lock \
    i3status \
    jpegoptim \
    jq \
    meld \
    network-manager-applet \
    npm \
    pass \
    pavucontrol \
    powerline \
    pulseaudio-utils \
    python2-flake8 \
    python3-flake8 \
    strace \
    task \
    tmux \
    tmux-powerline \
    vim \
    which

## Package notes:
## * dunst: Simple and configurable notification-daemon
## * jpegoptim: Utility to optimize JPEG files
## * meld: Visual diff and merge tool
## * network-manager-applet: Network control / status applet for NetworkManager

# [CREATE] Conf directory, if it doesn't exist yet
if [ ! -d "$CONF_DIR" ]; then
    git clone -q https://github.com/jflory7/conf.git $CONF_DIR
fi


# [CONFIGURE] i3wm
if [ ! -d "$HOME/.config/.i3" ]; then
    mkdir -p $HOME/.config/i3
else
    rm $HOME/.config/i3/config
fi
ln -s $CONF_DIR/i3wm/config $HOME/.config/i3/config
ln -s $CONF_DIR/i3wm/fuzzy_lock.sh $HOME/.config/i3/fuzzy_lock.sh
ln -s $CONF_DIR/i3wm/i3exit.sh $HOME/.config/i3/i3exit.sh
ln -s $CONF_DIR/i3wm/i3status.conf $HOME/.config/i3/i3status.conf


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
if [ -f "$HOME/.gitconfig-jump" ]; then
    rm $HOME/.gitconfig-jump
fi
if [ -f "$HOME/.gitconfig-unicef" ]; then
    rm $HOME/.gitconfig-unicef
fi
ln -s $CONF_DIR/git/gitconfig $HOME/.gitconfig
ln -s $CONF_DIR/git/gitconfig-jump $HOME/.gitconfig-jump
ln -s $CONF_DIR/git/gitconfig-unicef $HOME/.gitconfig-unicef


# [CONFIGURE] npm
mkdir $HOME/.npm-global
npm config set prefix '${HOME}/.npm-global'


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
ln -s $CONF_DIR/taskwarrior/taskrc.fedora $HOME/.taskrc

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
git clone -q https://github.com/mbbill/code_complete.git $HOME/.vim/bundle/code_complete
git clone -q https://github.com/ekalinin/Dockerfile.vim.git $HOME/.vim/bundle/Dockerfile
git clone -q --depth=1 https://github.com/vim-syntastic/syntastic.git $HOME/.vim/bundle/syntastic
git clone -q https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone -q https://github.com/alvan/vim-closetag.git $HOME/.vim/bundle/vim-closetag
git clone -q https://github.com/nvie/vim-flake8.git $HOME/.vim/bundle/vim-flake8
git clone -q https://github.com/mitsuhiko/vim-jinja.git $HOME/.vim/bundle/vim-jinja
git clone -q https://github.com/honza/vim-snippets.git $HOME/.vim/bundle/vim-snippets
git clone -q https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround

