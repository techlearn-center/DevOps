#############################
# Data Source
##############################

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon's AWS account ID for Amazon Linux images

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # This pattern should match the Amazon Linux 2 AMI name you're looking for
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


##############################
###  EC2 Instance 
#############################
resource "aws_key_pair" "container-key" {
  key_name   = "container-key"
  public_key = file("container-key.pem.pub")
}


resource "aws_instance" "container-ec2" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.container.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = aws_key_pair.container-key.key_name
  tags = {
    Name = "ecr-ec2"
  }


}


output "publicIP" {
  value = aws_instance.container-ec2.public_ip
}
output "privateIP" {
  value = aws_instance.container-ec2.private_ip
}



