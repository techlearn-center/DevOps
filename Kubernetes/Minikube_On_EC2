### Step 1: Create an AWS EC2 instance with Ubuntu 22

Create an EC2 instance with Ubuntu 22.04 (the latest for the moment) operating system by using the terraform scripts here https://github.com/techlearn-center/DevOps/tree/Terraform/exercise7-instance-ubuntu

Instance Size: t2.large with 2 CPUs, 32 GB Storage

(P.Note: this configuration will not be in a free tier and you will get billed for it. Therefore, pls make sure to shutdown the server instance, whenever you do not use it).

### Step 2 : Install Docker
If you used the terraform scripts in step 1, then docker has been installed if not follow the steps in the link below
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04?source=post_page-----e845337a956--------------------------------

### Step 3 : Install Kubectl

Kubectl is a utility to manage a K8 cluster. Hence it is required to install it before you configure / install the K8 cluster.
Once the Docker installation is completed, use the following link [3] to install Kubectl on it.

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

###Step 4: Install Minikube
Once both Docker and Kubectl are installed, you may use following set of commands to install Minikube.

https://minikube.sigs.k8s.io/docs/start/

sudo usermod -aG docker $USER && newgrp docker

minikube start --driver=docker
