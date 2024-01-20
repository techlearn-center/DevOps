######################
#  Route Table
######################

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "Public Route Table"
  }
}

######################
# Route table association
######################

resource "aws_route_table_association" "public-subnet-1-rt" {
  subnet_id      = aws_subnet.public-web-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-rt" {
  subnet_id      = aws_subnet.public-web-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-3-rt" {
  subnet_id      = aws_subnet.public-web-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}


