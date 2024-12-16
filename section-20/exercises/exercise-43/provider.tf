terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  cloud {

    organization = "terraform-greg-udemy"

    workspaces {
      name = "terraform-cli-v2"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
