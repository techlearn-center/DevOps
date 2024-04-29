############################################################################################
## Setting up a Kuberenetes Cluster Using KOps.
############################################################################################

======================================================================
### kOps
======================================================================

Kubernetes provides excellent container orchestration, but setting up a Kubernetes cluster from scratch 
can be painful. One solution is to use Kubernetes Operations, or kOps.

kOps is an open-source project which helps you create, destroy, upgrade, and maintain a highly available,
production-grade Kubernetes cluster. Depending on the requirement, kOps can also provision cloud 
infrastructure.

kOps is mostly used in deploying AWS and GCE Kubernetes clusters. 

### Reference Links:
https://www.densify.com/kubernetes-tools/kubernetes-kops/#:~:text=What%20is%20kOps%3F,can%20also%20provision%20cloud%20infrastructure.

The Lab steps are given below:

===============================================
### Lab 1: Launch Kubernetes Cluster in AWS (EC2)
=============================================

-------------------------------
Task 1: Launch anchor EC2
------------------------------
Create an Ubuntu 22.04 EC2 instance using the terraform scripts in this folder (https://github.com/techlearn-center/DevOps/tree/CICD/Kubernetes/terraform-ubuntu-ec2).

Make sure Port 22 has been opened.

Update hostname (optional)
```
sudo hostnamectl set-hostname kubernetes
```
To apply the change and see the new hostname, exit the current SSH session and then reconnect to the server.

Create the script to set up the cluster
```
vi install-kops-tool.sh
```
Copy and paste below script in the vi editor. Make sure to save it (:wq)

```
#!/bin/bash

# Function to get user input with a verification loop
get_input() {
    local prompt=$1
    local varname=$2
    local input

    while true; do
        echo
        echo "$prompt"
        read input
        echo "You entered: $input"
        echo "Is this correct? (yes/no)"
        read confirmation
        if [[ $confirmation == "yes" ]]; then
            eval $varname="'$input'"
            break
        else
            echo "Please re-enter the information."
        fi
    done
}

# Start of the script logic
get_input "Enter AWS Access Key:" awsaccess
get_input "Enter AWS Secret Key:" awssecret
get_input "Enter VPC ID: (use the VPC ID for the kops instance already created from console)" yourvpcid
get_input "Enter Cluster Name: (ex: my-kube.k8s.local)" clname
get_input "Enter S3 bucket name: (ex: my-kube-k8s-local)" s3buck
get_input "Enter an AZ for the cluster:" az

# Output the entered information (optional, for verification)
echo
echo "AWS Access Key: $awsaccess"
echo "AWS Secret Key: $awssecret"
echo "VPC ID: $yourvpcid"
echo "Cluster Name: $clname"
echo "S3 Bucket Name: $s3buck"
echo "AZ for the cluster: $az"
echo


# Install required packages and utilities
sudo apt update

sudo apt install curl wget awscli -y

# Download kubectl, give execute permission, and move to binary path
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.25.0/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Download kOps
sudo curl -LO https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64

# Give executable permission to the downloaded kOps file and move it to binary path
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Ensure the necessary tools are installed
if ! command -v aws >/dev/null 2>&1; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

if ! command -v kops >/dev/null 2>&1; then
    echo "kops is not installed. Please install it first."
    exit 1
fi



# Configure your AWS user profile
aws configure set aws_access_key_id $awsaccess
aws configure set aws_secret_access_key $awssecret

# Create a key which can be used by kOps for cluster login
if [ ! -f $HOME/.ssh/id_rsa ]; then
    ssh-keygen -N "" -f $HOME/.ssh/id_rsa
else
    echo "SSH key already exists. Skipping creation."
fi

# Create an S3 Bucket where kOps will save all the cluster's state information.
aws s3 mb s3://$s3buck

# Expose the s3 bucket as environment variables.
export KOPS_STATE_STORE=s3://$s3buck

# Create the cluster with 2 worker nodes.
kops create cluster --node-count=2 --master-size="t3.medium" --node-size="t3.medium" --master-volume-size=30 --node-volume-size=30 --zones=$az --name $clname --state=s3://$s3buck --vpc=$yourvpcid

# Apply the specified cluster specifications to the cluster
kops get cluster
kops update cluster $clname --yes --state=s3://$s3buck

# The .bashrc file is a script file that’s executed when a user logs in.
echo "export KOPS_STATE_STORE=s3://$s3buck" >> ~/.bashrc
```

Run the script to setup and configure the Kubernetes cluster. 

Enter the AWS keys, Availability Zone, and cluster name when prompted.
 
Cluster name needs to be in the format <name>.k8s.local
```
chmod +x install-kops-tool.sh 
```

Now execute the script
```
bash install-kops-tool.sh
```
OR
```
./install-kops-tool.sh
```

Enter Access Key 

xxxxxx

and Secret Key

yyyyyyy

specify a cluster name. Ex:

kube102.k8s.local

AZ:us-east-1a (Enter any AZ of your choice)

Set S3 bucket environment variable. Bucket name will be same as the name of cluster but with hyphens instead of periods

export KOPS_STATE_STORE=s3://< Cluster-Name >

Example (if your s3 bucket name is s3://kube102-k8s-local) :
```
export KOPS_STATE_STORE=s3://kube102-k8s-local
```

Get the cluster list

```
kops get cluster
```

Export a kubeconfig file for a cluster from the state store using cluster admin user. 

By default, the configuration will be saved into a users $HOME/.kube/config file.
```
kops export kubecfg --admin
```

validate cluster creation. It may take 10+ minutes for cluster creation
```
kops validate cluster
```
Or
```
kops validate cluster --wait 10m --count 3
```

#### Go to aws EC2 dashboard and confirm that the master node + 2 worker nodes exist

#### Note: If you need to stop the 3 ec2 instances created by the above process, go to auto scaling group console and change the min/max/desired numbers of the 2 associated ASGs to zero

-------------------------------
Task 2: create a Pod using YAML
------------------------------
```
vi 2048-pod.yaml
```
or 
nano 2048-pod.yaml
```
apiVersion: v1
kind: Pod
metadata:
   name: 2048-pod
   labels:
      app: 2048-ws
spec:
   containers:
   - name: 2048-container
     image: blackicebird/2048
     ports:
       - containerPort: 80
```

apply the 2048-pod file
```
kubectl apply -f 2048-pod.yaml
```
pod/2048-pod created

list the newly created pod
```
kubectl get pods
```
Let's create another pod called the tetris pod

```
vi tetris.yaml
```
```
apiVersion: v1
kind: Pod
metadata:
   name: tetris
   labels:
      app: tetris
spec:
   containers:
   - name: tetris
     image: bsord/tetris
     ports:
       - containerPort: 80

```
```
kubectl apply -f tetris.yaml
```
------------------------------------
Task 3: Setup Load Balancer Service
-----------------------------------
```
vi game-svc.yaml 
```
```
apiVersion: v1
kind: Service
metadata:
   name: game-svc
spec:
   selector:
      app: 2048-ws
   ports:
   - protocol: TCP
     port: 80
     targetPort: 80
   type: LoadBalancer
```

Apply the config file
```
kubectl apply -f game-svc.yaml
```

```
vi tetris-svc.yaml
```

```
apiVersion: v1
kind: Service
metadata:
   name: tetris-svc
spec:
   selector:
      app: tetris
   ports:
   - protocol: TCP
     port: 80
     targetPort: 80
   type: LoadBalancer

```
Apply the svc config file
```
kubectl apply -f game-svc.yaml
```

View details of the modified service. 
```
kubectl describe svc game-svc
```
The above command will take a few minutes before it can give corect output

Go to EC2 dashboard, click on Loadbalancer. select the load balancer.

Copy the DNS name and paste it into address bar of your browser. 

Now, you will be able to see the 2048 game and will be able to play it too.

Do same for the tetris game as well.

##### Congratulations, you have been able to deploy two applications on kubernetes cluster!!!!

-------------------------------
Task 4: Cleanup
------------------------------

Clean up all the resources created in the task
```
kubectl delete -f game-svc.yaml
```
```
kubectl delete -f tetris-svc.yaml
```

```
kubectl delete -f 2048-pod.yaml
```
```
kubectl delete -f tetris.yaml
```
```
kops delete cluster --name=<cluster-name>.k8s.local --yes
```
delete the bucket manually from the console

######################################################################################################################
Congratulations you are done with this 
######################################################################################################################

#### Errors you might encounter and how to resolve:
- E: Package 'awscli' has no installation candidate

The error message "E: Package 'awscli' has no installation candidate" typically indicates that the package you are trying to install is not available in the repository list that your system knows about or the package name might be incorrect. Here’s how to resolve this issue and successfully install the AWS CLI (Command Line Interface) on an Ubuntu system:

- Update Your Package List
```
sudo apt update
``
- Install Using the Correct Package Name
For Ubuntu systems, especially newer versions, you should install the AWS CLI version 2, which might not be available directly via the default repositories and does not use the package name `awscli`. Instead, you'll need to download and install it using the official AWS method:
