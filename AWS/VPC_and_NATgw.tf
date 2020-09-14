resource "aws_vpc" "main" {
  cidr_block       = "190.160.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "190.160.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "190.160.2.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "subnet2"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "byoip-ip" {
  vpc              = true
  timeouts {
    delete = "3m"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.byoip-ip.id
  subnet_id     = aws_subnet.subnet1.id
}



resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}


resource "aws_route_table_association" "public-subnet-1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-rt.id
}
