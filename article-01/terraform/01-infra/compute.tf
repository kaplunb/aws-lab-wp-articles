# compute.tf
resource "aws_key_pair" "wp_ssh_key" {
  key_name_prefix = "wp-ssh-key"
  public_key      = var.ssh_public_key
}

resource "aws_instance" "wp_instance_web" {
  ami                         = var.ami_ubuntu
  instance_type              = "t2.micro"
  subnet_id                  = aws_subnet.wp_subnet_public_a.id
  vpc_security_group_ids     = [aws_security_group.wp_sg_web.id]
  key_name                   = aws_key_pair.wp_ssh_key.key_name
  associate_public_ip_address = true

  user_data_base64 = base64encode(templatefile("${path.module}/instance-cloud-init.tftpl", {
    db_name        = var.db_name
    db_user        = var.db_user
    db_password    = var.db_password
    db_host        = "127.0.0.1"
  }))

  tags = {
    Name = "wp_web_server"
  }
}