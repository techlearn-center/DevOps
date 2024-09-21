# AWS Terraform Setup for Jenkins, Nexus, and SonarQube

This directory contains Terraform files for deploying Jenkins, Nexus, and SonarQube on Ubuntu and CentOS EC2 instances in AWS. Follow the steps below to provision each tool separately.

## Instructions

1. **Cloning the Repository:**
   - After cloning this repository to your local machine, create 3 separate copies of the directory, each for Jenkins, Nexus, and SonarQube.

2. **Setting Up Jenkins:**
   - To set up Jenkins, copy the content of `ec2-install-jenkins.txt` into the `ec2-instance.tf` file within the Jenkins directory.
   - Create the key pair required for the EC2 instance by running the following command:
     ```bash
     ssh-keygen
     ```
   - Ensure that the key pair name matches the one specified in the `ec2-instance.tf` file under the **aws_key_pair** resource block for the `public_key` parameter.

3. **Setting Up Nexus and SonarQube:**
   - Repeat the same process for Nexus and SonarQube by copying their respective configuration files (`ec2-install-nexus.txt` and `ec2-install-sonarqube.txt`) into the `ec2-instance.tf` files in their respective directories.
   
4. **Running Terraform:**
   - Navigate to each directory (Jenkins, Nexus, SonarQube) and run the following Terraform commands to provision the resources:
     ```bash
     terraform init
     terraform plan
     terraform apply
     ```

   - These commands will deploy the EC2 instances for Jenkins, Nexus, and SonarQube separately.

## Notes
- Ensure that the AWS credentials are properly configured before running Terraform.
- Each tool will be deployed in its own EC2 instance, and you can access them using the public IPs provided in the Terraform output.



Follow the links below to integrate sonarqube and nexus with Jenkins:
https://github.com/techlearn-center/DevOps/blob/CICD/profile-project/nexus.md
https://github.com/techlearn-center/DevOps/blob/CICD/profile-project/maven.md
