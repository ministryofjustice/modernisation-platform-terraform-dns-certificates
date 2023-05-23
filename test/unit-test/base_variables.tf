variable "networking" {

  type = list(any)

}
variable "security_group_ingress_from_port" {
  type    = string
  default = "443"

}

variable "security_group_ingress_to_port" {
  type    = string
  default = "443"

}
variable "security_group_ingress_protocol" {
  type    = string
  default = "TCP"
}
