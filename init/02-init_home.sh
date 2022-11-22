#!/bin/sh

cd $HOME

RCol='\e[0m'
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';

function LINK_CONFIG()
{
	if [ -d ~/.config/$1 ]; then
		mv ~/.config/$1 ~/.config.backup;
	fi
	ln -vs ~/.dot/config/$1 ~/.config/$1
}

function LINK_DOTFILES()
{
	if [ -f ~/.$2 ]; then
		mv ~/.$2 ~/.config.backup;
	fi
	ln -vs  ~/.dot/config/$1/$2 ~/.$2
}


read -ep "INSTALL CONFIG? Y/N " CONFIRM
if [ $CONFIRM == 'y' ]; then


	echo -e "$Whi ### REMOVING OLD BACKUP"
	echo -en "$Red"
	rm -vrf          ~/.config.backup
	echo -en "$Gre"
	mkdir -vp        ~/.config.backup
	mkdir -vp ~/.config

	echo -e "$Whi ### CREATING GITCONFIG"
	echo -en "$Cya"
	mv -v ~/.gitconfig ~/.config.backup
	echo "[user]"                        > ~/.gitconfig
	echo "   email = $USER@$HOSNAME.com" > ~/.gitconfig
	echo "   name  = $USER"              > ~/.gitconfig

	echo -e "$Whi ### LINKING DOTFILES"
	echo -en "$Cya"
	LINK_DOTFILES zsh  zshrc
	LINK_DOTFILES zsh  zprofile
	LINK_DOTFILES xorg xinitrc
	LINK_DOTFILES xorg xbindkeysrc
	LINK_DOTFILES xorg Xresources
	LINK_DOTFILES tmux tmux.conf

	echo -e "$Whi### LINKING CONFIG"
	echo -en "$Cya"
	LINK_CONFIG i3
	LINK_CONFIG i3-overview
	LINK_CONFIG i3expo
	LINK_CONFIG bat
	LINK_CONFIG ranger
	LINK_CONFIG rofi
	LINK_CONFIG mps-youtube
	LINK_CONFIG kitty
	LINK_CONFIG nvim
	LINK_CONFIG zsh
	LINK_CONFIG coc
	LINK_CONFIG ytfzf
	LINK_CONFIG bat
	LINK_CONFIG i3expo
	LINK_CONFIG xsuspender
	LINK_CONFIG dunst
	LINK_CONFIG cointop
	LINK_CONFIG mpv
	LINK_CONFIG autorandr
	LINK_CONFIG cardboard
	LINK_CONFIG conky
	LINK_CONFIG fish
	LINK_CONFIG cava
	LINK_CONFIG fltrdr

	echo -en "$RCol"

fi
