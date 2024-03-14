resource "aws_iam_role" "eks-fargate-profile" {
  name = "eks-fargate-profile"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-fargate-profile" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-profile.name
}


resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name              = var.cluster_name
  fargate_profile_name      = "dev-eks-fargate"
  pod_execution_role_arn    = aws_iam_role.eks-fargate-profile.arn
  subnet_ids                = var.private_subnet_ids
#   vpc_security_group_ids    = var.vpc_security_group_ids

  selector {
    namespace = "kube-system"
  }
  selector {
    namespace = "test"
  }
  selector {
    namespace = "default"
  }
    selector {
    namespace = "dev"
  }
    selector {
    namespace = "prod"
  }
  depends_on = [var.eks_cluster_id]
}