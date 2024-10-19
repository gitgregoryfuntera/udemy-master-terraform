terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "ap-northeast"
}

resource "aws_s3_bucket" "ap_southeast_1" {
  bucket = "ap-southeast-one-my-bucket-01"
}

resource "aws_s3_bucket" "ap_northeast_1" {
  bucket = "ap-northeast-one-my-bucket-01"
  provider = aws.ap-northeast
}