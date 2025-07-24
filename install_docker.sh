

sudo apt update $$ sudo apt upgrade

#If the kernel upgrades, you’ll want to reboot the server with the command:

#sudo reboot

sudo apt install docker.io

sudo usermod -a -G docker $USER

sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker

newgrp docker

sudo systemctl start docker

sudo systemctl enable docker


sudo systemctl stop docker

sudo systemctl restart docker