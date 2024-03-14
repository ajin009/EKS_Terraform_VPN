output "cluster_version" {
  value = var.cluster_version
}
output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}
output "eks_cluster_id" {
  value = aws_eks_cluster.cluster.id
}
