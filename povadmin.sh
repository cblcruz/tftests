#!/usr/bin/bash

# Determine the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
elif [ -f /etc/system-release-cpe ]; then
    OS=$(awk -F':' '{print $3}' /etc/system-release-cpe)
else
    echo "Unsupported Linux distribution"
    exit 1
fi

# Add user and set up ssh access
if [ $OS == "ubuntu" ]; then
    adduser povadmin --home "/home/povadmin" --gecos "POV user" --disabled-password
    usermod -aG sudo povadmin
    echo 'povadmin   ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
    mkdir -p /home/povadmin/.ssh
    chown -R povadmin:povadmin /home/povadmin/
    chmod 700 /home/povadmin/.ssh
    chmod 644 /home/povadmin/.ssh/authorized_keys
elif [ $OS == "rhel" ]; then
    useradd -m -s /bin/bash povadmin
    echo 'povadmin   ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    mkdir -p /home/povadmin/.ssh
    chown -R povadmin:povadmin /home/povadmin/
    chmod 700 /home/povadmin/.ssh
    chmod 644 /home/povadmin/.ssh/authorized_keys
elif [ $OS == "amzn" ]; then
    useradd -m -s /bin/bash povadmin
    echo 'povadmin   ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    mkdir -p /home/povadmin/.ssh
    chown -R povadmin:povadmin /home/povadmin/
    chmod 700 /home/povadmin/.ssh
    chmod 644 /home/povadmin/.ssh/authorized_keys
else
    echo "Unsupported Linux distribution"
    exit 1
fi
