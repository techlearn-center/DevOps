######################
#  Route Table
######################

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.multi-resources.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }


  tags = {
    Name = "Private Route Table"
  }
}

####################################
# Route table association for App tier
####################################

resource "aws_route_table_association" "nat_rta_1" {
  subnet_id      = aws_subnet.private-app-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_rta_2" {
  subnet_id      = aws_subnet.private-app-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_rta_3" {
  subnet_id      = aws_subnet.private-app-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}

####################################
# Route table association for DB tier
####################################

resource "aws_route_table_association" "nat_rta_db_1" {
  subnet_id      = aws_subnet.private-db-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_rta_db_2" {
  subnet_id      = aws_subnet.private-db-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_rta_db_3" {
  subnet_id      = aws_subnet.private-db-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}
