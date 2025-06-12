# VK Messenger
репозиторий с манифестом для сборки flatpak пакета из rpm пакетв вк мессенджера для Fedora Linux
## Зависимости
1. flatpak-builder
2. wget
3. репозиторий flathub
4. org.freedesktop.Sdk/24.08 из репозитория flathub
## Установка
```
sudo dnf install flatpak-builder wget
flatpak install flathub org.freedesktop.Sdk//24.08
git clone https://github.com/redybicy/com.vk.Messenger
cd com.vk.Messenger
wget https://upload.object2.vk-apps.com/vk-me-desktop-dev-5837a06d-5f28-484a-ac22-045903cb1b1a/latest/vk-messenger.rpm
rpm2cpio vk-messenger.rpm |cpio -idmv
flatpak-builder --repo=repo --force-clean build-dir com.vk.Messenger.yml
flatpak --user remote-add --no-gpg-verify vk-messenger repo
flatpak --user install vk-messenger com.vk.Messenger
```
