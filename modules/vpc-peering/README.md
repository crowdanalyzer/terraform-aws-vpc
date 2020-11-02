# VPC-Peering Terraform Module

This terraform module launches a VPC connection Between two VPCs.

## What is A VPC peering?

A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses. Instances in either VPC can communicate with each other as if they are within the same network.
The VPCs can be in different regions (also known as an inter-region VPC peering connection).

---

## How do you use this module?

This folder defines a terraform module, which you can use in your code by adding a module configuration and setting its `source` parameter to `URL` of this folder:

```tf
module "vpc_peering" {
  # Use version v1.0.0 of the vpc-peering module
  source = "git::git@github.com:crowdanalyzer/terraform-aws-vpc//modules/vpc-peering?ref=v1.0.0"

  # Specify the ID of the first VPC.
  requester_vpc_id = "vpc-013a862580e738b14"

  # Specify the ID of the second VPC.
  accepter_vpc_id = "vpc-0483bbc9e72869fe5"
}
```

**Note**
You cannot create a VPC peering connection between VPCs that have matching or overlapping IPv4 or IPv6 CIDR blocks.
