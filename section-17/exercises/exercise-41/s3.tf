resource "random_id" "bucket_random_id" {
  byte_length = 4
}
resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "workspace-demo-${terraform.workspace}-${count.index}-${random_id.bucket_random_id.hex}"
}
