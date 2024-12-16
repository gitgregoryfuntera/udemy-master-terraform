terraform {
  cloud {

    organization = "terraform-greg-udemy"

    workspaces {
      name = "terraform-cli"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
