#====================================================================================
# Init providers/modules for Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = "us-east-1"
}
