
variable "application_name" {
  type        = string
  description = "The application name to be used in non-production deployments"
}

variable "production_service_fqdn" {
  type        = string
  description = "The fully qualified domain name for production deployments"
  default     = ""
}

variable "is-production" {
  type        = bool
  description = "Whether the environment is production or not"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Additional subject alternate name prefixes to add beyond the default wildcard (e.g., ['*.db', 'api'] becomes ['*.db.fqdn', 'api.fqdn'])"
  default     = []
}

variable "zone_name_core_vpc_public" {
  type        = string
  description = "Route53 core-vpc public hosted zone name for certificate validation. Required for non-production deployments"
  
  validation {
    condition     = length(var.zone_name_core_vpc_public) < 65
    error_message = "Zone name must be less than 65 characters."
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}



