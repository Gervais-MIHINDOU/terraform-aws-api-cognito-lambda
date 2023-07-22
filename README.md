# Infra Api Module
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | git::https://gitlab.com/moneys-home/infra-lambda-module.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_integration.integration_request](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration_response.integration_response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_method.method_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response.response_200](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_resource.path_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_lambda_permission.permition_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_api_gateway_rest_api.moneyshome](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/api_gateway_rest_api) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | nom de la fonction | `string` | n/a | yes |
| <a name="input_http_method"></a> [http\_method](#input\_http\_method) | Methode utiliser | `string` | n/a | yes |
| <a name="input_path_part"></a> [path\_part](#input\_path\_part) | Nom du chemin de la ressource | `string` | n/a | yes |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | nom de lénvironnemnt | `string` | n/a | yes |
| <a name="input_variables_environement"></a> [variables\_environement](#input\_variables\_environement) | La liste des variables d environment de la lambda | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->