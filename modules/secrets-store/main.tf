resource "aws_secretsmanager_secret" "main" {
  name        = var.secret_name
  description = var.secret_description
  kms_key_id  = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = var.secret_name
    }
  )
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(var.secret_value)
}

resource "aws_iam_policy" "secrets_access" {
  name        = "${var.secret_name}-access-policy"
  description = "Policy for accessing the secret ${var.secret_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.main.arn
      }
    ]
  })
} 