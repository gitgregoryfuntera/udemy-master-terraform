removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = false
  }
}

# resource "aws_s3_bucket" "my_new_bucket" {
#   bucket = "random-name-123112333cc"
# }
