variable "domain_name" {
  description = "Domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of subject alternative names"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "Route53 zone ID for DNS validation"
  type        = string
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 