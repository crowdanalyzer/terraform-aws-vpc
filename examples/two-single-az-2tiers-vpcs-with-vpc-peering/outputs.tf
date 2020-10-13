output "first_vpc_id" {
  value       = module.single_az_2tiers_vpc_1.vpc_id
  description = "The ID of the first VPC created by this module."
}

output "second_vpc_id" {
  value       = module.single_az_2tiers_vpc_2.vpc_id
  description = "The ID of the second VPC created by this module."
}

output "vpc_peering_id" {
  value       = module.vpc_peering.vpc_peering_connection_id
  description = "The ID of the VPC Connection between the two VPCs."
}

output "vpc_peering_status" {
  value       = module.vpc_peering.vpc_peering_connection_status
  description = "The Status of the VPC Connection between the two VPCs."
}
