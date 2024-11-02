resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "variables-bucket-${random_id.bucket_suffix.hex}"
  tags   = merge(var.additional_tags, local.custom_tags)
}
