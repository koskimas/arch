# Install

```bash
loadkeys fi
pacman -S terminus-font git
setfont ter-v32n
git clone https://github.com/koskimas/arch.git
timedatectl set-ntp true
gdisk /dev/nvme0n1
KEYS: o y n enter enter +512MB EF00 n enter enter enter enter w y
cryptsetup -y -v luksFormat /dev/nvme0n1p2
KEYS: YES
cryptsetup open /dev/nvme0n1p2 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
mkfs.vfat /dev/nvme0n1p1
cd /mnt
mkdir boot
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt
arch-chroot /mnt
pacman -S git
git config --global user.email "koskomi@gmail.com"
git config --global user.name "Sami Koskimäki"
cd /root
git clone https://github.com/koskimas/arch.git
cd ..
bootctl install
cp /root/mkinitcpio.conf /etc/
cp /root/boot/loader/loader.conf /boot/loader/
cp /root/boot/loader/entries/arch.conf /boot/loader/entries/
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
reboot
```

```bash
useradd -m samiko
passwd samiko
```

### SSH

```bash
pacman -S openssh
systemctl enable sshd.socket
cat /root/arch/etc/sudoers > /etc/sudoers
```

### Xorg

```bash
pacman -S xorg-server xorg-apps
cp /root/arch/X11/xorg.conf.d/* /etc/X11/xorg.conf.d/
```

### Display manager

```bash
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm.service
cp /root/arch/etc/lightdm/* /etc/lightdm/
```

### Fonts

```bash
pacman -S ttf-dejavu ttf-roboto ttf-droid
```

### GTK stuff

```bash
pacman -S arc-solid-gtk-theme arc-icon-theme
cp /root/arch/etc/gtk-* /etc/
```

### Awesome

```bash
pacman -S awesome
mkdir -p ~/.config/awesome/
cp /root/arch/home/samiko/.config/awesome/rc.lua ~/.config/awesome/ or cp /etc/xdg/awesome/rc.lua ~/.config/awesome/
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
