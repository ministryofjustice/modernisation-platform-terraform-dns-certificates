
variable "application_name" {
  type        = string
  description = "The application name to be used in non-production deployments"
}

variable "production_service_fqdn" {
  type        = string
  description = "The fully qualified domain name for production deployments"
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

variable "zone_id_core_vpc_public" {
  type        = string
  description = "Route53 core-vpc public hosted zone ID for certificate validation"
}

variable "zone_id_core_network_services_public" {
  type        = string
  description = "Route53 core-network-services public hosted zone ID for certificate validation"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}



