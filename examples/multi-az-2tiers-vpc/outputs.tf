output "vpc_id" {
  value       = module.multi_az_2tiers_vpc.vpc_id
  description = "The ID of the VPC created by this module."
}

output "cidr_block" {
  value       = module.multi_az_2tiers_vpc.cidr_block
  description = "The CIDR block of the VPC created by this module."
}

output "public_subnets_ids" {
  value       = module.multi_az_2tiers_vpc.public_subnets_ids
  description = "A list of Public Subnets IDs created by this module."
}

output "private_subnets_ids" {
  value       = module.multi_az_2tiers_vpc.private_subnets_ids
  description = "A list of Private Subnets IDs created by this module."
}

output "nat_gateways_public_ips" {
  value       = module.multi_az_2tiers_vpc.nat_gateways_public_ips
  description = "A list of Public IP addresses used by the NAT gateways created by this module."
}
