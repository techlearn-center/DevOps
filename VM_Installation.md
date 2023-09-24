## VM Installation with Vagrant
Before you begin with this, make sure you have followed the instructions in ```prereq_docs.md``` to install vagrant

For Windows users open Git bash, for Mac OS users open terminal. Execute the command
```
pwd
```
This command shows the present working directory.
We will be creating our files in c drive. Mac OS users should be using Desktop as ``` cd `Desktop/```. Let's change directory to that location
```
cd /c/
```
Now we will create a directory/folder called vagrant_vms in this location 
```
mkdir vagrant_vms
```
Execute ```pwd``` command to see your location and change directory to the newly created directory.
```
cd vagrant_vms
```
In this directory, we will create two directories centos and ubuntu. Before that, let's execute the list command to see if there is anything in the directory
```
ls
```
Create the two directories
```
mkdir centos
```
```
mkdir ubuntu
```
Execute the ```ls``` command to see the two directories you created.
Let's change directory into centos 
```
cd centos
```
```
pwd
```
Click on the link below and search for centos 9

https://app.vagrantup.com/boxes/search

#### Centos
We will be using the eurolinux-vagrant/centos-stream-9 image/box.
Go to git bash now and type:
```
vagrant init eurolinux-vagrant/centos-stream-9
```
```
ls
```
You can now see a vagrantfile in this location. Execute the ```cat``` command to see the content of the file
```
cat Vagrantfile
```
To issue the command below, please make sure you are in the correct folder. Type ```pwd``` to make sure you are in this location /c/vagrant_vms/centos/
```
vagrant up
```
```
vagrant box list
```
```
vagrant status
```
To login to the VM, issue the vagrant ssh command below:
```
vagrant ssh
```
We are in the centos VM now. You can see the prompt has changed. Do the following to see the user, you should see vagrant user now
```
whoami
```
To switch to root user, do this
```
sudo -i
```
To exit from root user:
```
exit
```
To power off the VM:
```
vagrant halt
```
To exit completely to your local computer:
```
exit
```
#### Ubuntu
We will now be doing same for ubuntu in the ubuntu directory
```
pwd
```
The current location should be pointing to /c/vagrant_vms/centos so we will have to go level up the file structure and move into the ubuntu directory
```
cd ..
```
The command above takes you up one level (go back in direction). Now do 
```
cd ubuntu
```
```
pwd
```
Our location now is /c/vagrant_vms/ubuntu. Go to vagrant cloud and search for ```ubuntu/jammy64```. Click on it. Go to git bash
```
vagrant init ubuntu/jammy64
```
The rest of the commands is just like what you did for Centos






