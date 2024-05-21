variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}

variable "fqdn" {
  type        = string
  description = "DNS name to be used with the zone"

}
variable "is-production" {
  type        = bool
  description = "is this for production or non production"

}
