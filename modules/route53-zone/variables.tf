# ------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------------------------------------------

variable "domain_name" {
  description = "Domain name of the hosted zone"
  type        = string
}

variable "vpcs" { 
  type        = list(string)
  description = "A list of VPCs to associate the route53 zone to"
}
