resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  desired_capacity          = 2
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.lconf.name
}

resource "aws_launch_configuration" "lconf" {
  name = "lconf"
  image_id = "ami-0c53c1e5517a8c497"
  instance_type = "t2.micro"
}
