# ------------------------------------------------------------------------------------------------------------------
# DEPLOY TWO SINGLE AVAILABILITY ZONE TWO TIERS VPC IN AWS WITH VPC PEERING
# This example shows how to use vpc-peering between two vpc-2tiers module to deploy a single availability zone VPC in AWS.
# ------------------------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been developed with 0.13 syntax, which means it is not compatible with any versions below 0.13.
# ------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13, < 0.14"
}

# ------------------------------------------------------------------------------------------------------------------
# AWS PROVIDER
# ------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "us-east"
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY FIRST SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "single_az_2tiers_vpc_1" {
  source = "../../modules/vpc-2tiers"

  name       = "${var.name}-1"
  cidr_block = var.cidr_block_1

  availability_zones = [var.availability_zone_1]
  public_subnets     = [var.public_subnet_1]
  private_subnets    = [var.private_subnet_1]
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY SECOND SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "single_az_2tiers_vpc_2" {
  source = "../../modules/vpc-2tiers"

  name       = "${var.name}-2"
  cidr_block = var.cidr_block_2

  availability_zones = [var.availability_zone_2]
  public_subnets     = [var.public_subnet_2]
  private_subnets    = [var.private_subnet_2]
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY VPC PEERING
# ------------------------------------------------------------------------------------------------------------------

module "vpc_peering" {
  source           = "../../modules/vpc-peering"
  requester_vpc_id = module.single_az_2tiers_vpc_1.vpc_id
  accepter_vpc_id  = module.single_az_2tiers_vpc_2.vpc_id

  requester_vpc_cidr_block = var.cidr_block_1
  accepter_vpc_cidr_block  = var.cidr_block_2

  requester_vpc_route_table_id = module.single_az_2tiers_vpc_1.route_tables_ids[0]
  accepter_vpc_route_table_id  = module.single_az_2tiers_vpc_2.route_tables_ids[0]
}
