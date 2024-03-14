resource "aws_instance" "ec2_instance" {
  ami                      = var.ami
  instance_type            = var.instance_type
  key_name                 = var.key
  subnet_id                = var.public_subnet_id
  vpc_security_group_ids   = var.vpc_security_group_ids
  user_data                = var.user_data
  tags                     = {
    Name                   = var.instance_name
  }
}