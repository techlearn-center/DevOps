

******************** 
1. How Autoscaling group works
2. How ALB also works 
***************************
- Create custom vpc (ASG-ALB-vpc)
- Create a SG for ALB
- Create SG for Web service
- Create ALB -but first create a TG- Go to EC2 dashboard, in the console go to target groups (collection of instances we will send traffic to), call it TG1
- Now create load balancer (ALB1 ), internet facing meaning it will be accessible from the internet, choose the azs and make sure the subnets are public


Userdata

#!/bin/bash

#Update the system and install APache
yum update -y
yum install -y httpd

# Start and enable Apache to run on boot
systemctl start httpd
systemctl enable httpd

#Fetch the latest token for accessing EC2 instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch the instance ID
INSTANCEID=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token: $TOKEN")

# Create or overwrite index.html with 

echo "<center><h1>This instance has the ID: $INSTANCEID </h1></center>" > /var/www/html/index.html


# Ensure httpd can read the index.html file and its directory
chown apache:apache /var/www/html/index
chmod 755  /var/www/html
chmod 644 /var/www/html/index.html

#Restart Apache to apply changes
systemctl restart httpd
