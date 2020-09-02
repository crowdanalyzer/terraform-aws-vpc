output "vpc_id" {
    value = module.single_az_2tiers_vpc.vpc_id
    description = "The ID of the VPC created by this module."
}

output "cidr_block" {
    value = module.single_az_2tiers_vpc.cidr_block
    description = "The CIDR block of the VPC created by this module."
}

output "public_subnet_id" {
    value = module.single_az_2tiers_vpc.public_subnets_ids[0]
    description = "The Public Subnets ID created by this module."
}

output "private_subnet_id" {
    value = module.single_az_2tiers_vpc.private_subnets_ids[0]
    description = "The Private Subnets ID created by this module."
}

output "private_instance_private_ip" {
    value = aws_instance.private_instance.private_ip
    description = "The Private IP address of the private instance created by this module."
}

output "bastion_host_public_ip" {
    value = module.bastion_host.public_ip
    description = "The Public IP address of the bastion host instance created by this module."
}
