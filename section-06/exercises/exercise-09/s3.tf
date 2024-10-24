resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_static_website" {
  bucket = "s3-static-website-${random_id.bucket_suffix.hex}"
  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_s3_object" "static_index_html" {
  bucket       = aws_s3_bucket.s3_static_website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "static_error_html" {
  bucket       = aws_s3_bucket.s3_static_website.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "static_website_access" {
  bucket = aws_s3_bucket.s3_static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_static_website_account_public_access" {
  bucket              = aws_s3_bucket.s3_static_website.id
  block_public_acls       = false
  block_public_policy     = false
}

resource "aws_s3_bucket_policy" "s3_static_website_policy" {
  bucket = aws_s3_bucket.s3_static_website.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.s3_static_website.bucket}/*"
        }
    ]
}
EOF
}



output "bucket_name" {
  value = aws_s3_bucket.s3_static_website.bucket
}