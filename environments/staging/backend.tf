terraform {
  backend "s3" {
    bucket         = "myapp-terraform-state"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "myapp-terraform-state-lock"
  }
} 