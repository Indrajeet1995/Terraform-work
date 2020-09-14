resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "app"
  description = "docker in elastic beanstalk environment"
}

resource "aws_elastic_beanstalk_environment" "ebsenv" {
  name                = "ebsenv"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.3 running Docker"
}
