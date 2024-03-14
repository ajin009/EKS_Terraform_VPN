variable "ami" {
    type = string  
}
variable "instance_type" {
    type = string  
}
variable "key" {
  type = string
}
variable "user_data" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "SG_name" {
  
}
variable "vpc_security_group_ids" {
  description = "List of security group IDs for the EC2 instance."
}
variable "public_subnet_id" {
  type = string
}