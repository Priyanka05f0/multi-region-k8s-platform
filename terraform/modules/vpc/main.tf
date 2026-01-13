provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
    Region  = var.region
  }
}

# Public Subnet in AZ A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-subnet-a"
    Project = var.project_name
    Region  = var.region
  }
}

# Public Subnet in AZ B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-subnet-b"
    Project = var.project_name
    Region  = var.region
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
    Region  = var.region
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.project_name}-rt"
    Project = var.project_name
    Region  = var.region
  }
}

# Route Table Association for Subnet A
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Route Table Association for Subnet B
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
