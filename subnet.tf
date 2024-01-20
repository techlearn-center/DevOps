###################
# Public Subnet - 1 ##
##################

resource "aws_subnet" "public-web-subnet-1" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-1

  tags = {
    Name = "public-web-subnet-1"
  }
}

###################
# Public Subnet - 2 ##
##################
resource "aws_subnet" "public-web-subnet-2" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-2

  tags = {
    Name = "public-web-subnet-2"
  }
}

###################
# Public Subnet - 3 ##
##################
resource "aws_subnet" "public-web-subnet-3" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-3

  tags = {
    Name = "public-web-subnet-3"
  }
}

###################
# Private Subnet - 1 ##
##################
resource "aws_subnet" "private-app-subnet-1" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-1

  tags = {
    Name = "private-app-subnet-1"
  }
}


###################
# Private Subnet - 2 ##
##################
resource "aws_subnet" "private-app-subnet-2" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-2

  tags = {
    Name = "private-app-subnet-2"
  }
}

###################
# Private Subnet - 3 ##
##################
resource "aws_subnet" "private-app-subnet-3" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-3

  tags = {
    Name = "private-app-subnet-3"
  }
}

###################
# Private Subnet-db- 1 ##
##################
resource "aws_subnet" "private-db-subnet-1" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-1

  tags = {
    Name = "private-db-subnet-1"
  }
}

###################
# Private Subnet-db- 2 ##
##################
resource "aws_subnet" "private-db-subnet-2" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-2

  tags = {
    Name = "private-db-subnet-2"
  }
}

###################
# Private Subnet-db- 2 ##
##################
resource "aws_subnet" "private-db-subnet-3" {
  vpc_id                  = aws_vpc.multi-resources.id
  cidr_block              = "10.0.9.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.zone-3

  tags = {
    Name = "private-db-subnet-3"
  }
}

