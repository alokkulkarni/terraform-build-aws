# Production Environment

This directory contains the Terraform configuration for the production environment.

## Prerequisites

- Terraform 1.0.0 or later
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state storage
- DynamoDB table for Terraform state locking

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the changes:
   ```bash
   terraform apply
   ```

## Environment Configuration

The production environment is configured with the following resources:

- VPC with public and private subnets
- EKS cluster
- RDS instance
- DynamoDB table
- Secrets Store

## Variables

The following variables are required:

- `project_name`: Name of the project
- `environment`: Environment name (default: "prod")
- `db_password`: Database password
- `api_key`: API key for external services
- `kms_key_id`: KMS key ID used for encryption

## Outputs

The following outputs are available:

- VPC ID
- EKS cluster endpoint
- RDS endpoint
- DynamoDB table name
- Secrets Store ARN 