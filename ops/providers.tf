terraform {
  cloud {
    organization = "Dmytro-Education"

    workspaces {
      name = "enterprise"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}
