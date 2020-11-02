# ------------------------------------------------------------------------------------------------------------------
# DEPLOY TWO SINGLE AVAILABILITY ZONE TWO TIERS VPC IN AWS WITH VPC PEERING
# This example shows how to use vpc-peering between two vpc-2tiers modules deployed in a single availability zone VPC in AWS.
# ------------------------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been developed with 0.13 syntax, which means it is not compatible with any versions below 0.13.
# ------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13, < 0.14"
}

# ------------------------------------------------------------------------------------------------------------------
# AWS PROVIDER
# ------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

# ------------------------------------------------------------------------------------------------------------------
# REGISTER A KEY PAIR WITH AWS
# ------------------------------------------------------------------------------------------------------------------
resource "aws_key_pair" "test_key" {
  key_name   = "two-single-az-2tiers-vpc-with-vpc-peering-example-key"
  public_key = file("${path.module}/test-key.pub")
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY FIRST SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "requester_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.requester_vpc_name
  cidr_block = var.requester_vpc_cidr_block

  availability_zones = [var.requester_vpc_availability_zone]
  public_subnets     = [var.requester_vpc_public_subnet]
  private_subnets    = [var.requester_vpc_private_subnet]
}


# ------------------------------------------------------------------------------------------------------------------
# DEPLOY AN EC2 INSTANCE INTO THE REQUESTER VPC
# ------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "requester_vpc_instance_security_group" {
  name        = "${var.requester_vpc_name}-instance-security-group"
  description = "The security group for ${var.requester_vpc_name} requester vpc instance."

  vpc_id = module.requester_vpc.vpc_id

  # allow all outbound calls from the instance
  egress {
    description = "allow all outbound communications from the instance to the internet."

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh into the instance."

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.requester_vpc_name}-requester-vpc-instance-security-group"
    },
    var.tags
  )
}

resource "aws_instance" "requester_vpc_instance" {
  ami               = var.requester_vpc_instance_ami
  availability_zone = var.requester_vpc_availability_zone
  subnet_id         = module.requester_vpc.public_subnets_ids[0]
  instance_type     = var.requester_vpc_instance_type

  vpc_security_group_ids = [aws_security_group.requester_vpc_instance_security_group.id]
  key_name               = aws_key_pair.test_key.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = "${var.requester_vpc_name}-public-instance"
    },
    var.tags
  )

  volume_tags = merge(
    {
      Name = "${var.requester_vpc_name}-public-instance-volume"
    },
    var.tags
  )
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY AN EC2 INSTANCE INTO THE ACCEPTER VPC
# ------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "accepter_vpc_instance_security_group" {
  name        = "${var.accepter_vpc_name}-instance-security-group"
  description = "The security group for ${var.accepter_vpc_name} accepter vpc instance."

  vpc_id = module.accepter_vpc.vpc_id

  # allow all outbound calls from the instance
  egress {
    description = "allow all outbound communications from the instance to the internet."

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh into the instance."

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.accepter_vpc_name}-accepter-vpc-instance-security-group"
    },
    var.tags
  )
}

resource "aws_instance" "accepter_vpc_instance" {
  ami               = var.accepter_vpc_instance_ami
  availability_zone = var.accepter_vpc_availability_zone
  subnet_id         = module.accepter_vpc.public_subnets_ids[0]
  instance_type     = var.accepter_vpc_instance_type

  vpc_security_group_ids = [aws_security_group.accepter_vpc_instance_security_group.id]
  key_name               = aws_key_pair.test_key.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = "${var.accepter_vpc_name}-public-instance"
    },
    var.tags
  )

  volume_tags = merge(
    {
      Name = "${var.accepter_vpc_name}-public-instance-volume"
    },
    var.tags
  )
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY SECOND SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "accepter_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.accepter_vpc_name
  cidr_block = var.accepter_vpc_cidr_block

  availability_zones = [var.accepter_vpc_availability_zone]
  public_subnets     = [var.accepter_vpc_public_subnet]
  private_subnets    = [var.accepter_vpc_private_subnet]
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY VPC PEERING
# ------------------------------------------------------------------------------------------------------------------

module "vpc_peering" {
  source = "../../modules/vpc-peering"

  requester_vpc_id = module.requester_vpc.vpc_id
  accepter_vpc_id  = module.accepter_vpc.vpc_id
}
