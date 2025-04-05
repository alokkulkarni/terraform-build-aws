output "bedrock_role_arn" {
  description = "ARN of the Bedrock IAM role"
  value       = aws_iam_role.bedrock.arn
}

output "bedrock_policy_arn" {
  description = "ARN of the Bedrock IAM policy"
  value       = aws_iam_role_policy.bedrock.arn
}

output "bedrock_security_group_id" {
  description = "Security group ID for Bedrock access"
  value       = aws_security_group.bedrock.id
} 