variable "cluster_name" {
    type = string 
}
variable "cluster_version" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}