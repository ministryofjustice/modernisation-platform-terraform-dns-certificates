variable "fqdn" {
  description = "The fully qualified domain name (FQDN) for which the DNS record should be created"
  type        = string
}

variable "record_type" {
  description = "The type of DNS record to create (e.g., CNAME, A, etc.)"
  type        = string
}

variable "environment" {
    type = string
  
}