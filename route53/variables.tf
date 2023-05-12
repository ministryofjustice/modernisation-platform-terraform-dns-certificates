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
  type = string
  description = "type of record to create"
  default = "CNAME"
  
}