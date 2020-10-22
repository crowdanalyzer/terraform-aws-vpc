output "requester_vpc_id" {
  value       = module.requester_vpc.vpc_id
  description = "The ID of the requester VPC created by this module."
}

output "accepter_vpc_id" {
  value       = module.accepter_vpc.vpc_id
  description = "The ID of the accepter VPC created by this module."
}

output "vpc_peering_connection_id" {
  value       = module.vpc_peering.vpc_peering_connection_id
  description = "The ID of the VPC peering connection between the two VPCs."
}

output "vpc_peering_connection_status" {
  value       = module.vpc_peering.vpc_peering_connection_status
  description = "The status of the VPC peering connection between the two VPCs."
}
