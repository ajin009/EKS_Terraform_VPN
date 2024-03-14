resource "aws_efs_file_system" "efs-1" {
  creation_token             = "my-product"
  performance_mode           = "generalPurpose" 
  encrypted                  = true 
  tags                       = {
    Name                     = "prod-efs"
  }
}
resource "aws_efs_mount_target" "efs-mt" {
   count                     = length(var.private_subnet_ids)
   file_system_id            = aws_efs_file_system.efs-1.id
   subnet_id                 = var.private_subnet_ids[count.index]
   security_groups           = var.vpc_security_group_ids
 }