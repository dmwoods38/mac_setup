#!/bin/bash

# Disable natural scrolling
defaults write -g com.apple.swipescrolldirection -boolean NO

# Turn on lockscreen hotcorner
defaults write com.apple.dock wvous-tl-corner -int 13
killall Dock

# uses https://gist.github.com/bradp/bea76b16d3325f5c47d4 as a starting point
# install xcode things
xcode-select --install
# enable developer mode allows debugger authorization once per session instead of per use
# sudo /usr/sbin/DevToolsSecurity -enable
# sudo dscl . append /Groups/_developer GroupMembership $(whoami)

# install homebrew and update note this location is for apple silicon
curl -LJO https://github.com/Homebrew/brew/releases/download/4.2.4/Homebrew-4.2.4.pkg
shasum Homebrew-4.2.4.pkg >/tmp/homebrewchecksum
diff /tmp/homebrewchecksum homebrewchecksum
error=$?
if [ $error -ne 0 ]; then
	echo "Homebrew did not pass checksum, exiting."
	exit 1
fi
installer -pkg Homebrew-4.2.4.pkg /opt/homebrew
brew update
brew install git
# configure git
echo "Don't forget to set git user name and email if necessary"
echo "Don't forget to setup SSH keys"
# install nerdfonts
brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font

brew install wget
brew install curl
brew install jq

brew install neovim
brew install gcc
brew install ripgrep
brew install fd

brew install go
brew install delve

brew install nmap
brew install netcat
# install go-sec and govulncheck
go install github.com/securego/gosec/v2/cmd/gosec@latest
go install golang.org/x/vuln/cmd/govulncheck@latest

# install gopls
go install golang.org/x/tools/gopls@latest

brew install python
pip install virtualenv

brew install awscli
brew install kubernetes-cli
brew install kubernetes-helm
brew install terraform
brew install docker
brew install docker-completion

# install oh-my-zsh
curl -LJO https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
shasum install.sh >/tmp/ohmyzshchecksum
diff /tmp/ohmyzshchecksum ohmyzshchecksum
error=$?
if [ $error -ne 0 ]; then
        echo "Ohmyzsh did not pass checksum, exiting."
        exit 1
fi

apps=(
	firefox
	google-chrome
	iterm2
	slack
	virtualbox
	notion
	visual-studio-code
	zoomus
	burp-suite-professional
	pycharm
	nordvpn
	postman
	keepassxc
)

# install apps
brew cask install --appdir="/Applications" ${apps[@]}

# brew cleanup
brew cleanup

# will need to pull my config from github
mkdir ~/.config
cp -R ./.config/nvim ~/.config/
cp ./dotfiles/* ~/
