#!/bin/bash

# Get a reference to the current direcctory
CWD=`pwd`

# Update
apt update && apt -y upgrade 

# Install deps w/o interaction
DEBIAN_FRONTEND=noninteractive apt install -y \
	build-essential \
	git \
	vim \
	iptables-persistent \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common \
	gcc

# Set default iptables. Block all ipv6.
iptables -I INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -j LOG --log-prefix "**DROP IN**"
iptables -A INPUT -j DROP
iptables-save > /etc/iptables/rules.v4

ip6tables -I INPUT -j DROP
ip6tables-save > /etc/iptables/rules.v6

# Install Gvisor
curl -fsSL https://gvisor.dev/archive.key | sudo apt-key add -
add-apt-repository "deb https://storage.googleapis.com/gvisor/releases release main"
DEBIAN_FRONTEND=noninteractive apt update && apt -y install runsc

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
DEBIAN_FRONTEND=noninteractive apt update && apt -y install docker-ce docker-ce-cli containerd.io

# Chmod all scripts
chmod 755 ./*

# Configure Docker runsc runtime
runsc install
systemctl restart docker

# Install Mcrccon for management
cd /tmp && git clone https://github.com/Tiiffi/mcrcon.git
cd mcrcon
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
mv mcrcon /usr/bin
chmod 755 /usr/bin/mcrcon

# Go back to working directory
cd $CWD

clear
echo
echo "Install complete."
echo
# Version info
echo "[+] Docker Version:"
docker version
echo "[+] Mcrcon Version:"
mcrcon -v
echo "[+] Gvisor runsc Version:"
runsc -version
