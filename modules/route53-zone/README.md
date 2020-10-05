# Route53 Hosted Zone Terraform Module

This terraform module creates a Route53 private hosted zone to be used for internal DNS records. These DNS records can be attached to machines and LBs in private subnets & VPCs as well as EC2-Classic links.

---

## How do you use this module?

This folder defines a terraform module, which you can use in your code by adding a module configuration and setting its `source` parameter to `URL` of this folder:

```hcl
module "route53_zone" {
  # Use version v1.0.0 of the route53-zone module
  source = "git::git@github.com:crowdanalyzer/terraform-aws-vpc//modules/route53-zone?ref=v1.0.0"

  # Specify the domain name of the hosted zone.
  domain_name = "aria-stark.crowdanalyzer.com"

  # Specify the VPCs to associate with the private hosted zone.
  vpcs = [{
    id     = "vpc-xxxxxxxxxx"
    region = "us-east-1"
  }]

  # ... See variables.tf for the other parameters you can specify for the route53-zone module
}
```
