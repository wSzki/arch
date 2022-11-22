#!/bin/sh

# PACMAN
################################################

read -ep "UPDATE? Y/N " UPDATE
if [ $UPDATE == 'y' ]; then
	sudo cp ~/.dot/sys/pacman.conf /etc/pacman.conf
	sudo pacman -Syu --noconfirm
fi

read -ep "PACMAN INSTALL? Y/N " PACMAN
if [ $PACMAN == 'y' ]; then
# CORE
sudo pacman -S --noconfirm \
	zsh                 \
	fasd                \
	fzf                 \
	ack                 \
	vim                 \
	git                 \
	trash-cli           \
	tldr                \
	neovim              \
	nodejs              \
	xclip               \
	nix                 \
	wget                \
	tar                 \
	zip                 \
	unzip               \
	curl                \
	tlp                 \
	bat                 \
	polkit              \
	jq                  \
	the_silver_searcher \
	fd                  \
	python-pynvim       \
	core/man-pages      \


# XORG
sudo pacman -S --noconfirm \
	xorg       \
	xorg-xinit \
	kitty      \
	rofi \
	nemo \
	i3-gaps    \
	python-i3ipc \
	i3status   \
	i3blocks   \
	unclutter  \
	arandr     \
	autorandr  \
	xbindkeys  \
	xautolock  \
	acpilight  \
	pacman-contrib \

# MISC
sudo pacman -S --noconfirm \
	pavucontrol         \
	yt-dlp              \
	feh                 \
	dust                \
	duf                 \
	hub                 \
	ncdu                \
	mpv                 \
	#youtube-dl          \
	#torbrowser-launcher \

# FONTS
sudo pacman -S --noconfirm \
	ttf-inconsolata \
	ttf-nerd-fonts-symbols-mono \
	ttf-roboto-mono \
	ttf-font-awesome \

fi

# AUR
################################################

echo "CHOOSE AUR PACKAGE MANAGER"
echo "[0] Paru"
echo "[1] Pikaur"
echo "[2] Yay"
read -ep "> " AUR_PM

if [ $AUR_PM == '0' ]; then
	sudo pacman -S --needed base-devel
	cd ~
	git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si
	cd ..   && rm -rf ./paru
	AUR_PM="paru"

elif [ $AUR_PM == '1' ]; then
	sudo pacman -S --needed base-devel git
	git clone https://aur.archlinux.org/pikaur.git
	cd pikaur
	makepkg -fsri
	cd ..   && rm -rf ./pikaur
	AUR_PM="pikaur"

elif [ $AUR_PM == '2' ]; then
	pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	AUR_PM="yay"
else
	AUR_PM=""
fi

# PACKAGES
read -ep "INSTALL AUR PACKAGES? Y/N " AUR_PACKAGES
if [ $AUR_PACKAGES == 'y' ]; then
	if [ AUR_PM != "" ]; then
		$AUR_PM -S --noconfirm \
			librewolf-bin \
			greenclip     \
			#tmpmail-git \

		# ADDITIONAL FONTS AND THEMES
		$AUR_PM -S --noconfirm \
			ttf-scientifica             \
			ttf-inconsolata             \
			ttf-weather-icons           \
			ttf-nerd-fonts-symbols-mono \
			ttf-roboto-mono             \
			ttf-font-awesome            \
			terminus-font               \
			nordic-darker-theme         \

	fi
fi

read -ep "SLOCK INSTALL? Y/N " SLOCK
if [ $SLOCK == 'y' ]; then
	cd ~/.dot/bin/suckless/slock
	sudo make clean install
fi

# NIX
#####################################
 nix-env -iA nixpkgs.direnv
