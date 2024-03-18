#====================================================================================
# Create security group for instance "proxy"
resource "aws_security_group" "main-sg-proxy" {
  name        = "main-sg-proxy"
  description = "Security group for proxy instance"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "main-sg-proxy"
  }
}

# Allow port 22 from bastion instance in security group of instance proxy
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-proxy" {
  security_group_id = aws_security_group.main-sg-proxy.id
  cidr_ipv4         = "${aws_instance.main-bastion.private_ip}/32"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow port 3128 (squid http port) in security group of instance proxy
resource "aws_vpc_security_group_ingress_rule" "allow-http-proxy" {
  security_group_id = aws_security_group.main-sg-proxy.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "3128"
  to_port           = "3128"
  ip_protocol       = "tcp"
}

# Allow port 3129 (squid https port) in security group of instance proxy
resource "aws_vpc_security_group_ingress_rule" "allow-https-proxy" {
  security_group_id = aws_security_group.main-sg-proxy.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "3129"
  to_port           = "3129"
  ip_protocol       = "tcp"
}

# Allow traffic to go everywhere from instance proxy 
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-proxy" {
  security_group_id = aws_security_group.main-sg-proxy.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================================================================================
# Create security group for instance "reverseproxy"
resource "aws_security_group" "main-sg-reverseproxy" {
  name        = "main-sg-reverseproxy"
  description = "Security group for reverse proxy instance"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "main-sg-reverseproxy"
  }
}

# Allow port 22 from bastion instance in security group of instance reverse proxy
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-reverseproxy" {
  security_group_id = aws_security_group.main-sg-reverseproxy.id
  cidr_ipv4         = "${aws_instance.main-bastion.private_ip}/32"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow port 80 from everywhere in security group of instance reverse proxy
resource "aws_vpc_security_group_ingress_rule" "allow-http-reverseproxy" {
  security_group_id = aws_security_group.main-sg-reverseproxy.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  to_port           = "80"
  ip_protocol       = "tcp"
}

# Allow traffic to go everywhere from instance reverse proxy
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-reverseproxy" {
  security_group_id = aws_security_group.main-sg-reverseproxy.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================================================================================
# Create security group for instance "bastion"
resource "aws_security_group" "main-sg-bastion" {
  name        = "main-sg-bastion"
  description = "Security group for bastion instance"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "main-sg-bastion"
  }
}

# Allow port 22 from main vpc network in the security group of instance bastion
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-bastion" {
  security_group_id = aws_security_group.main-sg-bastion.id
  cidr_ipv4         = aws_vpc.main-vpc.cidr_block
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow traffic to go everywhere from instance bastion
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-bastion" {
  security_group_id = aws_security_group.main-sg-bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================================================================================
# Create security group for instance "vpn"
resource "aws_security_group" "main-sg-vpn" {
  name        = "main-sg-vpn"
  description = "Security group for vpn instance"
  vpc_id      = aws_vpc.main-vpc.id

  tags = {
    Name = "main-sg-vpn"
  }
}

# Allow port 22 from everywhere in security group of instance vpn
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-vpn" {
  security_group_id = aws_security_group.main-sg-vpn.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow port 1194 (openvpn port) from everywhere in security group of instance vpn
resource "aws_vpc_security_group_ingress_rule" "allow-tunnel-vpn" {
  security_group_id = aws_security_group.main-sg-vpn.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "1194"
  to_port           = "1194"
  ip_protocol       = "udp"
}

# Allow traffic to go everywhere from instance vpn
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-vpn" {
  security_group_id = aws_security_group.main-sg-vpn.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================================================================================
# Create security group for instance "client1-web"
resource "aws_security_group" "main-sg-client1-web" {
  name        = "main-sg-client1-web"
  description = "Security group for client 1 web instance"
  vpc_id      = aws_vpc.client1-vpc.id

  tags = {
    Name = "main-sg-client1-web"
  }
}

# Allow port 22 from everywhere in security group of instance client1-web
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-client1-web" {
  security_group_id = aws_security_group.main-sg-client1-web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow port 80 from everywhere in security group of instance client1-web
resource "aws_vpc_security_group_ingress_rule" "allow-http-client1-web" {
  security_group_id = aws_security_group.main-sg-client1-web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  to_port           = "80"
  ip_protocol       = "tcp"
}

# Allow traffic to go everywhere from instance client1 web
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-client1-web" {
  security_group_id = aws_security_group.main-sg-client1-web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================================================================================
# Create security group for instance "client2-web"
resource "aws_security_group" "main-sg-client2-web" {
  name        = "main-sg-client2-web"
  description = "Security group for client 2 web instance"
  vpc_id      = aws_vpc.client2-vpc.id

  tags = {
    Name = "main-sg-client2-web"
  }
}

# Allow port 22 from everywhere in security group of instance client2-web
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-client2-web" {
  security_group_id = aws_security_group.main-sg-client2-web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
}

# Allow port 80 from everywhere in security group of instance client2-web
resource "aws_vpc_security_group_ingress_rule" "allow-http-client2-web" {
  security_group_id = aws_security_group.main-sg-client2-web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  to_port           = "80"
  ip_protocol       = "tcp"
}

# Allow traffic to go everywhere from instance client2 web
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-client2-web" {
  security_group_id = aws_security_group.main-sg-client2-web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}