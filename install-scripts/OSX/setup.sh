# Update /usr/local path ownership to current user
sudo chown -R $(whoami):admin /usr/local

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update

#==============
# Backup old dotflies
#==============
mkdir ~/dotfiles_backup_$(date +"%Y%m%d%H%M%S")
sudo cp -r ~/.vim ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.vimrc ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.bashrc ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.tmux ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.tmux.conf ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.zshrc_prompt ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.zshrc ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.gitconfig ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/.psqlrc ~/dotfiles_backup > /dev/null 2>&1
sudo cp -r ~/.config ~/dotfiles_backup > /dev/null 2>&1
sudo cp ~/Brewfile ~/dotfiles_backup > /dev/null 2>&1

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
ln -sf ~/dotfiles/config/tmux ~/.tmux
SYMLINKS+=('.tmux')
ln -sf ~/dotfiles/config/zsh/zsh_prompt ~/.zsh_prompt
SYMLINKS+=('.zsh_prompt')
ln -sf ~/dotfiles/config/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
ln -sf ~/dotfiles/config ~/.config
SYMLINKS+=('.config')
ln -sf ~/dotfiles/custom-configs/custom-snips ~/.vim/custom-snips
SYMLINKS+=('.vim/custom-snips')
ln -sf ~/dotfiles/config/homebrew/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')
ln -s ~/dotfiles/config/git/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')
ln -s ~/dotfiles/config/tmux/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')
ln -s ~/dotfiles/config/editorconfig/editorconfig ~/.editorconfig
SYMLINKS+=('.editorconfig')

echo "The following symlinks have been created:\n ${SYMLINKS[@]}"

# Ensure we use all of the packages we are about to install
echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
source ~/.bashrc

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
