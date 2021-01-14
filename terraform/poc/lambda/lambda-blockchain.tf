data "archive_file" "blockchain_binary" {
    type          = "zip"
    source_file   = "lambda_blockchain.js"
    output_path   = "blockchain_function.zip"
}

resource "aws_lambda_function" "blockchain" {
  filename         = "blockchain_function.zip"

  function_name = "${var.service}-${var.environment}-blockchain-serverless"
  description   = "${var.service} lambda function for block chain query latest block in ${var.environment}"

  role    = data.aws_iam_role.local_lambda_role.arn

  handler          = "lambda_blockchain.handler"
  source_code_hash = "${data.archive_file.blockchain_binary.output_base64sha256}"
  runtime          = "nodejs12.x"
    memory_size = 128
  timeout = 15

  environment {
    variables = {
      key_one = "value_one"
    }
  }

  tags = {
    Name = "${var.service}-${var.environment}-blockchain-world"
    environment = var.environment
    service = var.service
    created-by = "amar"
  }
}

# lambda destination to sns

resource "aws_lambda_function_event_invoke_config" "blockchain" {
  function_name = "${var.service}-${var.environment}-blockchain-serverless"
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
  destination_config {
    on_failure {
      destination = aws_sns_topic.user_notifications.arn
    }

    on_success {
      destination = aws_sns_topic.user_notifications.arn
    }
  }
}
