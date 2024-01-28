## Part 1 - [HOL] Create Image and Push to ECR Repository

Use the terraform codes to launch EC2 instance - Amazon Linux 2 AMI, t2.micro
Make sure to create the key pair (container-key.pem, container-key.pem.pub) in your local directory using the command ssh-keygen
Connect to instance from your local machine using the pem key

### Run the following commands on EC2:
```
sudo su
```
```
yum update
```
```
yum install docker -y
```
```
systemctl enable docker.service
```
```
systemctl start docker.service
```
```
docker pull nginx
```
```
docker images
```

### Create an IAM Policy:

- Go to the IAM console in AWS.
- Navigate to "Policies" and click "Create policy".
- You can use the JSON editor to input the contents of your "ecr-allow-all.json" file.
- Review the policy and give it a meaningful name and description (e.g ECRPolicy).
- Click "Create policy" to finalize.

### Create an IAM Role:

- In the IAM console, go to "Roles" and click "Create role".
- Select "AWS service" as the trusted entity and choose "EC2" as the use case.
- Click "Next: Permissions" to attach the policy you just created.
- Search for the policy by the name you gave it and select it.
- Click "Next: Tags" to add any tags if needed (this step is optional).
- Click "Next: Review", give the role a name and description (e.g ECR_Role), and create the role.

### Attach the IAM Role to an EC2 Instance:

- Go to the EC2 console and select the EC2 instance you want to attach the role to.
- In the instance's "Actions" menu, navigate to "Security", and then select "Modify IAM role".
- In the "IAM role" dropdown, select the IAM role you created.
- Click "Save" to attach the role to the EC2 instance.

### Run the following commands (replace account number):
```
aws ecr create-repository --repository-name nginx --region us-east-1
```
```
$ docker tag nginx:latest <aws account id>.dkr.ecr.us-east-1.amazonaws.com/nginx:latest
```
```
$ aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <aws account id>.dkr.ecr.us-east-1.amazonaws.com/nginx
```
```
$ docker push <aws account id>.dkr.ecr.us-east-1.amazonaws.com/nginx:latest
```
```
