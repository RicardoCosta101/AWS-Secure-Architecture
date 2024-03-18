#====================================================================================
# Main Subnet 1
resource "aws_subnet" "main-subnet1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-subnet1"
  }
}

#====================================================================================
# Main Subnet 2
resource "aws_subnet" "main-subnet2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-subnet2"
  }
}

#====================================================================================
# Subnet Client 1
resource "aws_subnet" "client1-subnet" {
  vpc_id                  = aws_vpc.client1-vpc.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "client1-subnet"
  }
}

#====================================================================================
# Subnet Client 2
resource "aws_subnet" "client2-subnet" {
  vpc_id                  = aws_vpc.client2-vpc.id
  cidr_block              = "172.17.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "client2-subnet"
  }
}