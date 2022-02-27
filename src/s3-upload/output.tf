output "s3_object_key" {
  description = "This is the object key in s3"
  value       = aws_s3_object.thor_lambda_code.key
}

output "source_code_hash_output" {
  description = "This is the object key in s3"
  value       = data.archive_file.lambda_function_code.output_base64sha256
}