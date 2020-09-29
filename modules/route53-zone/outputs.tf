output "zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
  description = "Route53 Zone ID, most likely to be used to attach ELB to a DNS record."
}
