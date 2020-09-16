# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name of the bastion host instance."
  type        = string
}

variable "ami" {
  description = "The AMI to use for the bastion host instance."
  type        = string
}

variable "availability_zone" {
  description = "The availability zone to start the bastion host instance in."
  type        = string
}

variable "vpc_id" {
  description = "The VPC id to launch the bastion host instance in."
  type        = string
}

variable "subnet_id" {
  description = "The VPC subnet id to launch the bastion host instance in."
  type        = string
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the bastion host instance."
  type        = string
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the bastion host instance will allow SSH connections."
  type        = list(string)
}

# ------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------------------------------------------

variable "instance_type" {
  description = "The type of instance to use with the bastion host."
  type        = string
  default     = "t2.small"
}

variable "root_volume_size" {
  description = "The size of the root volume of the bastion host in gigabytes."
  type        = number
  default     = 10
}

variable "ssh_port" {
  description = "The port used for SSH connections on the bastion host EC2 instance."
  type        = number
  default     = 22
}

variable "tags" {
  description = "A map of tags to assign to the resources created by this module (e.g. EC2 instance, Security Group, ... etc.)."
  type        = map(string)
  default     = {}
}
