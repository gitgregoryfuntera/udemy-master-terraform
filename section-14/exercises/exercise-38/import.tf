resource "aws_s3_bucket" "remote_state" {
  bucket = "udemy-terraform-remote-s3"
  tags = {
    ManagedBy = "Terraforms"
    Lifecycle = "Critical"
  }
  lifecycle {
    prevent_destroy = false
  }
}


import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
