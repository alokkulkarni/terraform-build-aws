variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "API key for external services"
  type        = string
  sensitive   = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones to use (1 or 2)"
  type        = number
  default     = 1

  validation {
    condition     = var.az_count >= 1 && var.az_count <= 2
    error_message = "AZ count must be either 1 or 2 for development environment."
  }
} 