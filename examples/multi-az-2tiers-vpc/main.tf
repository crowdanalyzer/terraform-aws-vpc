# ------------------------------------------------------------------------------------------------------------------
# DEPLOY A MULTI AVAILABILITY ZONE TWO TIERS VPC IN AWS
# This example shows how to use vpc-2tiers module to deploy a multi availability zone VPC in AWS.
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
# DEPLOY MULTI AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "multi_az_2tiers_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.name
  cidr_block = var.cidr_block

  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "hosted_zone" {
  source      = "../../modules/route53-zone"
  domain_name = "test-tf.crowdanalyzer.com"
  vpcs        = [{ "vpc_id" = "vpc-02a23b6f6cea2d5c7" }, { "vpc_id" = "vpc-0e57caaa2c040828b" }]
}