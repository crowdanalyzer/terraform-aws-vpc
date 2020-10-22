# ------------------------------------------------------------------------------------------------------------------
# DEPLOY TWO SINGLE AVAILABILITY ZONE TWO TIERS VPC IN AWS WITH VPC PEERING
# This example shows how to use vpc-peering between two vpc-2tiers modules deployed in a single availability zone VPC in AWS.
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
  region = "us-east-1"
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY FIRST SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "requester_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.requester_vpc_name
  cidr_block = var.requester_vpc_cidr_block

  availability_zones = [var.requester_vpc_availability_zone]
  public_subnets     = [var.requester_vpc_public_subnet]
  private_subnets    = [var.requester_vpc_private_subnet]
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY SECOND SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "accepter_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.accepter_vpc_name
  cidr_block = var.accepter_vpc_cidr_block

  availability_zones = [var.accepter_vpc_availability_zone]
  public_subnets     = [var.accepter_vpc_public_subnet]
  private_subnets    = [var.accepter_vpc_private_subnet]
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY VPC PEERING
# ------------------------------------------------------------------------------------------------------------------

module "vpc_peering" {
  source           = "../../modules/vpc-peering"
  requester_vpc_id = module.requester_vpc.vpc_id
  accepter_vpc_id  = module.accepter_vpc.vpc_id
}
