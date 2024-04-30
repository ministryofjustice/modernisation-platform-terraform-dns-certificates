variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}


variable "fqdn" {
  type        = string
  description = "DNS name to be used with the zone"

}
variable "record_type" {
  type        = string
  description = "type of record to create"
  default     = "CNAME"

}

variable "aws_account_id" {
  type = any

}

variable "app_name" {
  type = string
  description = "application name"
  
}

# variable "environment_management" {
#   type = map
#   description = "environment name"
  
# }

variable "provider_name" {
  type = string
  description = "vpc provider name"
  
}