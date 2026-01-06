
variable "application_name" {
  type        = string
  description = "The application name to be used in non-production deployments"
  default     = ""
  validation {
    condition     = !var.is-production || length(var.application_name) == 0
    error_message = "Value for application_name must be provided if environment is not production."
  }
}

variable "production_service_fqdn" {
  type        = string
  description = "The fully qualified domain name for production deployments"
  default     = ""
  validation {
    condition     = var.is-production || length(var.production_service_fqdn) == 0
    error_message = "variable production_service_fqdn is required when is-production is true."
  }
}

variable "is-production" {
  type        = bool
  description = "Whether the environment is production or not"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Additional subject alternate name prefixes to add beyond the default values. There are *.fqdn and *.application_name.fqdn"
}

variable "zone_name_core_vpc_public" {
  type        = string
  description = "Route53 core-vpc public hosted zone name for certificate validation. Required for non-production deployments"
  default = ""
  validation {
    condition     = length(var.zone_name_core_vpc_public) < 65
    error_message = "Zone name must be less than 65 characters."
  }
  validation {
    condition     = !var.is-production || length(var.zone_name_core_vpc_public) == 0
    error_message = "zone_name_core_vpc_public is required when is-production is false."
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
  validation {
    condition     = var.is-production || length(var.zone_name_core_network_services_public) == 0
    error_message = "zone_name_core_network_services_public is required when is-production is true."
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}



