# VPC resource
resource "aws_vpc" "projectVPC" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "pubsub" {
  count = 2
  vpc_id = aws_vpc.projectVPC.id
  availability_zone       = var.public_azs[count.index]
  map_public_ip_on_launch  = true
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
    tags = {
    Name = "${var.pubsubnet_name[count.index]}-${count.index + 1}"

  }  
}
resource "aws_subnet" "privatesub" {
  count = 2
  vpc_id = aws_vpc.projectVPC.id
  availability_zone       = var.private_azs[count.index]
  map_public_ip_on_launch  = false
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
    tags = {
    Name = "${var.prisubnet_name[count.index]}-${count.index + 1}"
  }  
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.projectVPC.id

  tags = {
    Name = var.IG_name
  }
}
resource "aws_security_group" "projectVPCsg" {
  name        = var.SG_name
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.projectVPC.id
    ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 18681
    to_port          = 18681
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.SG_name
  }
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.projectVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.pubsubroutetable_name
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.projectVPC.id
  
  tags = {
    Name = var.privsubroutetable_name
  }
}

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.pubsub[count.index].id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.privatesub[count.index].id
  route_table_id = aws_route_table.privateroute.id
}

resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pubsub[0].id

  tags = {
    Name = var.Nat-GW_name
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.privateroute.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgateway.id
}


