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

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "11.11.11.0/24"
}

variable "availability_zones" {
  description = "A list of availability zones to launch both public and private subnets in."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "A list of public subnets CIDR blocks to be created in the VPC."
  type        = list(string)
  default     = ["11.11.11.0/28", "11.11.11.16/28"]
}

variable "private_subnets" {
  description = "A list of private subnets CIDR blocks to be created in the VPC."
  type        = list(string)
  default     = ["11.11.11.32/28", "11.11.11.64/28"]
}
