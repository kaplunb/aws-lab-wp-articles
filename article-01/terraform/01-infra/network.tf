# network.tf
resource "aws_vpc" "wp_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "wp_vpc"
  }
}

resource "aws_subnet" "wp_subnet_public_a" {
  vpc_id                  = aws_vpc.wp_vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wp_subnet_public_a"
  }
}

resource "aws_internet_gateway" "wp_igw" {
  vpc_id = aws_vpc.wp_vpc.id

  tags = {
    Name = "wp_igw"
  }
}

resource "aws_route_table" "wp_route_table_public" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp_igw.id
  }

  tags = {
    Name = "wp_route_table_public"
  }
}

resource "aws_route_table_association" "wp_route_table_assoc_public" {
  subnet_id      = aws_subnet.wp_subnet_public_a.id
  route_table_id = aws_route_table.wp_route_table_public.id
}