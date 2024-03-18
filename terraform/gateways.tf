# Internet gateway for main VPC
resource "aws_internet_gateway" "main-ig" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "main-ig"
  }
}