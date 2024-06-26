variable "aws" {
  type = object({
    region              = string
    instance_type       = string
    vpc_cidr            = string
    public_subnets_cidr = string
    publicip            = bool
    keyname             = string

  })

  default = {
    region              = "eu-central-1"
    instance_type       = "t2.micro"
    vpc_cidr            = "10.0.0.0/16"
    public_subnets_cidr = "10.0.1.0/24"
    publicip            = true
    keyname             = "key"
  }
}
