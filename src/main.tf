terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "thor_s3_bucket" {
  source = "../src/s3"

  s3_bucket_for_lambda_code = "thorbucket123"
}

module "thor_s3_upload" {
  source = "../src/s3-upload"

  s3_bucket_lambda_id = module.thor_s3_bucket.lambda_bucket_id
}

module "thor_lambda" {
  source = "../src/lambda"

  lambda_function_name = "thor"
  lambda_iam_role_name = "lambda_thor"
  s3_bucket_lambda_code_id = module.thor_s3_bucket.lambda_bucket_id
  s3_bucket_lambda_code_key = module.thor_s3_upload.s3_object_key
  source_code_hash = module.thor_s3_upload.source_code_hash_output
}

module "thor_api_gateway" {
  source = "../src/api-gateway"

  api_gateway_lambda_stage_name = "thor_api_gateway_stage"
  api_gateway_name              = "thor_api_gateway"
  lambda_function_invoke_arn    = module.thor_lambda.lambda_function_invoke_arn
  lambda_function_name          = module.thor_lambda.lambda_function_name
}

