output "vpc_peering_connection_id" {
  value       = aws_vpc_peering_connection.vpc_peering_connection.id
  description = "The ID of the VPC peering connection created by this module."
}

output "vpc_peering_connection_status" {
  value       = aws_vpc_peering_connection.vpc_peering_connection.accept_status
  description = "The status of the VPC peering connection request created by this module."
}
