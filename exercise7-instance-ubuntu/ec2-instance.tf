#############################
# Data Source
##############################

data "aws_ami" "ubuntu-2204-LTS" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID for Ubuntu images

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # This pattern should match the AMI name you're looking for
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
resource "aws_key_pair" "container-key" {
  key_name   = "container-key"
  public_key = file("container-key.pem.pub")
}


resource "aws_instance" "container-ec2" {
  ami                    = data.aws_ami.ubuntu-2204-LTS.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.container.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = aws_key_pair.container-key.key_name
  #user_data              = file("web.sh")
  tags = {
    Name = "container-ec2"
  }

  provisioner "file" {
    source      = "install-docker.sh"
    destination = "/tmp/install-docker.sh"
    connection {
      type        = "ssh"
      user        = var.user
      private_key = file("container-key.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/install-docker.sh",
      "sudo /tmp/install-docker.sh"
    ]

    connection {
      type        = "ssh"
      user        = var.user
      private_key = file("container-key.pem")
      host        = self.public_ip
    }
  }

}


