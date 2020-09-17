resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  dynamic "vpc" {
    for_each = var.vpcs
    content {
      vpc_id = vpc.value.vpc_id
    }
  }
}
