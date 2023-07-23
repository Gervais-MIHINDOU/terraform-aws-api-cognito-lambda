data "aws_api_gateway_rest_api" "moneyshome" {
  name = "MONEY'S HOME"
}

resource "aws_api_gateway_resource" "path_resource" {
  path_part   = var.path_part
  parent_id   = data.aws_api_gateway_rest_api.moneyshome.root_resource_id
  rest_api_id = data.aws_api_gateway_rest_api.moneyshome.id
}


resource "aws_api_gateway_method" "method_http" {
  rest_api_id   = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id   = aws_api_gateway_resource.path_resource.id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_request" {
  rest_api_id             = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id             = aws_api_gateway_resource.path_resource.id
  http_method             = aws_api_gateway_method.method_http.http_method
  integration_http_method = "POST"
  uri                     = module.lambda.lambda_invoke_arn
  type                    = "AWS"
  request_templates = {
    "application/json" = jsondecode({
      "headers" : {
        #foreach($param in $input.params().header.keySet())
        "$param" : "$util.escapeJavaScript($input.params().header.get($param))" #if($foreach.hasNext),#end
        #end
      }
    })
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id =  data.aws_api_gateway_rest_api.moneyshome.id
  resource_id =  aws_api_gateway_resource.path_resource.id
  http_method =  aws_api_gateway_method.method_http.http_method
  status_code = "200"
}


resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = data.aws_api_gateway_rest_api.moneyshome.id
  resource_id = aws_api_gateway_resource.path_resource.id
  http_method = aws_api_gateway_method.method_http.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  depends_on = [
    aws_api_gateway_integration.integration_request
  ]
}

resource "aws_lambda_permission" "permition_api" {
  statement_id  = uuid()
  action        = "lambda:InvokeFunction"
  function_name =  var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${data.aws_api_gateway_rest_api.moneyshome.execution_arn}/*/${aws_api_gateway_method.method_http.http_method}${aws_api_gateway_resource.path_resource.path}"

  depends_on = [
    module.lambda
  ]
}


module "lambda" {
  source = "git::https://gitlab.com/moneys-home/infra-lambda-module.git?ref=main"
  function_name = var.function_name
  variables_environement = var.variables_environement
  runtime = "python3.9"
}
