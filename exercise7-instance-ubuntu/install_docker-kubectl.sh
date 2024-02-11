#!/bin/bash 

## Update the apt Package Index:
sudo apt-get update

## Install Packages to Allow apt to Use a Repository Over HTTPS:
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

## Add Docker’s Official GPG Key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## Set Up the Stable Repository:
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Update the apt Package Index (again):
sudo apt-get update

### Install the Latest Version of Docker CE and Containerd:
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

### Verify that Docker CE Is Installed Correctly:
sudo docker run hello-world

### kubectl Installation

## Install kubectl binary
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

## downlaod  the kubectl checksum file to validate the binary 
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

## validate the kubectl binary against thec checksum file
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

## install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## Minikube Installation 
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

## Add your user to docker group
sudo usermod -aG docker $USER && newgrp docker

minikube start --driver=docker



