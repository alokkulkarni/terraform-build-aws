module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = "10.2.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  project_name       = var.project_name
  environment        = var.environment
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "${var.project_name}-${var.environment}"
  kubernetes_version = "1.28"
  subnet_ids         = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  project_name       = var.project_name
  environment        = var.environment
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "rds" {
  source = "../../modules/rds"

  db_instance_identifier = "${var.project_name}-${var.environment}"
  db_name               = "appdb"
  db_username           = "admin"
  db_password           = var.db_password
  subnet_ids            = module.vpc.private_subnet_ids
  vpc_id                = module.vpc.vpc_id
  allowed_security_groups = [module.eks.cluster_security_group_id]
  instance_class        = "db.r5.large"
  multi_az              = true
  project_name          = var.project_name
  environment           = var.environment
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "${var.project_name}-${var.environment}"
  hash_key   = "id"
  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
  kms_key_id = var.kms_key_id
  project_name = var.project_name
  environment  = var.environment
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "secrets_store" {
  source = "../../modules/secrets-store"

  secret_name        = "${var.project_name}-${var.environment}-secrets"
  secret_description = "Secrets for ${var.project_name} ${var.environment} environment"
  secret_value = {
    db_password = var.db_password
    api_key     = var.api_key
  }
  kms_key_id = var.kms_key_id
  project_name = var.project_name
  environment  = var.environment
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
} 