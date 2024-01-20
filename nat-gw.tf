####################
# NAT GW
#################

resource "aws_eip" "eip-nat" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.public-web-subnet-1.id

  tags = {
    Name = "NAT-gw-1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
