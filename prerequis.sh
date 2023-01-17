#MISE A JOUR OS
sudo apt-get update
sudo apt upgrade

# PREREQUIS
sudo apt install sudo wget curl pgp ufw git

#Synchronisation NTP
sudo apt-get install ntp
sudo ntpq -p

#Installation RUST
curl https://sh.rustup.rs -sSf | sh -s -- -y