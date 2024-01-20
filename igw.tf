##################
# IGW
#################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.multi-resources.id

  tags = {
    Name = "multi-IGW"
  }
}
