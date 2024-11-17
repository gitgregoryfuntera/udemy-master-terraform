terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_availability_zones" "azs_available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = "public-modules"
  cidr = "10.0.0.0/16"

  azs = data.aws_availability_zones.azs_available.names

  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]

}


