#==============
# Install packages
#==============

# Update /usr/local path ownership to current user
sudo chown -R $(whoami):admin /usr/local

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

# Ensure we use all of the packages we are about to install
echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
source ~/.bashrc

#==============
# Backup old dotflies
#==============
mkdir dotfiles_backup
sudo mv ~/.vim dotfile_backup > /dev/null 2>&1
sudo mv ~/.vimrc dotfile_backup > /dev/null 2>&1
sudo mv ~/.bashrc dotfile_backup > /dev/null 2>&1
sudo mv ~/.tmux dotfile_backup > /dev/null 2>&1
sudo mv ~/.tmux.conf dotfile_backup > /dev/null 2>&1
sudo mv ~/.zshrc_prompt dotfile_backup > /dev/null 2>&1
sudo mv ~/.zshrc dotfile_backup > /dev/null 2>&1
sudo mv ~/.gitconfig dotfile_backup > /dev/null 2>&1
sudo mv ~/.psqlrc dotfile_backup > /dev/null 2>&1
sudo mv ~/.config dotfile_backup > /dev/null 2>&1
sudo mv ~/Brewfile dotfile_backup > /dev/null 2>&1

#==============
# Remove old dot flies
#==============
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zsh_prompt > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.psqlrc > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1
sudo rm -rf ~/Brewfile > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir with the -f flag
#==============
SYMLINKS=()
ln -sf ~/dotfiles/config/vim ~/.vim
SYMLINKS+=('.vim')
ln -sf ~/dotfiles/config/vim/vimrc ~/.vimrc
SYMLINKS+=('.vimrc')
ln -sf ~/dotfiles/config/bash/bashrc ~/.bashrc
SYMLINKS+=('.bashrc')
ln -sf ~/dotfiles/mac-tmux ~/config/tmux/.tmux
SYMLINKS+=('.tmux')
ln -sf ~/dotfiles/config/zsh/zsh_prompt ~/.zsh_prompt
SYMLINKS+=('.zsh_prompt')
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
ln -sf ~/dotfiles/config ~/.config
SYMLINKS+=('.config')
ln -sf ~/dotfiles/custom-configs/custom-snips ~/.vim/custom-snips
SYMLINKS+=('.vim/custom-snips')
ln -sf ~/dotfiles/config/homebrew/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')
ln -s ~/dotfiles/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')
ln -s ~/dotfiles/mac-tmux/tmux.conf ~/config/tmux/.tmux.conf
SYMLINKS+=('.tmux.conf')

echo "The following symlinks have been created:\n ${SYMLINKS[@]}"

cd ~
brew bundle
cd -

#==============
# Set zsh as default shell
#==============
chsh -s /bin/zsh

#==============
# Setup nvim plugin installer
#==============
mkdir -p ~/.local

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp ../../custom-configs/init.vim ~/.config/nvim/init.vim

#==============
# Finished
#==============
echo -e "\n====== Installation complete ======\n"
