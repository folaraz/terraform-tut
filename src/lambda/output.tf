output "lambda_function_arn" {
  description = "Lambda function arn"
  value       = aws_lambda_function.lambda_function.arn
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.lambda_function.function_name
}

output "lambda_function_invoke_arn" {
  description = "Lambda function invoke arn"
  value = aws_lambda_function.lambda_function.invoke_arn
}