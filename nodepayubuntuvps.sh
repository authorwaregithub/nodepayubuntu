#!/bin/bash

# Kullanıcı ve şifre değişkenlerini tanımlayın.

USER="kullaniciadiniz"

PASSWORD="sifreniz"

# Paket listesini güncelleyin.
sudo apt update

# GNOME Masaüstünü yükleyin.
sudo apt install -y ubuntu-desktop

# Uzak masaüstü sunucusunu (xrdp) kurun.
sudo apt install -y xrdp

# USER kullanıcısını ve şifresini ekleyin
sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASSWORD" | sudo chpasswd

# Yönetici hakları için USER kullanıcısını sudo grubuna ekleyin.
sudo usermod -aG sudo $USER

# Xrdp'yi GNOME masaüstünü kullanacak şekilde yapılandırın.
echo "gnome-session" > ~/.xsession

# Xrdp hizmetini yeniden başlatın.
sudo systemctl restart xrdp

# Başlangıçta Xrdp'yi etkinleştirin.
sudo systemctl enable xrdp

# Google Chrome için gerekli bağımlılıkları yükleyin.
sudo apt install -y wget gnupg

# Google depo anahtarını ekleyin.
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Google Chrome deposunu ekleyin.
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Paket listesini tekrar güncelleyin.
sudo apt update

# Google Chrome'u yükleyin.
sudo apt install -y google-chrome-stable

echo "Kurulum tamamlandi. GNOME Desktop, Xrdp ve Google Chrome kuruldu. Artik uzak masaustu uzerinden, kullanici adinizla sunucuya baglanabilirsiniz."
