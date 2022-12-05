#!/bin/bash 

NAME="Gustavo Fior"
EMAIL="gustavo.fior@sbcash.com.br"
JAVA_HOME_VARIABLE="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
JRE_HOME_VARIABLE="JRE_HOME=/usr/lib/jvm/java-17-openjdk-amd64/jre"
SWAP_VALUE="vm.swappiness = 20"
USER="bancosb"

echo "############################## Removendo Firefox ##############################"
sudo snap remove firefox

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

echo "############################## Instalando o Docker ##############################"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo usermod -aG docker ${USER}
su - ${USER}

echo "############################## Instalando o Docker Compose ##############################"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo "############################## Instalando o Discord ##############################"
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ~/discord.deb -y

echo "############################## Instalando o Remmina ##############################"
apt install -y remmina

echo "############################## Instalando o IntelliJ ##############################"
sudo apt update
sudo apt install software-properties-common apt-transport-https wget

wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"

sudo apt install atom

echo "############################## Instalando o Spotify ##############################"
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client -y

echo "############################## Instalando o Postman ##############################"
wget https://gist.githubusercontent.com/SanderTheDragon/1331397932abaa1d6fbbf63baed5f043/raw/postman-deb.sh
sudo install -m0755 postman-deb.sh /usr/local/bin/postman-deb.sh
postman-deb.sh -y

echo "############################## Instalando o Hyper ##############################"
wget -O ~/hyper.deb "https://releases.hyper.is/download/deb"
sudo apt install ~/hyper.deb -y

echo "############################## Instalando o Google Chrome ##############################"
wget -O ~/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install ~/google-chrome.deb -y

echo "############################## Instalando o MongoDB Compass ##############################"
wget https://downloads.mongodb.com/compass/mongodb-compass_1.15.1_amd64.deb
sudo dpkg –i mongodb-compass_1.15.1_amd64.deb

echo "############################## Gerando chave SSH para o e-mail: $EMAIL ##############################"
ssh-keygen -t ed25519 -C $EMAIL

echo "############################## Atualizando o Swap para $SWAP_VALUE ##############################"
echo $SWAP_VALUE >> /etc/sysctl.conf
sysctl -p
sudo swapoff -a
sudo swapon -a
