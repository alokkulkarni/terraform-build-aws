# Terraform AWS Infrastructure

This repository contains Terraform modules for deploying AWS infrastructure following the Well-Architected Framework.

## Prerequisites

- Terraform 1.0.0 or later
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state storage
- DynamoDB table for Terraform state locking

## Project Structure

```
.
├── modules/
│   ├── account-landing-zone/
│   ├── vpc/
│   ├── eks/
│   ├── alb/
│   ├── rds/
│   ├── lambda/
│   ├── dynamodb/
│   ├── route53/
│   ├── secrets-store/
│   ├── certificate/
│   └── bedrock/
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

## Modules

The following modules are available:

- `account-landing-zone`: Sets up AWS account and landing zone
- `vpc`: Creates VPC with public and private subnets
- `eks`: Deploys EKS cluster with Fargate and Karpenter support
- `alb`: Configures Application Load Balancer
- `rds`: Sets up RDS instance
- `lambda`: Deploys Lambda functions
- `dynamodb`: Creates DynamoDB tables
- `route53`: Manages DNS records
- `secrets-store`: Stores secrets in AWS Secrets Manager
- `certificate`: Issues SSL certificates
- `bedrock`: Integrates with Amazon Bedrock

## Environments

Three environments are provided:

- `dev`: Development environment
  - Configurable with 1 or 2 availability zones
  - Cost-optimized for development
  - Includes configuration script for easy setup
  - Uses template file for variable configuration
- `staging`: Staging environment
  - Two availability zones
  - Production-like configuration
- `prod`: Production environment
  - Three availability zones
  - High availability configuration

Each environment has its own configuration and state file.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/terraform-aws-infrastructure.git
   cd terraform-aws-infrastructure
   ```

2. Navigate to the desired environment:
   ```bash
   cd environments/dev  # or staging or prod
   ```

3. For development environment, configure the AZ setup:
   ```bash
   ./configure.sh
   ```
   This will create a terraform.tfvars file from the template and guide you through the configuration.

4. Update the variables in terraform.tfvars:
   - Set your database password
   - Set your API key
   - Set your KMS key ARN

5. Initialize Terraform:
   ```bash
   terraform init
   ```

6. Review the planned changes:
   ```bash
   terraform plan
   ```

7. Apply the changes:
   ```bash
   terraform apply
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 