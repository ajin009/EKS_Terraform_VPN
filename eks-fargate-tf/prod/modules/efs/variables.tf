variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_security_group_ids" {
  description = "List of security group IDs for the EC2 instance."
}