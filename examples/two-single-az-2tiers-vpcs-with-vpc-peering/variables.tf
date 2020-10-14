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

variable "name" {
  description = "The name for the VPC."
  type        = string
  default     = "sansa-stark"
}

variable "cidr_block_1" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "11.11.11.0/24"
}

variable "cidr_block_2" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "12.12.12.0/24"
}

variable "availability_zone_1" {
  description = "The availability zone to launch both public and private subnets in."
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "The availability zone to launch both public and private subnets in."
  type        = string
  default     = "us-east-1a"
}

variable "public_subnet_1" {
  description = "The public subnet CIDR blocks to be created in the VPC."
  type        = string
  default     = "11.11.11.0/28"
}

variable "public_subnet_2" {
  description = "The public subnet CIDR blocks to be created in the VPC."
  type        = string
  default     = "12.12.12.0/28"
}

variable "private_subnet_1" {
  description = "The private subnet CIDR blocks to be created in the VPC."
  type        = string
  default     = "11.11.11.32/28"
}

variable "private_subnet_2" {
  description = "The private subnet CIDR blocks to be created in the VPC."
  type        = string
  default     = "12.12.12.32/28"
}
