resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins sg"
  description = "jenkins 8080"
  vpc_id      = var.vpc_id
  ingress {
    description      = "jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks   = [var.whitelist-cidrs]
  }
  ingress {
    description      = "ssh "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks   = [var.whitelist-cidrs]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jenkins sg"
  }
}