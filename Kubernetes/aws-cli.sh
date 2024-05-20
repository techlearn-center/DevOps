#!/bin/bash

echo "Updating package index..."
sudo apt update

echo "Installing dependencies..."
sudo apt install unzip curl -y

echo "Downloading AWS CLI installation script..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "Unzipping the installation script..."
unzip awscliv2.zip

echo "Running the installation script..."
sudo ./aws/install

echo "Cleaning up..."
rm -rf awscliv2.zip aws

echo "Verifying AWS CLI installation..."
aws --version

echo "AWS CLI installation complete."
