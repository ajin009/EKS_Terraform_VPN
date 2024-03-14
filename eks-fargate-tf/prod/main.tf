module "vpc" {
  source                     = "./modules/vpc"
  vpc_name                   = var.vpc_name
  vpc_cidr                   = var.vpc_cidr
  public_azs                 = var.public_azs
  private_azs                = var.private_azs
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  pubsubnet_name             = var.pubsubnet_name
  prisubnet_name             = var.prisubnet_name
  SG_name                    = var.SG_name
  IG_name                    = var.IG_name
  pubsubroutetable_name      = var.pubsubroutetable_name
  privsubroutetable_name     = var.privsubroutetable_name
  Nat-GW_name                = var.Nat-GW_name
}
module "ec2" {
  source                     = "./modules/ec2"
  ami                        = var.ami
  instance_type              = var.instance_type
  key                        = var.key
  user_data                  = var.user_data
  public_subnet_id           = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids     = [module.vpc.security_group_id]
  instance_name              = var.instance_name
  SG_name                    = var.SG_name  
}

module "efs" {
  source                     = "./modules/efs"
  private_subnet_ids         = module.vpc.private_subnet_ids
  vpc_security_group_ids     = [module.vpc.security_group_id]
}

module "eks" {
  source                     = "./modules/eks"
  cluster_name               = var.cluster_name
  cluster_version            = var.cluster_version
  private_subnet_ids         = module.vpc.private_subnet_ids
}
module "eks-profile" {
  source                     = "./modules/eks-profile"
  cluster_name               = var.cluster_name
  private_subnet_ids         = module.vpc.private_subnet_ids
  vpc_security_group_ids     = [module.vpc.security_group_id]
  eks_cluster_id             = module.eks.eks_cluster_id
}
