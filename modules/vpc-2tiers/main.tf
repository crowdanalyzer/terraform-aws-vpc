# ------------------------------------------------------------------------------------------------------------------
# CREATE A VPC
# ------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink

  tags = merge(
    {
      Name = var.name
      CIDR = var.cidr_block
    },
    var.tags
  )
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE AN INTERNET GATEWAY
# ------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = "${var.name}-internet-gateway"
      VPC  = var.name
    },
    var.tags
  )
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE PUBLIC SUBNETS
# ------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public_subnets" {
  for_each = toset(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[index(var.public_subnets, each.value)]
  cidr_block        = each.value

  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.name}-${var.availability_zones[index(var.public_subnets, each.value)]}-public-subnet"
      VPC  = var.name
      AZ   = var.availability_zones[index(var.public_subnets, each.value)]
      CIDR = each.value
    },
    var.tags
  )
}

resource "aws_route_table" "public_subnets_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = "${var.name}-public-subnets-route-table"
      VPC  = var.name
    },
    var.tags
  )
}

resource "aws_route_table_association" "public_subnets_route_table_association" {
  for_each = toset(var.public_subnets)

  subnet_id      = aws_subnet.public_subnets[each.value].id
  route_table_id = aws_route_table.public_subnets_route_table.id
}

# create a route that routes traffic from / to all ip addresses ranges through internet gateway
# this what makes a subnet a public one
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.public_subnets_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE NAT GATEWAYS THAT PRIVATE SUBNETS WILL USE TO CONNECT TO INTERNET
# ------------------------------------------------------------------------------------------------------------------

resource "aws_eip" "eips" {
  for_each = toset(var.public_subnets)

  vpc = true

  tags = merge(
    {
      Name   = "${var.name}-${each.value}-public-subnet-nat-gateway-eip"
      VPC    = var.name
      Subnet = each.value
    },
    var.tags
  )

  # EIP may require IGW to exist prior to association. Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateways" {
  for_each = toset(var.public_subnets)

  allocation_id = aws_eip.eips[each.value].id
  subnet_id     = aws_subnet.public_subnets[each.value].id

  tags = merge(
    {
      Name   = "${var.name}-${each.value}-public-subnet-nat-gateway"
      VPC    = var.name
      Subnet = each.value
      EIP    = aws_eip.eips[each.value].public_ip
    },
    var.tags
  )

  # It is recommended to denote that the NAT Gateway depends on the Internet Gateway for the VPC in which the NAT Gateway's subnet is located.
  depends_on = [aws_internet_gateway.internet_gateway]
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE PRIVATE SUBNETS
# ------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[index(var.private_subnets, each.value)]
  cidr_block        = each.value

  tags = merge(
    {
      Name = "${var.name}-${var.availability_zones[index(var.private_subnets, each.value)]}-private-subnet"
      VPC  = var.name
      AZ   = var.availability_zones[index(var.private_subnets, each.value)]
      CIDR = each.value
    },
    var.tags
  )
}

resource "aws_route_table" "private_subnets_route_tables" {
  for_each = toset(var.private_subnets)

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name   = "${var.name}-${each.value}-private-subnet-route-table"
      VPC    = var.name
      Subnet = each.value
    },
    var.tags
  )
}

resource "aws_route_table_association" "private_subnets_route_tables_associations" {
  for_each = toset(var.private_subnets)

  subnet_id      = aws_subnet.private_subnets[each.value].id
  route_table_id = aws_route_table.private_subnets_route_tables[each.value].id
}

# create a route that routes traffic to all ip addresses ranges through nat gateway
# this what makes a private subnet able to communicate with the internet
resource "aws_route" "nat_gateways_routes" {
  for_each = toset(var.private_subnets)

  route_table_id         = aws_route_table.private_subnets_route_tables[each.value].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateways[var.public_subnets[index(var.private_subnets, each.value)]].id
}
