# Two Tiers VPC in a Single Availability Zone with Bastion Host Example

This folder contains a set of Terraform manifest for deploying a *Two Tiers* VPC in a single availability zone with a *bastion host* and a private *route53 zone* in AWS.

The end result of this example is a VPC with one public subnet and one private subnet. A private EC2 instance in the private subnet which is only accessible through the bastion host. A bastion host in the public subnet. And, a private route53 hosted zone.

## Quick Start

To deploy a Two Tiers VPC in a Single Availability Zone with Bastion Host:

1. Modify `main.tf` to customize your AWS region.
2. Modify `variables.tf` to customize the VPC name, CIDR block, availability zones, public subnet CIDR block, private subnet CIDR block, route53 zone domain name, ssh port, ami of both the bastion host and private ec2 instances and bastion host and private ec2 instance's instance type.
3. Add `test-key` file with your public key to be authenticated on both the EC2 private instance and bastion host.
3. Run `terraform init`.
4. Run `terraform apply`.
5. Validate that you can't ssh into the private EC2 instance from you local machine, however using ssh-agent forward, you can ssh into it from the bastion host.
