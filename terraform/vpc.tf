#====================================================================================
# Main VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

#====================================================================================
# VPC Client 1
resource "aws_vpc" "client1-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "client1-vpc"
  }
}

#====================================================================================
# VPC Client 2
resource "aws_vpc" "client2-vpc" {
  cidr_block = "172.17.0.0/16"

  tags = {
    Name = "client2-vpc"
  }
}

#====================================================================================
# VPC Peering with client1 vpc
resource "aws_vpc_peering_connection" "main-vpc-peer-client1" {
  peer_vpc_id = aws_vpc.main-vpc.id
  vpc_id      = aws_vpc.client1-vpc.id
  auto_accept = true

  tags = {
    Name = "main-vpc-peer-client1"
  }
}

#====================================================================================
# VPC Peering with client2 vpc
resource "aws_vpc_peering_connection" "main-vpc-peer-client2" {
  peer_vpc_id = aws_vpc.main-vpc.id
  vpc_id      = aws_vpc.client2-vpc.id
  auto_accept = true

  tags = {
    Name = "main-vpc-peer-client2"
  }
}