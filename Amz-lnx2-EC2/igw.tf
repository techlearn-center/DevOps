##################
# IGW
#################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.container-vpc.id

  tags = {
    Name = "container-igw"
  }
}
