

provider "aws" {
  region = "us-east-1"
}

# vpc
resource "aws_vpc" "lms" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-main"
  }
}

# private subnet <must be dynamic>
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.lms.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    { Name = "${var.env}-private-${var.azs[count.index]}" },
    var.private_subnet_tags
  )
}

# public subnet <must be dynamic>
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.lms.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    { Name = "${var.env}-public-${var.azs[count.index]}" },
    var.public_subnet_tags
  )
}

# internet gateway
resource "aws_internet_gateway" "lms" {
  vpc_id = aws_vpc.lms.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# elastic ip
resource "aws_eip" "lms" {

  tags = {
    Name = "${var.env}-nat"
  }
}

# nat gateway
resource "aws_nat_gateway" "lms" {
  allocation_id = aws_eip.lms.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.env}-nat"
  }

  depends_on = [aws_internet_gateway.lms]
}

# route table private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.lms.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lms.id
  }

  tags = {
    Name = "${var.env}-private"
  }
}

# route table public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lms.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms.id
  }

  tags = {
    Name = "${var.env}-public"
  }
}

# route table association private
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# route table  association public
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
