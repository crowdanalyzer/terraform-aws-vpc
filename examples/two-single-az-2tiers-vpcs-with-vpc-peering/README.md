# Two Two Tiers VPCs in Single Availability Zone With VPC peering Example

This folder contains a set of Terraform manifest for deploying a two *Two Tiers* VPCs in AWS in single availability zone
and create vpc peering connection between the two vpcs

## Quick Start

To deploy a Two Tiers VPC in Two Availability Zones:

1. Modify `main.tf` to customize your AWS region.
2. Modify `variables.tf` to customize the VPC name, CIDR blocks, subnets' availability zones, public and private subnets CIDR blocks.
3. Run `terraform init`.
4. Run `terraform apply`.
5. Create instances in each VPC and try to ping each other.
