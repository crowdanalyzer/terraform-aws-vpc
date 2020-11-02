# VPC Modules

![CircleCI](https://circleci.com/gh/crowdanalyzer/terraform-aws-vpc.svg?style=shield&circle-token=568a8fb6dabfb0141664a16745b3619e8e33aae0)

This repo contains modules for creating best practices Virtual Private Clouds (VPCs) on AWS.

## Main Modules

The main module of this repo is

- **[vpc-2tiers](./modules/vpc-2tiers/)**: Launches a *"2 tiers"* VPC that includes public and private subnets, routing rules, security groups, network ACLs, and NAT gateways.

---

## Supporting Modules

This repo contain several supporting modules that add extra functionality on top of the vpc-2tiers module:

- **[vpc-peering](./modules/vpc-peering/)**: Creates peering connection between VPCs. Normally VPCs are completely isolated from each other, but sometimes, you want to allow traffic to flow between them. This module creates peering connections and route table entries that makes this sort of cross-vpc communication possible. **Note** that VPC peering can't exist between two VPCs that have overlapping CIDR blocks.

- **[bastion-host](./modules/bastion-host/)**: Creates an EC2 instance in a public subnet to provide access to instances in a private subnet.

- **[route53-zone](./modules/route53-zone/)**: Creates a Route53 private hosted zone to be used for internal DNS records. These DNS records can be attached to machines and LBs in private subnets & VPCs.

---

## How do you use a module?

To use a module in your Terraform templates, create a `module` resource and sets its `source` field to the GIT url of this repo. You should also set the `ref` parameter so you are fixed to a specific version of this repo, for example to use `v1.0.0` of the `vpc-2tiers` module, you should add the following:

```tf
module "elasticsearch_vpc" {
    source = "git::git@github.com:crowdanalyzer/terraform-aws-vpc//modules/vpc-2tiers?ref=v1.0.0"

    # set the parameters for the vpc-2tiers module
}
```

**Note**: the double slash `//` is intentional and required. It is part of Terraform's Git syntax. See the module documentation and `variables.tf` file for all the parameters you can set. Run `terraform init` to pull the latest version of this module from this repo before running the standard `terraform apply` command.

---

### What is a VPC?

A **VPC** or Virtual Private Cloud, is your own isolated segment of the AWS cloud itself.

### What is a Subnet?

A **subnet** resides inside your VPC, and allows you to segment your VPC infrastructure into multiple different networks. Subnets can only exist in one availability zone. Deploying to multiple availability zones require multiple subnets. Subnets can be public or private.

### What is an Internet Gateway (IGW)?

An **internet gateway** is a bi-directional communication channel between your VPC and the outside world.

### What is a NAT Gatewat?

A **NAT** or Network Address Translation Gateway is a network component that allows outbound access from your subnets to the internet but limits inbound access to them.

### What is a Routes Table?

A **Routes Table** allows the flow of traffic according to certain policies. Traffic within the VPC doesn't need to be routed. When you want to access a resource outside your VPC, you route the traffic through IGW or NAT Gateway.

### What is a NACL?

A **NACL** or Network ACL is the security layer of your VPC. If you want to enforce a security policy at lower level regardless of resources' security groups, use NACLs.
