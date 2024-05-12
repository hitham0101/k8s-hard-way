# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.aws.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc"
  }
}

# Subnets
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}


# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-central-1a"
  cidr_block              = var.aws.public_subnets_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# # │ Error: cannot create local Route, use `terraform import` to manage existing local Routes
# resource "aws_route" "loacl" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "10.0.0.0/16"
#   gateway_id             = "local"
# }
# Route table associations for both Public Subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}


# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

}


