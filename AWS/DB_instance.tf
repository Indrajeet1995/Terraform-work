provider "aws" {
  profile = "terraformuser"
  region  = "us-east-2"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "9.6.9"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "user1"
  password             = "user1pass"
}
