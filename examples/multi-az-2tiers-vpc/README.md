# Two Tiers VPC in Multi Availability Zones Example

This folder contains a set of Terraform manifest for deploying a *Two Tiers* VPC in AWS in multiple availability zones.

The end result of this example is a VPC with two public subnets in two different availability zones and two private subnets in the same availability zones of the public subnets. It deploys an internet gateway to be used by the public subnets to allow communication between the subnets and the outside world. It deploys NAT gateways to allow one way communication between the private subnets and the outside world.

## Quick Start

To deploy a Two Tiers VPC in Two Availability Zones:

1. Modify `main.tf` to customize your AWS region.
2. Modify `variables.tf` to customize the VPC name, CIDR blocks, subnets' availability zones, public and private subnets CIDR blocks.
3. Run `terraform init`.
4. Run `terraform apply`.
5. Validate both public and private subnets by deploying EC2 instances in them and try to communicate with them from both outside the VPC and inside the VPC.
