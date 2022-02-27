data "archive_file" "lambda_function_code" {
  type = "zip"

  source_dir  = "${path.module}/thor"
  output_path = "${path.module}/thor.zip"
}

resource "aws_s3_object" "thor_lambda_code" {
  bucket = var.s3_bucket_lambda_id

  key    = "thor.zip"
  source = data.archive_file.lambda_function_code.output_path

  etag = filemd5(data.archive_file.lambda_function_code.output_path)
}
