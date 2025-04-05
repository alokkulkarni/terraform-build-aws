variable "account_name" {
  description = "Name of the AWS account"
  type        = string
}

variable "account_email" {
  description = "Email address for the AWS account"
  type        = string
}

variable "control_tower_controls" {
  description = "Map of Control Tower controls to enable"
  type        = map(string)
  default     = {}
} 