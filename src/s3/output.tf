output "lambda_bucket_id" {
  description = "Name of the S3 bucket used to store function code."

  value = aws_s3_bucket.lambda_s3.id
}