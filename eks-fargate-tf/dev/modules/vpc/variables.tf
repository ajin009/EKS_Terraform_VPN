variable "vpc_cidr" {
  type = string
}
variable "public_azs"{
    type = list(string)
}
variable "public_subnet_cidr_blocks" {
    type = list(string)
  
}
variable "private_azs" {
  type = list(string)
}
variable "private_subnet_cidr_blocks" {
    type = list(string)
}
variable "vpc_name" {
  type = string
}
variable "pubsubnet_name" {
    type = list(string)
}
variable "prisubnet_name" {
    type = list(string)
}
variable "IG_name" {
    type = string 
}
variable "pubsubroutetable_name" {
  
}
variable "privsubroutetable_name" {
  
}
variable "Nat-GW_name" {
  
}
variable "SG_name" {
  
}