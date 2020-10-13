# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "requester_vpc_id" {
  description = "The ID of the VPC requesting the peering connection."
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the VPC with which the peering connection is created."
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

variable "enable_classiclink" {
  description = "Enable / disable communication between a local linked EC2-Classic instance and instances in the peer VPCs."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources created by this module."
  type        = map(string)
  default     = {}
}
