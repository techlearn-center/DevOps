###################
# Public Subnet ##
##################

resource "aws_subnet" "container" {
  vpc_id                  = aws_vpc.container-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone

  tags = {
    Name = "public-web-subnet-1"
  }
}

