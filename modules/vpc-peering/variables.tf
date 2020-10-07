# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "requester_vpc_id" {
  description = "The ID of the VPC that request Peering Connection"
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Cnnection" 
  type        = string
}

variable "requester_vpc_cidr_block" {
  description = "The CIDR block for the requester VPC."
  type        = string
}

variable "accepter_vpc_cidr_block" {
  description = "The CIDR block for the accepter VPC." 
  type        = string
}

variable "requester_vpc_route_table_id" {
  description = "The IDs of the requester VPC route tables."
  type        = string
}

variable "accepter_vpc_route_table_id" {
  description = "The IDs of the accepter VPC route tables." 
  type        = string
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
