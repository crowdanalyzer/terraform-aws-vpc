# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name for the VPC."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones to launch both public and private subnets in."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets CIDR blocks to be created in the VPC."
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets CIDR blocks to be created in the VPC."
  type        = list(string)
}

# ------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------------------------------------------

# ClassicLink allows you to link EC2-Classic instances to a VPC in your account, within the same Region.
# If you associate the VPC security groups with a EC2-Classic instance, this enables communication between your EC2-Classic instance and instances in your VPC using private IPv4 addresses.
# ClassicLink removes the need to make use of public IPv4 addresses or Elastic IP addresses to enable communication between instances in these platforms.
variable "enable_classiclink" {
  description = "Enable / disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources created by this module (e.g. VPC, IGW, NGW, Subnets ... etc.)."
  type        = map(string)
  default     = {}
}
