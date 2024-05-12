terraform {
  required_version = ">=1.4.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.63.0"
    }
  }
}

provider "aws" {
  region  = var.AWS_DEFAULT_REGION
  profile = var.AWS_PROFILE
}
