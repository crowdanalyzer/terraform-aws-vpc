# ------------------------------------------------------------------------------------------------------------------
# CREATE VPC TO VPC PEERING CONNECTION AND ITS OPTIONS
# ------------------------------------------------------------------------------------------------------------------

resource "aws_vpc_peering_connection" "vpc_peering" {
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

resource "aws_vpc_peering_connection_options" "vpc_peering_options" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

  accepter {
    allow_remote_vpc_dns_resolution  = true
    allow_classic_link_to_remote_vpc = true
    allow_vpc_to_remote_classic_link = true
  }

  requester {
    allow_remote_vpc_dns_resolution  = true
    allow_classic_link_to_remote_vpc = true
    allow_vpc_to_remote_classic_link = true
  }
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE ROUTES FOR SUBNETS ROUTE TABLE SO INSTANCES COULD COMMUNICATE WITH EACH OTHER
# ------------------------------------------------------------------------------------------------------------------

resource "aws_route" "requester_vpc_connection_route" {
  route_table_id            = data.aws_route_table.requester_subnet_route_table.id
  destination_cidr_block    = data.aws_subnet.accepter_subnet.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "accepter_vpc_connection_route" {
  route_table_id            = data.aws_route_table.accepter_subnet_route_table.id
  destination_cidr_block    = data.aws_subnet.requester_subnet.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

# ------------------------------------------------------------------------------------------------------------------
# GET VPC SUBNETS AND ROUTE TABLES
# ------------------------------------------------------------------------------------------------------------------

data "aws_subnet" "requester_subnet" {
  id = var.requester_vpc_subnet_id
}

data "aws_subnet" "accepter_subnet" {
  id = var.accepter_vpc_subnet_id
}

data "aws_route_table" "requester_subnet_route_table" {
  subnet_id = var.requester_vpc_subnet_id
}

data "aws_route_table" "accepter_subnet_route_table" {
  subnet_id = var.accepter_vpc_subnet_id
}
