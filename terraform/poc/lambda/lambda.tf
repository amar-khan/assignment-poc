resource "aws_lambda_function" "hello_world" {
  function_name = "${var.service}-${var.environment}-hello-serverless"
  description   = "${var.service} lambda function for serverless hello world in ${var.environment}"

  role    = data.aws_iam_role.local_lambda_role.arn
  handler = "lambda_function.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime = "python3.6"
  filename         = "lambda_function.zip"
  memory_size = 128
  timeout = 15

  environment {
    variables = {
      key_one = "value_one"
    }
  }
    vpc_config {
    subnet_ids            = ["${data.aws_subnet.local_subnet_one.id}","${data.aws_subnet.local_subnet_two.id}"]
    security_group_ids    = ["${data.aws_security_group.local_sg.id}"]
  }
  tags = {
    Name = "${var.service}-${var.environment}-hello-world"
    environment = var.environment
    service = var.service
    created-by = "amar"
  }
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "lambda_function.py"
    output_path   = "lambda_function.zip"
}

data "aws_iam_role" "local_lambda_role" {
  name = "${var.service}-${var.environment}-lambda"
}

data "aws_security_group" "local_sg" {
  name = "${var.service}-${var.environment}-app-allow-sg"
}

# data "aws_subnet_ids" "local_subnet_ids" {
#   vpc_id = data.aws_vpc.local_vpc.id
  
# }

data "aws_subnet" "local_subnet_one" {
  filter {
    name   = "tag:Name"
    values = ["${var.service}-${var.environment}-pub-subnet-1"] # insert value here
  }
}

data "aws_subnet" "local_subnet_two" {
  filter {
    name   = "tag:Name"
    values = ["${var.service}-${var.environment}-pub-subnet-2"] # insert value here
  }
}

data "aws_vpc" "local_vpc" {
  cidr_block = "10.0.0.0/24"
}

# output "subnet_cidr_blocks" {
#   value = [ aws_subnet_ids.local_subnet_ids : s.cidr_block]
# }