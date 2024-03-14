variable "private_subnet_ids" {
  type = list(string)
}
variable "cluster_name" {
  type = string
}
variable "eks_cluster_id" {
  type = string
}
variable "vpc_security_group_ids" {
  description = "List of security group IDs for the EC2 instance."
}