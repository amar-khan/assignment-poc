resource "aws_cloudwatch_log_group" "flask-group" {
  name = "flask-group"

  tags = {
    environment = "poc"
    application = "bitwala"
  }
}

resource "aws_cloudwatch_log_group" "nginx-group" {
  name = "nginx-group"

  tags = {
    environment = "poc"
    application = "bitwala"
  }
}


