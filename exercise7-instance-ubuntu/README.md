# AWS Terraform Setup for Jenkins, Maven, Nexus, and SonarQube

This directory contains Terraform files for deploying Jenkins, Nexus, and SonarQube on Ubuntu and CentOS EC2 instances in AWS. Follow the steps below to provision each tool separately.

## Instructions

1. **Cloning the Repository:**
   - After cloning this repository to your local machine, create 3 separate copies of the directory, each for Jenkins, Nexus, and SonarQube.

2. **Setting Up Jenkins:**
   - To set up Jenkins and Maven, copy the content of `ec2-install-jenkins.txt` (this has maven installation scripts well) into the `ec2-instance.tf` file within the Jenkins directory.
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






## Checking Jenkins, Nexus, and SonarQube in the Browser

After provisioning the resources using Terraform, follow these steps to check if Jenkins, Nexus, and SonarQube are running by accessing them in your browser:

### 1. Jenkins:
- **URL**: `http://<Jenkins-EC2-Public-IP>:8080`
- **Default Port**: `8080`
- Once Jenkins is up and running, you will be prompted to unlock it using the administrator password.
- To find the administrator password, SSH into your Jenkins EC2 instance and use the following command:
  ```bash
  cat /var/lib/jenkins/secrets/initialAdminPassword
  ```

### 2. Nexus:
- **URL**: `http://<Nexus-EC2-Public-IP>:8081`
- **Default Port**: `8081`
- Nexus is accessible on port 8081. You can log in using the default credentials:
  - **Username**: `admin`
  - **Password**: The default admin password is located in the file:
    ```bash
    cat /opt/sonatype-work/nexus3/admin.password
    ```

### 3. SonarQube:
- **URL**: `http://<SonarQube-EC2-Public-IP>:80`
- **Default Port**: `80`
- SonarQube is accessible on port 80. You can log in using the default credentials:
  - **Username**: `admin`
  - **Password**: `admin`
  
Make sure to replace `<Jenkins-EC2-Public-IP>`, `<Nexus-EC2-Public-IP>`, and `<SonarQube-EC2-Public-IP>` with the actual public IP addresses of the respective EC2 instances.


This format provides a clear, structured set of instructions for accessing Jenkins, Nexus, and SonarQube in the browser with their respective ports and default credentials.


Follow the links below to integrate sonarqube and nexus with Jenkins:
- Nexus: https://github.com/techlearn-center/DevOps/blob/CICD/profile-project/nexus.md
- Sonarqube:  https://github.com/techlearn-center/DevOps/blob/CICD/profile-project/sonar.md



