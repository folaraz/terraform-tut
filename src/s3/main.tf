resource "aws_s3_bucket" "lambda_s3" {
  bucket = var.s3_bucket_for_lambda_code
}

resource "aws_s3_bucket_acl" "lambda_s3_acl" {
  bucket = aws_s3_bucket.lambda_s3.id
  acl    = "private"
}