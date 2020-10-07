output "vpc_peering_connection" {
  value       = aws_vpc_peering_connection.vpc_peering.id
  description = "The ID of the VPC Peering Connection."
}

output "vpc_peering_connection_status" {
  value       = aws_vpc_peering_connection.vpc_peering.accept_status
  description = "The status of the VPC Peering Connection request."
}
