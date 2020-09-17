variable "vpcs" { #Example value [{ "vpc_id" = "vpc-02a23b6f6cea2d5c7" }, { "vpc_id" = "vpc-0e57caaa2c040828b" }]
  type = list(object({
    vpc_id = string
  }))
  description = "List of VPCs to associate to the route53 zone"
  default     = [] #When left for default it causes te zone to be public 
}

variable "domain_name" {
  description = "Domain name of the hosted zone"
}