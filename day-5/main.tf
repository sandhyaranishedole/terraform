resource "aws_vpc" "dev" {
 cidr_block = "10.0.0.0/16"
tags = {
  name="vpc1"
}
}
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
  tags = {
    name="IGW"
  }
}

resource "aws_eip" "nat" {
    domain   = "vpc"
}
  
  resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.dev]
}

resource "aws_subnet" "pub"{
    vpc_id= aws_vpc.dev.id
cidr_block = "10.0.1.0/24"
tags = {
  name="pubsub"
}
  
}
resource "aws_subnet" "pvt"{
    vpc_id=aws_vpc.dev.id
cidr_block = "10.0.2.0/24"
tags = {
  name="pvtsub"
}
  
}
resource "aws_route_table" "pub" {
vpc_id = aws_vpc.dev.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
    
  }
  
} 
resource "aws_route_table" "pvt" {
vpc_id = aws_vpc.dev.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  
} 
resource "aws_route_table_association" "pub" {
    subnet_id = aws_subnet.pub.id
route_table_id = aws_route_table.pub.id
}
resource "aws_route_table_association" "pvt" {
    subnet_id = aws_subnet.pvt.id
route_table_id = aws_route_table.pvt.id
}


resource "aws_security_group" "dev" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description = "TLS from ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "TLS from http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg"
  }
}

