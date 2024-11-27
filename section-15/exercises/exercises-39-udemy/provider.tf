terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
