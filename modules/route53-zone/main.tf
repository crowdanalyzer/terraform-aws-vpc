resource "aws_route53_zone" "route53_zone" {
  comment = "Private hosted zone for VPCs created by Terraform."
  name = var.domain_name
  dynamic "vpc" {
    for_each = var.vpcs
    content {
      vpc_id = vpc.value
    }
  }
}
