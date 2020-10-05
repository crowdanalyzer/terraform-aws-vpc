# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "domain_name" {
  description = "The domain name of the hosted zone."
  type        = string
}

variable "vpcs" {
  description = "A list of VPCs to associate the route53 zone to."
  type = list(object({
    id     = string
    region = string
  }))
}

# ------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to assign to the hosted zone created by this module."
  type        = map(string)
  default     = {}
}
