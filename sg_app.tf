##################################
## SG Application Tier (Bastion Host) ###
###################################

resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Access"
  description = "Enable ssh access on port 22"
  vpc_id      = aws_vpc.multi-resources.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh Security group"
  }
}
