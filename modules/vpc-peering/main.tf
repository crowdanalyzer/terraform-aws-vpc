# ------------------------------------------------------------------------------------------------------------------
# CREATE VPC TO VPC PEERING CONNECTION AND ITS OPTIONS
# ------------------------------------------------------------------------------------------------------------------

resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  auto_accept = true

  tags = merge(
    {
      Name = "${var.requester_vpc_id}-to-${var.accepter_vpc_id}-vpc-peering-connection"
    },
    var.tags
  )
}

resource "aws_vpc_peering_connection_options" "vpc_peering_connection_options" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id

  accepter {
    allow_remote_vpc_dns_resolution  = true
    allow_classic_link_to_remote_vpc = var.enable_classiclink
    allow_vpc_to_remote_classic_link = var.enable_classiclink
  }

  requester {
    allow_remote_vpc_dns_resolution  = true
    allow_classic_link_to_remote_vpc = var.enable_classiclink
    allow_vpc_to_remote_classic_link = var.enable_classiclink
  }
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE ROUTES FOR SUBNETS ROUTE TABLE SO INSTANCES COULD COMMUNICATE WITH EACH OTHER
# ------------------------------------------------------------------------------------------------------------------

resource "aws_route" "requester_vpc_connection_route" {
  route_table_id            = var.requester_vpc_route_table_id
  destination_cidr_block    = var.accepter_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id
}

resource "aws_route" "accepter_vpc_connection_route" {
  route_table_id            = var.accepter_vpc_route_table_id
  destination_cidr_block    = var.requester_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id
}
