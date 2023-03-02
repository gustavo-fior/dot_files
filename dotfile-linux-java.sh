#!/bin/bash

NAME="Gustavo Fior"
EMAIL="gustavo.fior@bancosb.com.br"
JAVA_HOME_VARIABLE="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
JRE_HOME_VARIABLE="JRE_HOME=/usr/lib/jvm/java-17-openjdk-amd64/jre"
SWAP_VALUE="vm.swappiness = 20"
USER="bancosb"

echo "############################## Removendo Firefox ##############################"
snap remove firefox

apt update
apt upgrade -y

echo "############################## Pacotes básicos ##############################"
apt install -y curl
apt install -y fish
apt install -y htop
apt install -y vim
apt install -y net-tools
apt install -y wget
apt install -y vlc
apt install -y meld
apt install -y git
apt-get install -y git-flow
apt-get install gitk

echo "############################## Configurando o Git para o e-mail: $EMAIL ##############################"
git config --global user.name $NAME
git config --global user.email $EMAIL

echo "############################## Instalando Gnome Tweaks ##############################"
wget https://launchpad.net/ubuntu/+archive/primary/+files/gnome-tweak-tool_3.26.2.1-1ubuntu1_all.deb -O gnome-tweak-tool.deb
dpkg -i gnome-tweak-tool.deb
apt-get install -f
apt-get remove gnome-tweak-tool --auto-remove
apt install gnome-tweaks

echo "############################## Instalando Java ##############################"
apt install openjdk-17-jdk
apt install openjdk-17-source

echo $JAVA_HOME_VARIABLE >> /etc/environment
echo $JRE_HOME_VARIABLE >> /etc/environment
source /etc/environment

echo "############################## Instalando o Discord ##############################"
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
apt install ~/discord.deb -y

echo "############################## Instalando o Remmina ##############################"
apt install -y remmina

echo "############################## Instalando o Spotify ##############################"
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

apt-get update &&  apt-get install spotify-client -y

echo "############################## Instalando o Postman ##############################"
echo "############################## Infelizmente pelo snap :/ ##############################"
snap install postman

echo "############################## Instalando o Hyper ##############################"
wget -O ~/hyper.deb "https://releases.hyper.is/download/deb"
apt install ~/hyper.deb -y

echo "############################## Customizando o Hyper ##############################"
hyper install hyper-dracula
hyper i hyper-active-tab
hyper i hyper-dark-scrollbar
hyper i hyper-tabs-enhanced

echo "############################## Instalando o Google Chrome ##############################"
wget -O ~/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
apt install ~/google-chrome.deb -y

echo "############################## Instalando o MongoDB Compass ##############################"
wget https://downloads.mongodb.com/compass/mongodb-compass_1.35.0_amd64.deb
sudo dpkg -i mongodb-compass_1.35.0_amd64.deb

echo "############################## Instalando o VS Code ##############################"
apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
apt update
apt install code

echo "############################## Gerando chave SSH para o e-mail: $EMAIL ##############################"
ssh-keygen -t ed25519 -C $EMAIL

echo "############################## Settando Fish como Shell Default ##############################"
chsh -s $(which fish)

echo "############################## Settando Hyper como terminal ##############################"
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /opt/Hyper/hyper 50

echo "############################## Settando VS Code como editor de texto ##############################"
sudo update-alternatives --set editor /usr/bin/code

echo "############################## Instalando o Docker ##############################"
apt update
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt update
apt-cache policy docker-ce
apt install docker-ce
usermod -aG docker ${USER}
su - ${USER}

echo "############################## Instalando o Docker Compose ##############################"
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo "############################## Atualizando o Swap para $SWAP_VALUE ##############################"
echo $SWAP_VALUE >> /etc/sysctl.conf
sysctl -p
swapoff -a
swapon -a
