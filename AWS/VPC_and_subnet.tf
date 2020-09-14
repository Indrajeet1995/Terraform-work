resource "aws_vpc" "main" {
  cidr_block       = "190.160.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "190.160.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_instance" "awsinst1" {
  subnet_id     = aws_subnet.subnet1.id
  ami           = "ami-016b213e65284e9c9"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "Assignment-1"
  }
}
