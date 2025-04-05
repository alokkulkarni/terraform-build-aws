# Development Environment

This directory contains the Terraform configuration for the development environment.

## Prerequisites

- Terraform 1.0.0 or later
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state storage
- DynamoDB table for Terraform state locking

## Usage

1. Configure the environment:
   ```bash
   ./configure.sh
   ```
   This will:
   - Create a terraform.tfvars file from the template if it doesn't exist
   - Prompt you to choose between single AZ or two AZs deployment
   - Guide you to update the required variables

2. Update the variables in terraform.tfvars:
   - Set your database password
   - Set your API key
   - Set your KMS key ARN

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the planned changes:
   ```bash
   terraform plan
   ```

5. Apply the changes:
   ```bash
   terraform apply
   ```

## Environment Configuration

The development environment is configured with the following resources:

- VPC with public and private subnets
- EKS cluster
- RDS instance
- DynamoDB table
- Secrets Store

## Variables

The following variables are required:

- `project_name`: Name of the project
- `environment`: Environment name (default: "dev")
- `db_password`: Database password
- `api_key`: API key for external services
- `kms_key_id`: KMS key ID used for encryption
- `az_count`: Number of availability zones to use (1 or 2, default: 1)

### AZ Configuration

The development environment supports two configurations:

1. Single AZ (default):
   - One public subnet
   - One private subnet
   - Single AZ deployment for RDS
   - Cost-optimized for development

2. Two AZs:
   - Two public subnets
   - Two private subnets
   - Multi-AZ deployment for RDS
   - Better availability but higher cost

To change the AZ configuration, you can either:
1. Run the configuration script:
   ```bash
   ./configure.sh
   ```
2. Or modify the `az_count` variable in `terraform.tfvars`:
   ```hcl
   az_count = 2  # For two AZs
   ```

## Outputs

The following outputs are available:

- VPC ID
- EKS cluster endpoint
- RDS endpoint
- DynamoDB table name
- Secrets Store ARN 