#!/usr/bin/bash
#
# Script to install, configure, and deploy a new CentOS / RHEL 7 Server with
# my own custom configurations and changes.
#
# * Author: Justin W. Flory (@jflory7)
# * Date: 2018-06-05
#

# [CONFIGURATION OPTIONS] Change these if your system doesn't follow defaults
CONF_DIR="$HOME/git/conf"


# [INSTALL] Packages for all software
sudo yum install -y \
    epel-release
sudo yum install -y \
    git \
    python-flake8 \
    task \
    tmux \
    vim

# Just for CentOS / RHEL…
sudo yum install -y \
    python34 \
    python34-pip
pip3 install --user powerline-status


# [CREATE] Conf directory, if it doesn't exist yet
if [ ! -d "$CONF_DIR" ]; then
    git clone -q https://github.com/jflory7/conf.git $CONF_DIR
fi


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


# [CONFIGURE] git
if [ -f "$HOME/.gitconfig" ]; then
    rm $HOME/.gitconfig
fi
ln -s $CONF_DIR/git/gitconfig $HOME/.gitconfig


# [CONFIGURE] powerline
if [ ! -d "/usr/share/powerline/bash" ]; then
    sudo mkdir -p /usr/share/powerline/bash
fi
sudo ln -s /usr/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh /usr/share/powerline/bash/powerline.sh


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
git clone -q https://github.com/mbbill/code_complete.git $HOME/.vim/bundle/code_complete
git clone -q https://github.com/ekalinin/Dockerfile.vim.git $HOME/.vim/bundle/Dockerfile
git clone -q --depth=1 https://github.com/vim-syntastic/syntastic.git $HOME/.vim/bundle/syntastic
git clone -q https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone -q https://github.com/alvan/vim-closetag.git $HOME/.vim/bundle/vim-closetag
git clone -q https://github.com/nvie/vim-flake8.git $HOME/.vim/bundle/vim-flake8
git clone -q https://github.com/honza/vim-snippets.git $HOME/.vim/bundle/vim-snippets
git clone -q https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround

