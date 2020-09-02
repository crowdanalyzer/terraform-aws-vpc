# ------------------------------------------------------------------------------------------------------------------
# CREATE BASTION HOST SECURITY GROUP & ITS ROLES
# ------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "security_group" {
  name        = "${var.name}-security-group"
  description = "The security group for ${var.name} bastion host instance."

  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.name}-security-group"
    },
    var.tags
  )
}

# Allow all outbound communication from bastion host
resource "aws_security_group_rule" "allow_all_outbound_security_group_rule" {
  description = "allow all outbound communications from the bastion host instance to the internet"

  # allow all outbound calls from any port with any protocol to any ip address
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.security_group.id
}

# Allow ssh into the bastion host instance from specific IP ranges
resource "aws_security_group_rule" "allow_ssh_inbound_security_group_rule" {
  description = "allow ssh into the bastion host from (${join(",", var.allowed_ssh_cidr_blocks)})"

  # allow ssh into the bastion host instance from specific CIDR blocks
  type        = "ingress"
  from_port   = var.ssh_port
  to_port     = var.ssh_port
  protocol    = "tcp"
  cidr_blocks = var.allowed_ssh_cidr_blocks

  security_group_id = aws_security_group.security_group.id
}

# ------------------------------------------------------------------------------------------------------------------
# CREATE BASTION HOST EC2 Instance
# ------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "instance" {
  ami               = var.ami
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  instance_type     = var.instance_type

  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )

  volume_tags = merge(
    {
      Name = "${var.name}-volume"
    },
    var.tags
  )
}
