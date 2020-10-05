# ------------------------------------------------------------------------------------------------------------------
# CREATE PRIVATE ROUTE53 ZONE
# ------------------------------------------------------------------------------------------------------------------

resource "aws_route53_zone" "route53_zone" {
  name    = var.domain_name
  comment = "${var.domain_name} private hosted zone."

  dynamic "vpc" {
    for_each = { for v in var.vpcs : v.id => v }

    content {
      vpc_id     = vpc.value.id
      vpc_region = vpc.value.region
    }
  }

  tags = merge(
    {
      Domain  = var.domain_name
      Private = true
    },
    var.tags
  )
}
