#====================================================================================
resource "aws_route_table" "main-routetable" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-ig.id
  }

  route {
    cidr_block                = "172.16.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.main-vpc-peer-client1.id
  }

  route {
    cidr_block                = "172.17.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.main-vpc-peer-client2.id
  }

  tags = {
    Name = "main-routetable"
  }
}

resource "aws_route_table_association" "main-rt-ig-subnet1-assoc" {
  subnet_id      = aws_subnet.main-subnet1.id
  route_table_id = aws_route_table.main-routetable.id
}

resource "aws_route_table_association" "main-rt-ig-subnet2-assoc" {
  subnet_id      = aws_subnet.main-subnet2.id
  route_table_id = aws_route_table.main-routetable.id
}

#====================================================================================
resource "aws_route_table" "client1-routetable" {
  vpc_id = aws_vpc.client1-vpc.id

  route {
    cidr_block                = "0.0.0.0/0"
    vpc_peering_connection_id = aws_vpc_peering_connection.main-vpc-peer-client1.id
  }

  tags = {
    Name = "client1-routetable"
  }
}

resource "aws_route_table_association" "client1-rt-subnet1-assoc" {
  subnet_id      = aws_subnet.client1-subnet.id
  route_table_id = aws_route_table.client1-routetable.id
}

#====================================================================================
resource "aws_route_table" "client2-routetable" {
  vpc_id = aws_vpc.client2-vpc.id

  route {
    cidr_block                = "0.0.0.0/0"
    vpc_peering_connection_id = aws_vpc_peering_connection.main-vpc-peer-client2.id
  }

  tags = {
    Name = "client2-routetable"
  }
}

resource "aws_route_table_association" "client2-rt-subnet2-assoc" {
  subnet_id      = aws_subnet.client2-subnet.id
  route_table_id = aws_route_table.client2-routetable.id
}