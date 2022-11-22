#!/bin/sh


mkdir -p ~/.tmp && cd ~/.tmp

# ADBLOCK
git  clone git://r-36.net/hosts-gen
cd   hosts-gen
sudo make install
sudo cp examples/gethostszero /bin
sudo chmod 775 /bin/gethostszero
sudo /bin/gethostszero
sudo hosts-gen

# SSH
ssh-keygen

# USER GROUPS
sudo groupadd \
	dialout

sudo usermod -aG \
	audio     \
	docker    \
	nix-users \
	video     \        # BRIGHTNESS
	uucp dialout \    # DIRTYWAVE M8
	$USER


# Lower system timeout at shutdown
sudo sed -i 's/\#DefaultTimeoutStartSec=90s/DefaultTimeoutStartSec=10s/' /etc/systemd/system.conf
sudo sed -i 's/\#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=10s/'   /etc/systemd/system.conf

cd ~/.dot/sys
sudo cp ./wszaudio.service /etc/systemd/system/  	# Low latency   audio
sudo cp ./99-lowbat.rules  /etc/udev/rules.d/    	# Low Battery   rules
sudo cp ./40-touchpad.conf /etc/X11/xorg.conf.d/ 	# Touchpad Sensitivity
sudo cp ./loader.conf      /boot/loader          	# remove 5 sec timeout at boot
sudo cp ./lid_sleep.conf   /etc/systemd/logind.conf # Suspend when lid is closed
sudo cp ./slock@.service   /etc/systemd/system      # Suspend activates Slock
sudo cp ./powertop.service /etc/systemd/system      # Exec Powertop  on  boot
sudo cp ./override.conf    /etc/systemd/system/getty@tty1.service.d/ # Autologin (autostartx)


sudo ln -s ~/.dot/sys/tlp.conf /etc/tlp.conf

sudo systemctl enable --now slock@wsz.service
sudo systemctl enable --now acpid.service
sudo systemctl enable --now powertop.service
sudo systemctl enable --now tlp.service
sudo systemctl enable --now ufw.service
sudo systemctl enable --now nix-daemon.service

# Ethernet
#sudo systemctl enable dhcpd.service
#sudo systemctl start dhcpd.service

cd -
