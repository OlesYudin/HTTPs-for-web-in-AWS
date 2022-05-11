#!/bin/bash
sudo apt update
sudo apt dist-upgrade -y
# Install Apache web-server into EC2 instance
sudo apt install -y apache2 