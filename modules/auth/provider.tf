terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.63.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0"
    }
  }
  required_version = ">=1.4.5"
}  