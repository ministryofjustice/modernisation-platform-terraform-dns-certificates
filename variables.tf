variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}
variable "application_name" {
  type        = string
  description = "Name of application"
}
variable "zone" {
  type        = string
  description = "Zone"

}
variable "dns_name" {
  type        = string
  description = "DNS name to be used with the zone"

}
variable "record_type" {
  type        = string
  description = "type of record to create"
  default     = "CNAME"

}
variable "set_identifier" {
  type        = string
  description = "Unique identifier to differentiate records with routing policies from one another."

}
variable "record" {
  type        = string
  description = "A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM"

}
variable "acm_certificate_needed" {
  description = "Flag to determin if acm certificate if needed"
  type        = bool

}
variable "gandi_certificate_needed" {
  description = "Flag to determin if gandi certificate is needed"
  type        = bool

}
variable "ssm_private_key" {
  description = "cert key from aws parameter store or secrets manager"


}
variable "certificate_body" {
  description = ""
  type        = string
}

variable "certificate_chain" {
  description = "Path to the certificate chain file"
}

variable "private_key" {
  description = "Path to the private key file"
}
variable "alias_zone" {
  type = string

}
variable "alias_dns_name" {
  type = string

}
variable "aws_account_id" {
  type = any

}