# ------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE AVAILABILITY ZONE TWO TIERS VPC WITH A BASTION HOST AND A ROUTE53 ZONE
# This example shows how to use vpc-2tiers module, bastion-host module, and route53 zone module
# to deploy a single availability zone VPC in AWS
# restricting ssh connections to the private subnet instances from the bastion host
# and associating a domain from a private route53 zone.
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
  region = var.region
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY SINGLE AVAILABILITY ZONE VPC
# ------------------------------------------------------------------------------------------------------------------

module "single_az_2tiers_vpc" {
  source = "../../modules/vpc-2tiers"

  name       = var.vpc_name
  cidr_block = var.vpc_cidr_block

  availability_zones = [var.availability_zone]
  public_subnets     = [var.public_subnet_cidr_block]
  private_subnets    = [var.private_subnet_cidr_block]

  tags = var.tags
}

# ------------------------------------------------------------------------------------------------------------------
# REGISTER A KEY PAIR WITH AWS
# ------------------------------------------------------------------------------------------------------------------
resource "aws_key_pair" "test_key" {
  key_name   = "single-az-2tiers-vpc-with-bastion-host-example-key"
  public_key = file("${path.module}/test-key")
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY AN EC2 INSTANCE INTO THE PRIVATE SUBNET
# ------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "private_instance_security_group" {
  name        = "${var.vpc_name}-private-instance-security-group"
  description = "The security group for ${var.vpc_name} private instance."

  vpc_id = module.single_az_2tiers_vpc.vpc_id

  # allow all outbound calls from the private instance
  egress {
    description = "allow all outbound communications from the private instance to the internet."

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow ssh connections into the private instance from anywhere
  # although we are not restricting the ssh connection here,
  # you won't be able to ssh into this instance from anywhere except the bastion host
  ingress {
    description = "allow ssh into the private instance."

    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-private-instance-security-group"
    },
    var.tags
  )
}

resource "aws_instance" "private_instance" {
  ami               = var.ami
  availability_zone = var.availability_zone
  subnet_id         = module.single_az_2tiers_vpc.private_subnets_ids[0]
  instance_type     = var.instance_type

  vpc_security_group_ids = [aws_security_group.private_instance_security_group.id]
  key_name               = aws_key_pair.test_key.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-private-instance"
    },
    var.tags
  )

  volume_tags = merge(
    {
      Name = "${var.vpc_name}-private-instance-volume"
    },
    var.tags
  )
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY BASTION HOST
# ------------------------------------------------------------------------------------------------------------------

module "bastion_host" {
  source = "../../modules/bastion-host"

  name = "${var.vpc_name}-bastion-host"

  ami = var.ami

  availability_zone = var.availability_zone
  vpc_id            = module.single_az_2tiers_vpc.vpc_id
  subnet_id         = module.single_az_2tiers_vpc.public_subnets_ids[0]

  key_name                = aws_key_pair.test_key.key_name
  allowed_ssh_cidr_blocks = ["0.0.0.0/0"]

  instance_type = var.instance_type
  ssh_port      = var.ssh_port

  tags = var.tags
}

# ------------------------------------------------------------------------------------------------------------------
# DEPLOY A ROUTE53 ZONE
# ------------------------------------------------------------------------------------------------------------------

module "route53_zone" {
  source = "../../modules/route53-zone"

  domain_name = var.route53_zone_domain_name
  vpcs = [
    {
      id     = module.single_az_2tiers_vpc.vpc_id
      region = var.region
    }
  ]
}
