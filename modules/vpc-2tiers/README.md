# VPC-2Tiers Terraform Module

This terraform module launches a single VPC. This VPC defines **two tiers** of subnets:

- **Public Subnets**: Resources in these subnets are directly accessable from the Internet. Only public facing resources (typically just load balancers and the bastion host) should be put here.

- **Private Subnets**: Resources in these subnets are *NOT* directly accessible from the internet, but they can make outbound connections to the internet through a NAT Gateway. You can connect to the resources in this subnet from resources within the VPC. So you should put your app servers here and allow the load balancers in the public subnet to route traffic to them.

---

## SSH Access via the Bastion Host

To ssh into any of your EC2 instances in a private subnet, we recommend launching a single *"Bastion Host"* to use as an SSH jump host.

---

## How do you use this module?

This folder defines a terraform module, which you can use in your code by adding a module configuration and setting its `source` parameter to `URL` of this folder:

```tf
module "vpc_2tiers" {
  # Use version v1.0.0 of the vpc-2tiers module
  source = "git::git@github.com/crowdanalyzer/terraform-aws-vpc//modules/vpc-2tiers?ref=v1.0.0"

  # Specify the name of the VPC.
  name = "sansa-stark"

  # Specify the CIDR block of the VPC.
  cidr_block = "11.11.11.0/24"

  # Specify the availability zones to launch both public and private subnets in
  availability_zones = ["us-east-1a", "us-east-1b"]

  # Specify the CIDR blocks of the public subnets
  public_subnets = ["11.11.11.0/28", "11.11.11.16/28"]

  # specify the CIDR blocks of the private subnets
  private_subnets = ["11.11.11.32/28", "11.11.11.64/28"]

  # ... See variables.tf for the other parameters you can specify for the vpc-2tiers module
}
```
