# ------------------------------------------------------------------------------------------------------------------
# CREATE PRIVATE ROUTE53 ZONE
# ------------------------------------------------------------------------------------------------------------------

resource "aws_route53_zone" "route53_zone" {
  name    = var.domain_name
  comment = "${var.domain_name} private hosted zone."

  dynamic "vpc" {
    for_each = { for v in var.vpcs : v.id => v.region }

    content {
      vpc_id     = vpc.key
      vpc_region = vpc.value
    }
  }
}
