#====================================================================================
resource "aws_instance" "main-proxy" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-proxy.id]
  subnet_id                   = aws_subnet.main-subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "main-proxy"
  }
}

#====================================================================================
resource "aws_instance" "main-reverseproxy" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-reverseproxy.id]
  subnet_id                   = aws_subnet.main-subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "main-reverseproxy"
  }
}

#====================================================================================
resource "aws_instance" "main-bastion" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-bastion.id]
  subnet_id                   = aws_subnet.main-subnet2.id
  associate_public_ip_address = true

  tags = {
    Name = "main-bastion"
  }
}

#====================================================================================
resource "aws_instance" "main-vpn" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-vpn.id]
  subnet_id                   = aws_subnet.main-subnet2.id
  associate_public_ip_address = true

  tags = {
    Name = "main-vpn"
  }
}

#====================================================================================
resource "aws_instance" "client1-web" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-client1-web.id]
  subnet_id                   = aws_subnet.client1-subnet.id
  associate_public_ip_address = false

  tags = {
    Name = "client1-web"
  }
}

#====================================================================================
resource "aws_instance" "client2-web" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main-sg-client2-web.id]
  subnet_id                   = aws_subnet.client2-subnet.id
  associate_public_ip_address = false

  tags = {
    Name = "client2-web"
  }
}