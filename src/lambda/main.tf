resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  s3_bucket        = var.s3_bucket_lambda_code_id
  s3_key           = var.s3_bucket_lambda_code_key
  runtime          = var.runtime
  handler          = "thor.handler"
  source_code_hash = var.source_code_hash
}

resource "aws_cloudwatch_log_group" "lambda_cloud_watch" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = 30
}