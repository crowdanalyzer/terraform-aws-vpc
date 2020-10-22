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

variable "requester_vpc_name" {
  description = "The name for the requester VPC."
  type        = string
  default     = "sansa-stark"
}

variable "accepter_vpc_name" {
  description = "The name for the accepter VPC."
  type        = string
  default     = "jon-snow"
}

variable "requester_vpc_cidr_block" {
  description = "The CIDR block for the requester VPC."
  type        = string
  default     = "11.11.11.0/24"
}

variable "accepter_vpc_cidr_block" {
  description = "The CIDR block for the accepter VPC."
  type        = string
  default     = "12.12.12.0/24"
}

variable "requester_vpc_availability_zone" {
  description = "The availability zone for the requester VPC."
  type        = string
  default     = "us-east-1a"
}

variable "accepter_vpc_availability_zone" {
  description = "The availability zone for the accepter VPC."
  type        = string
  default     = "us-east-1a"
}

variable "requester_vpc_public_subnet" {
  description = "The public subnet CIDR block to be created in the requester VPC."
  type        = string
  default     = "11.11.11.0/28"
}

variable "accepter_vpc_public_subnet" {
  description = "The public subnet CIDR block to be created in the accepter VPC."
  type        = string
  default     = "12.12.12.0/28"
}

variable "requester_vpc_private_subnet" {
  description = "The private subnet CIDR block to be created in the requester VPC."
  type        = string
  default     = "11.11.11.32/28"
}

variable "accepter_vpc_private_subnet" {
  description = "The private subnet CIDR block to be created in the accepter VPC."
  type        = string
  default     = "12.12.12.32/28"
}
