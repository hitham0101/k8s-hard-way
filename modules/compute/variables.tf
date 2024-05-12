variable "aws" {
  type = object({
    instance_type = string
    publicip      = bool

  })

  default = {
    instance_type = "t2.micro"
    publicip      = true
  }
}

variable "subnet_id" {
  description = "value of the subnet id"
  type        = string
}

variable "sg_id" {
  description = "value of the security group id"
  type        = string
}

variable "key_name" {
  description = "value of the key name"
  type        = string
}
variable "workers_count" {
  description = "value of the number of worker nodes"
  type        = number
  default     = 2
}
variable "key_priv" {
  description = "value of the private key"
  type        = string
}
variable "key_pub" {
  description = "value of the public key"
  type        = string
}