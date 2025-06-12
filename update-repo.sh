#!/bin/bash
read -p "Version: " version_input
VERSION=${version_input:-$(date +%Y%m%d)}
read -p "Link: " link_input
LINK=${link_input:-$(https://upload.object2.vk-apps.com/vk-me-desktop-dev-5837a06d-5f28-484a-ac22-045903cb1b1a/latest/vk-messenger.rpm)}

read -rp "Вы уверены, что хотите продолжить? (д/н): " answer
answer=${answer,,}
if [[ $answer == "н" || $answer == "n" ]]; then
    echo "Операция отменена."
    exit 1
fi

sudo dnf install flatpak-builder
flatpak install flathub org.freedesktop.Sdk//24.08
git clone https://github.com/redybicy/com.vk.Messenger
cd com.vk.Messenger
wget $LINK
rpm2cpio vk-messenger.rpm |cpio -idmv

sed -i "s/^version: .*/version: $VERSION/" com.vk.Messenger.yml
flatpak-builder --repo=vk-messenger --force-clean --gpg-sign=0F47C3E83CE3D7F086EF4A3C0921572033AEB5B3 build-dir com.vk.Messenger.yml
cd vk-messenger
git init
git add .
git commit -m "$VERSION"
git remote add origin git@github.com:redybicy/vk-messenger.git
git push -u origin main

flatpak remove org.freedesktop.Sdk//24.08
sudo dnf remove flatpak-builder
