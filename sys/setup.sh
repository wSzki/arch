# Acpi = Battery monitor
# check acpi_listen for ac handler
# add user to video group for backlight control
# acpi backlight
# install alsamixer pactl utils for audio
# pavucontrol pulseaudio control GUI
sudo pacman -S --noconfirm acpi
sudo pacman -S --noconfirm acpid
sudo pacman -S --noconfirm acpilight

sudo usermod -a -G video $LOGNAME

# Low latency audio
sudo cp ./wszaudio.service /etc/systemd/system/
sudo cp ./ufwmonitor.service /etc/systemd/system/

# Low Battery
sudo cp ./99-lowbat.rules /etc/udev/rules.d/
# Touchpad Sensitivity
sudo cp ./40-touchpad.conf /etc/X11/xorg.conf.d/
# Boot notimeout
sudo cp ./loader.conf /boot/loader # 5 sec timeout
# Lid Suspend
sudo cp ./logind.conf /etc/systemd/ # Suspend when lid close
# Suspend activates Slock
sudo cp ./slock@.service /etc/systemd/system
# Exec Powertop on boot
sudo cp ./powertop.service /etc/systemd/system
# Autologin
sudo cp ./override.conf /etc/systemd/system/getty@tty1.service.d/
# Handles AC / Battery Governor
#sudo cp ./handler.sh /etc/acpi/

sudo cp ./tlp.conf /etc/tlp.conf


sudo systemctl enable --now slock@wsz.service
sudo systemctl enable --now acpid.service
sudo systemctl enable --now powertop.service

# Ethernet
#sudo systemctl enable --now dhcpd.service

# Lower system timeout at shutdown
sudo sed -i 's/\#DefaultTimeoutStartSec=90s/DefaultTimeoutStartSec=10s/' /etc/systemd/system.conf
sudo sed -i 's/\#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=10s/' /etc/systemd/system.conf
