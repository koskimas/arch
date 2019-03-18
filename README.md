# Install

```bash
loadkeys fi
pacman -Sy terminus-font
setfont ter-v32n
timedatectl set-ntp true
gdisk /dev/nvme0n1
# TYPE: o y n enter enter +512MB EF00 n enter enter enter enter w y
cryptsetup -y -v luksFormat /dev/nvme0n1p2
# TYPE: YES
cryptsetup open /dev/nvme0n1p2 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
mkfs.vfat /dev/nvme0n1p1
cd /mnt
mkdir boot
mount /dev/nvme0n1p1 /mnt/boot
cd
pacstrap /mnt
arch-chroot /mnt
pacman -S git
git config --global user.email "leeloo@dallas.com"
git config --global user.name "Sami Koskimäki"
cd
git clone https://github.com/koskimas/arch.git
cd /
bootctl install
cp /root/arch/etc/mkinitcpio.conf /etc/
cp /root/arch/boot/loader/loader.conf /boot/loader/
cp /root/arch/boot/loader/entries/arch.conf /boot/loader/entries/
# NOTE: replace the UUID in loader/entries/arch.conf by UUID of nvme0n1p2 in blkid
mkinitcpio -p linux
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
hwclock --systohc
cp /root/arch/etc/locale.gen /etc/
locale-gen
cp /root/arch/etc/locale.conf /etc/
cp /root/arch/etc/vconsole.conf /etc/
cp /root/arch/etc/hostname /etc/
cp /root/arch/etc/hosts /etc/
passwd
exit
reboot
```

```bash
useradd -m samiko
passwd samiko
dhcpcd
```

### SSH

```bash
pacman -S openssh sudo
systemctl enable sshd.socket
cat /root/arch/etc/sudoers > /etc/sudoers
reboot
```

### Xorg

```bash
pacman -S xorg-server xorg-apps
cp /root/arch/etc/X11/xorg.conf.d/* /etc/X11/xorg.conf.d/
cp /root/arch/etc/xprofile /etc/
```

### Display manager

```bash
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm.service
cp /root/arch/etc/lightdm/* /etc/lightdm/
cp /root/arch/usr/share/pixmaps/* /usr/share/pixmaps
```

### Fonts

```bash
pacman -S ttf-dejavu ttf-roboto ttf-droid
```

### GTK stuff

```bash
pacman -S arc-solid-gtk-theme arc-icon-theme
cp -r /root/arch/etc/gtk-* /etc/
```

### Awesome

```bash
pacman -S awesome
mkdir -p /home/samiko/.config/awesome/
cp /root/arch/home/samiko/.config/awesome/rc.lua /home/samiko/.config/awesome/ or cp /etc/xdg/awesome/rc.lua /home/samiko/.config/awesome/
```

### NetworkManager

```bash
pacman -S networkmanager network-manager-applet gnome-keyring
systemctl enable NetworkManager.service
```

### Backlight

```bash
aurman -S acpilight
gpasswd -a samiko video
```

### VSCode

```bash
aurman -S visual-studio-code-bin
```

## Sources

```bash
https://www.youtube.com/watch?v=rT7h62OYQv8
```
