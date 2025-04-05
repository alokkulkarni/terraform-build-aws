output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.main.arn
}

output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.main.name
}

output "table_stream_arn" {
  description = "ARN of the DynamoDB table stream"
  value       = aws_dynamodb_table.main.stream_arn
}

output "table_stream_label" {
  description = "Label of the DynamoDB table stream"
  value       = aws_dynamodb_table.main.stream_label
} 