
variable "application_name" {
  type        = string
  description = "The application name to be used in non-production deployments"
  default     = ""
}

variable "production_service_fqdn" {
  type        = string
  description = "The fully qualified domain name for production deployments"
  default     = ""
  validation {
    condition     = length(var.production_service_fqdn) < 65
    error_message = "Production FQDN must be less than 65 characters."
  }
}

variable "is-production" {
  type        = bool
  description = "Whether the environment is production or not"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Additional subject alternate name prefixes to add beyond the default values. There are *.fqdn and *.application_name.fqdn"
  validation {
    condition = alltrue([
      for name in var.subject_alternative_names :
      !can(regex("^\\*$", name)) && (can(regex("^\\*\\.", name)) ? length(split(".", name)) >= 2 : true)
    ])
    error_message = "The added Subject alternative names cannot be a bare wildcard '*'. Wildcards must include at least a subdomain, e.g., '*.app' or '*.db'."
  }
}

variable "zone_name_core_vpc_public" {
  type        = string
  description = "Route53 core-vpc public hosted zone name for certificate validation. Required for non-production deployments"
  default     = ""
  validation {
    condition     = length(var.zone_name_core_vpc_public) < 65
    error_message = "Zone name must be less than 65 characters."
  }
}

variable "zone_name_core_network_services_public" {
  type        = string
  description = "Route53 core-network-services public hosted zone ID for certificate validation. Required for production deployments"
  default     = ""
  validation {
    condition     = length(var.zone_name_core_network_services_public) < 65
    error_message = "Zone name must be less than 65 characters."
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}



