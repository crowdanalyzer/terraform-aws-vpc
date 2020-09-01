output "vpc_id" {
    value = aws_vpc.vpc.id
    description = "The ID of the VPC created by this module."
}

output "cidr_block" {
    value = aws_vpc.vpc.cidr_block
    description = "The CIDR block of the VPC created by this module."
}

output "public_subnets_ids" {
    value = values(aws_subnet.public_subnets)[*].id
    description = "A list of Public Subnets IDs created by this module."
}

output "private_subnets_ids" {
    value = values(aws_subnet.private_subnets)[*].id
    description = "A list of Private Subnets IDs created by this module."
}

output "nat_gateways_public_ips" {
    value = values(aws_eip.eips)[*].public_ip
    description = "A list of Public IP addresses used by the NAT gateways created by this module."
}
