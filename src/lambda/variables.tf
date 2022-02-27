variable "lambda_function_name" {
  description = "Aws lambda function name"
  type        = string
}

variable "runtime" {
  description = "Runtime language to run the lambda function"
  type        = string
  default     = "python3.6"
}

variable "lambda_iam_role_name" {
  description = "Lambda function iam role name"
  type        = string
}

variable "s3_bucket_lambda_code_id" {
  description = "S3 bucket that houses lambda code"
  type        = string
}

variable "s3_bucket_lambda_code_key" {
  description = "Key to S3 bucket that houses lambda code"
  type        = string
}

variable "source_code_hash" {
  description = "This is the source code hash"
  type = string
}
