resource "aws_api_gateway_rest_api" "hello_world_api" {
  name = "${var.service}-${var.environment}-hello_world"
  description = "${var.service} apigateway for hello world in ${var.environment}"

    endpoint_configuration {
    types = ["REGIONAL"]
  }
    tags = {
    Name = "${var.service}-${var.environment}-hello_world"
    environment = var.environment
    service = var.service
    created-by = "amar.khan"
  }
}

resource "aws_api_gateway_method" "hello_world_method" {
  rest_api_id   = aws_api_gateway_rest_api.hello_world_api.id
  resource_id   = aws_api_gateway_rest_api.hello_world_api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello_world" {
  rest_api_id             = aws_api_gateway_rest_api.hello_world_api.id
  resource_id             = aws_api_gateway_rest_api.hello_world_api.root_resource_id
  http_method             = aws_api_gateway_method.hello_world_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.hello_world.arn}/invocations"
#   uri                     = aws_lambda_function.hello_world.invoke_arn
}

resource "aws_api_gateway_deployment" "hello_world" {
  depends_on = [aws_api_gateway_integration.hello_world]

  rest_api_id = aws_api_gateway_rest_api.hello_world_api.id
  stage_name  = var.environment
  stage_description = "for ${var.environment} env"
  description = var.environment
}

resource "aws_lambda_permission" "hello_world" {
  statement_id  = "AllowAPIGatewayInvoke"   
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.hello_world_api.execution_arn}/*/*/*"
}

output "hello_world_invoke_url" {
  value       = aws_api_gateway_deployment.hello_world.invoke_url
  description = "The URL to invoke the API pointing to the stage poc"
}
