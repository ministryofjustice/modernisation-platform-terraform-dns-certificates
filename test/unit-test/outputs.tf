# output "zone_id" {
#   value = module.dns_mod.name
# }

output "vps_network" {
  value = var.networking[0].business-unit
  
}

output "localenv" {
  value = var.networking[0].set
  
}