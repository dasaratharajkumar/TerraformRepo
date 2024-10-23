resource "aws_vpc" "main_squad1" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_internet_gateway" "ig_squad1" {
  vpc_id = aws_vpc.main_squad1.id
}

resource "aws_subnet" "public_subnet1_squad1" {
  vpc_id            = aws_vpc.main_squad1.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-subnet-1-squad1"
  }
}

resource "aws_subnet" "public_subnet2_squad1" {
  vpc_id            = aws_vpc.main_squad1.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "public-subnet-2-squad1"
  }
}

resource "aws_subnet" "private_subnet1_squad1" {
  vpc_id            = aws_vpc.main_squad1.id
  cidr_block        = "172.16.100.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-subnet-1-squad1"
  }
}

resource "aws_subnet" "private_subnet2_squad1" {
  vpc_id            = aws_vpc.main_squad1.id
  cidr_block        = "172.16.101.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-subnet-2-squad1"
  }
}

resource "aws_route_table" "public_route_table_squad1" {
  vpc_id = aws_vpc.main_squad1.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.ig_squad1.id
    type           = "gateway"
  }
}


resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.main_squad1.id
  tags = {
    Name = "eks-sg-squad1"
  }

  ingress {
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
}


resource "aws_route_table_association" "public_route_table_assoc1_squad1" {
  route_table_id = aws_route_table.public_route_table_squad1.id
  subnet_id      = aws_subnet.public_subnet1_squad1.id
}

resource "aws_route_table_association" "public_route_table_assoc2_squad1" {
  route_table_id = aws_route_table.public_route_table_squad1.id
  subnet_id      = aws_subnet.public_subnet2_squad1.id
}

resource "aws_route_table" "private_route_table_squad1" {
  vpc_id = aws_vpc.main_squad1.id
}

resource "aws_route_table_association" "private_route_table_assoc1_squad1" {
  route_table_id = aws_route_table.private_route_table_squad1.id
  subnet_id      = aws_subnet.private_subnet1_squad1.id
}

resource "aws_route_table_association" "private_route_table_assoc2_squad1" {
  route_table_id = aws_route_table.private_route_table_squad1.id
  subnet_id      = aws_subnet.private_subnet2_squad1.id
}