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

---

## Why do you need to run `terraform apply` twice?


The **for_each** values found here in the vpc-peering module depend on values that cannot be determined until apply.

```hcl
resource "aws_route" "requester_vpc_connection_route" {
  for_each = data.aws_route_tables.requester_vpc_route_tables.ids

  // ...
}

resource "aws_route" "accepter_vpc_connection_route" {
  for_each = data.aws_route_tables.accepter_vpc_route_tables.ids

  // ...
}
```

So to overcome this, you should apply creating the VPCs first so that these values can be determined.


Run this:
```
terraform apply -target module.requester_vpc -target module.accepter_vpc
```

then run this:
```
terraform apply
```
