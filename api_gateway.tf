data "aws_api_gateway_rest_api" "moneyshome" {
  count = var.is_api ? 1 : 0
  name = "MONEY'S HOME"
}

resource "aws_api_gateway_resource" "path_resource" {
  count = var.is_api ? 1 : 0
  path_part   = var.path_part
  parent_id   = data.aws_api_gateway_rest_api.moneyshome.root_resource_id
  rest_api_id = data.aws_api_gateway_rest_api.moneyshome.id
}


resource "aws_api_gateway_method" "method_http" {
  count = var.is_api ? 1 : 0
  rest_api_id   = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id   = aws_api_gateway_resource.path_resource.id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_request" {
  count = var.is_api ? 1 : 0
  rest_api_id             = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id             = aws_api_gateway_resource.path_resource.id
  http_method             = aws_api_gateway_method.method_http.http_method
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda.invoke_arn
  type                    = "AWS"
  
}

resource "aws_api_gateway_method_response" "response_200" {
  count = var.is_api ? 1 : 0
  rest_api_id =  data.aws_api_gateway_rest_api.moneyshome.id
  resource_id =  aws_api_gateway_resource.path_resource.id
  http_method =  aws_api_gateway_method.method_http.http_method
  status_code = "200"
}


resource "aws_api_gateway_integration_response" "integration_response" {
  count = var.is_api ? 1 : 0
  rest_api_id = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id = aws_api_gateway_resource.path_resource.id
  http_method = aws_api_gateway_method.method_http.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  depends_on = [
    aws_api_gateway_integration.integration_request
  ]
}

resource "aws_lambda_permission" "permition_api" {
  count = var.is_api ? 1 : 0
  statement_id  = uuid()
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${data.aws_api_gateway_rest_api.moneyshome.execution_arn}/*/${aws_api_gateway_method.method_http.http_method}${aws_api_gateway_resource.path_resource.path}"
}


resource "aws_api_gateway_deployment" "stage" {
  count = var.is_api ? 1 : 0
  depends_on = [
    aws_api_gateway_integration.integration_request
  ]
  rest_api_id = "${data.aws_api_gateway_rest_api.moneyshome.id}"
  stage_name  = var.stage_name
}

