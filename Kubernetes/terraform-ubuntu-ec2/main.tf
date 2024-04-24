# This script assumes you already have a vpc, key-pair and security group created in your account

#############################
# Data Sources
##############################

# Fetching existing Key Pair
data "aws_key_pair" "existing-key" {
  key_name = "jenkins-key"
}

# Fetching existing Subnet (modify filter as necessary to match your existing VPC/subnet setup)
data "aws_subnet" "existing-subnet" {
  filter {
    name   = "tag:Name"
    values = ["public-web-subnet-Jenkins"]
  }
}

# Fetching existing Security Group (modify filter as necessary)
data "aws_security_group" "existing-sg" {
  filter {
    name   = "tag:Name"
    values = ["Jenkins server Security group"]
  }
}

# Fetching Ubuntu AMI
data "aws_ami" "ubuntu-2204-LTS" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

##############################
###  EC2 Instance 
#############################
resource "aws_instance" "container-ec2" {
  ami                    = data.aws_ami.ubuntu-2204-LTS.id
  instance_type          = "t2.small"
  subnet_id              = data.aws_subnet.existing-subnet.id
  vpc_security_group_ids = [data.aws_security_group.existing-sg.id]
  key_name               = data.aws_key_pair.existing-key.key_name

  tags = {
    Name = "kops-instance"
  }


}

output "publicIP" {
  value = aws_instance.container-ec2.public_ip
}

output "privateIP" {
  value = aws_instance.container-ec2.private_ip
}
