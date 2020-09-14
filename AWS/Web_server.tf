resource "aws_instance" "web_instance" {
  ami             = "ami-016b213e65284e9c9"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sh /tmp/script.sh",
    ]
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
