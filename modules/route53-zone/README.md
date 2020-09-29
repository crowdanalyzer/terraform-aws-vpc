# Route53 Hosted Zone Terraform Module

This terraform module creates a route53 private hosted zone to be used as internal DNS records we can attache to machines and LBs in private VPCs as well as EC2-Classic links

---

## How do you use this module?

```tf
module "hosted_zone" {
  source      = "../../modules/route53-zone"
  domain_name = "test-tf.crowdanalyzer.com"
  vpcs        = ["vpc-02a23b6f6cea2d5c7" ,"vpc-0e57caaa2c040828b"]
}

```
