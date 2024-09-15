#############################
# Data Source for Ubuntu AMI
##############################
data "aws_ami" "ubuntu-2204-LTS" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID for Ubuntu images

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # Pattern matching AMI names
  }

  filter {
    name   = "state"
    values = ["available"] # Ensure the AMI is available
  }
}

##############################
### EC2 Instance
##############################
resource "aws_key_pair" "container-key" {
  key_name   = "jenkins-key"
  public_key = file("jenkins-key.pem.pub") # Assuming the public key is located in the same directory as the Terraform config
}

resource "aws_instance" "container-ec2" {
  ami                    = data.aws_ami.ubuntu-2204-LTS.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.container.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = aws_key_pair.container-key.key_name

  # Using user_data for bootstrapping actions
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install openjdk-17-jdk -y
    sudo apt install maven wget unzip -y

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt-get update
    sudo apt-get install jenkins -y
  EOF

  tags = {
    Name = "jenkins-server"
  }
}

output "publicIP" {
  value = aws_instance.container-ec2.public_ip
}

output "privateIP" {
  value = aws_instance.container-ec2.private_ip
}
