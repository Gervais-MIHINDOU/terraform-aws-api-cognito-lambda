resource "aws_lambda_function" "lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.function_name
  role          = data.aws_iam_role.iam_lambda.arn
  handler       = "${var.function_name}.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = var.environments
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = "../backend_user/${var.function_name}"
  output_path = "tmpM/${var.function_name}.zip"
}

data "aws_iam_role" "iam_lambda" {
  name = "moneyshome_lambda_role"
}