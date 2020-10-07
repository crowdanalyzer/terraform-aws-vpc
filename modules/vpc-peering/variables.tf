# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "requester_vpc_id" {
  description = "The ID of the VPC that request Peering Connection"
  type        = "string"
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Cnnection" 
  type        = "string"
}

variable "requester_vpc_subnet_id" {
  description = "The Public Subnet ID of the VPC that request Peering Connection"
  type        = "string"
}

variable "accepter_vpc_subnet_id" {
  description = "The Public Subnet ID of the VPC with which you are creating the VPC Peering Cnnection" 
  type        = "string"
}

# ------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to assign to the resources created by this module"
  type        = map(string)
  default     = {}
}
