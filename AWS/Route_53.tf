provider "aws" {
  profile = "terraform_user"
  region  = "us-east-2"
}

data "aws_elb_hosted_zone_id" "main" {
}

resource "aws_route53_zone" "primary" {
  name = "www.example.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = aws_route53_zone.primary.name
  type    = "A" 

  alias {
    name                   = aws_elb.elb.name
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }
}

resource "aws_elb" "elb" {
  name      = "terraform-elb"
  instances = [aws_instance.inst-1.id, aws_instance.inst-2.id]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "inst-1" {
  ami           = "ami-016b213e65284e9c9"
  instance_type = "t2.micro"
}

resource "aws_instance" "inst-2" {
  ami           = "ami-016b213e65284e9c9"
  instance_type = "t2.micro"
}
