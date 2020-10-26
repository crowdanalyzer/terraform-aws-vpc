# Two Two Tiers VPCs in Single Availability Zone With VPC peering Example

This folder contains a set of Terraform manifest for deploying a two *Two Tiers* VPCs in AWS in single availability zone
and launching a vpc peering connection between them.

## Quick Start

To deploy a Two Tiers VPC in Two Availability Zones:

1. Modify `main.tf` to customize your AWS region.
2. Modify `variables.tf` to customize the requester and accepter VPCs.
3. Run `terraform init`.
4. Run `terraform apply -target module.requester_vpc -target module.accepter_vpc`.
5. Run `terraform apply`
6. Upload the private key to one of the node of the two VPCs.
7. Try to ssh from the node containing the private key to the other node using its private IP.

--

## Why is there two `terraform apply` one with targets and one without it?


The "for_each" values found here in the vpc-peering module
```tf
resource "aws_route" "requester_vpc_connection_route" {
  for_each = data.aws_route_tables.requester_vpc_route_tables.ids

  ...
}

resource "aws_route" "accepter_vpc_connection_route" {
  for_each = data.aws_route_tables.accepter_vpc_route_tables.ids

  ...
}
```
depends on a values that cannot be determined until apply. 
So to overcome that, you should apply VPCs first so that these values could be determined.
by running:

```
terraform apply -target module.requester_vpc -target module.accepter_vpc
```

then run:

```
terraform apply
```
