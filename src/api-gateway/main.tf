resource "aws_apigatewayv2_api" "api_gateway_lambda" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.api_gateway_lambda.name}"

  retention_in_days = 30
}

resource "aws_apigatewayv2_route" "api_gateway_lambda_route" {
  api_id = aws_apigatewayv2_api.api_gateway_lambda.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.api_gateway_lambda_integration.id}"
}
resource "aws_apigatewayv2_integration" "api_gateway_lambda_integration" {
  api_id           = aws_apigatewayv2_api.api_gateway_lambda.id
  integration_type = "AWS_PROXY"

  connection_type      = "INTERNET"
  description          = "Lambda example"
  integration_method   = "POST"
  integration_uri      = var.lambda_function_invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}


resource "aws_apigatewayv2_stage" "api_gateway_lambda_stage" {
  api_id = aws_apigatewayv2_api.api_gateway_lambda.id

  name        = var.api_gateway_lambda_stage_name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    }
    )
  }
}