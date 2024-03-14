output "vpc_id" {
    value = aws_vpc.projectVPC.id 
}
output "public_subnet_ids" {
  value = aws_subnet.pubsub[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.privatesub[*].id
}
output "pubsub" {
value =  aws_subnet.pubsub[*].id
}
output "security_group_id" {
  value = aws_security_group.projectVPCsg.id
}