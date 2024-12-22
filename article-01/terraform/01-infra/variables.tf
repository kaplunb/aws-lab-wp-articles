variable "region" {}
variable "availability_zone_a" {}
variable "availability_zone_b" {}
variable "ami_ubuntu" {}
variable "vpc_cidr" {}
variable "public_subnet_a_cidr" {}
variable "public_subnet_b_cidr" {}
variable "private_subnet_a_cidr" {}
variable "private_subnet_b_cidr" {}
variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}
variable "db_user" {}
variable "db_name" {}
variable "db_password" {}
