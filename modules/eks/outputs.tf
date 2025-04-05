output "cluster_id" {
  description = "ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID of the EKS cluster"
  value       = aws_security_group.eks.id
}

output "fargate_profile_arn" {
  description = "ARN of the Fargate profile"
  value       = aws_eks_fargate_profile.main.arn
}

output "eks_role_arn" {
  description = "ARN of the EKS role"
  value       = aws_iam_role.eks.arn
}

output "fargate_role_arn" {
  description = "ARN of the Fargate role"
  value       = aws_iam_role.fargate.arn
} 