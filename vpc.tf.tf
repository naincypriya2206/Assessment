
provider "aws" {
  region     = "us-east-1"
  access_key = "xxxxxxxxx"
  secret_key = "xxxxxxxxx"
}


resource "aws_vpc" "lavi" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "lavi-vpc" # configure our own name 
  }
}



resource "aws_subnet" "public-subnet1" {
  vpc_id                  = aws_vpc.lavi.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-subnet1"
  }
}
#public-subnet2 creation
resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.lavi.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public-subnet2"
  }
}
#private-subnet1 creation
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.lavi.id
  cidr_block        = var.subnet3_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet1"
  }
}


resource "aws_internet_gateway" "lavi-gateway" {
  vpc_id = aws_vpc.lavi.id
}



resource "aws_route_table" "route" {
  vpc_id = aws_vpc.lavi.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lavi-gateway.id
  }
  tags = {
    Name = "route to internet"
  }
}
#route 1
resource "aws_route_table_association" "route1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.route.id
}
#route 2
resource "aws_route_table_association" "route2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.route.id
}



variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
#cidr block for 1st subnet
variable "subnet1_cidr" {
  default = "10.0.1.0/24"
}
#cidr block for 2nd subnet
variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}

#cidr block for 3rd subnet
variable "subnet3_cidr" {
  default = "10.0.3.0/24"
}