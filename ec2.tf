#############################
# Data Source
##############################

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] # This should be the AWS account ID or 'self', 'amazon', or 'aws-marketplace'

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # This pattern should match the AMI name you're looking for
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  # The "owner-alias" filter is not needed, as "owners" is already specified
}


##############################
###  EC2 Instance 
#############################

resource "aws_instance" "private-app-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "afcon2024-key"

  tags = {
    Name = "app-asg"
  }
}
