# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------------------------------------------

variable "vpc_name" {
  description = "The name for the VPC."
  type        = string
  default     = "john-snow"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "12.12.12.0/24"
}

variable "availability_zone" {
  description = "The availability zones to launch both public and private subnets in."
  type        = string
  default     = "us-east-1a"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block of the public subnet to be created in the VPC."
  type        = string
  default     = "12.12.12.0/28"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR blocks of the private subnet to be created in the VPC."
  type        = string
  default     = "12.12.12.16/28"
}

variable "ssh_port" {
  description = "The port used for SSH connections."
  type        = number
  default     = 22
}

variable "ami" {
  description = "The AMI to use."
  type        = string
  # Amazon Linux 2 AMI (HVM), SSD Volume Type, 64-bit x86, ebs, hvm
  default = "ami-02354e95b39ca8dec"
}

variable "instance_type" {
  description = "The type of instance to use."
  type        = string
  default     = "t2.small"
}

variable "tags" {
  description = "A map of tags to assign to the resources created by this module."
  type        = map(string)
  default     = {}
}
