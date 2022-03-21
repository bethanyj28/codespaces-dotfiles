#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# When setting up a codespace, we might run into an apt race condition
# We need to make sure a different process doesn't have a lock before proceeding
# When it does, the error will be one of 2:
#   Could not get lock /var/lib/apt/lists/lock
#   Could not get lock /var/lib/dpkg/lock-frontend
function apt_with_lock_protection() {
  while sudo apt-get -y $1 2>&1 | tee -a ~/apt_log | grep -q "Could not get lock" ; do
    echo "Waiting for other apt-get instances to exit"
    sleep 1
  done
}
# Install curl, tar, git, other dependencies if missing
PACKAGES_NEEDED="\
    silversearcher-ag \
    bat \
    fuse \
    dialog \
    apt-utils \
    libfuse2"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        sudo apt-get update
        apt_with_lock_protection "update"
    fi
    apt_with_lock_protection "-q install ${PACKAGES_NEEDED}"
fi

# sudo apt-get --assume-yes install silversearcher-ag bat fuse

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"
# wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
ln -s $(pwd)/emacs $HOME/.emacs
ln -s $(pwd)/screenrc $HOME/.screenrc
rm -f $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/bash_profile $HOME/.bash_profile

rm -rf $HOME/.config
mkdir $HOME/.config
ln -s "$(pwd)/config/nvim" "$HOME/.config/nvim"

nvim +'PlugInstall --sync' +qa

vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"

sudo chsh -s "$(which zsh)" "$(whoami)"


