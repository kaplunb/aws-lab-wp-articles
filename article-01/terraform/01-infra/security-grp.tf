# security-grp.tf
resource "aws_security_group" "wp_sg_web" {
  name        = "wp_sg_web"
  description = "Security group for WordPress web server"
  vpc_id      = aws_vpc.wp_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp_sg_web"
  }
}
