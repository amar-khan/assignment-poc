resource "aws_sns_topic" "user_notifications" {
  name = "${var.service}-${var.environment}-topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
tags = {
    service = var.service
    environment = var.environment
  }
}


resource "aws_sns_topic_policy" "user_notification" {
  arn = aws_sns_topic.user_notifications.arn

  policy = data.aws_iam_policy_document.user_notification_policy.json
}

data "aws_iam_policy_document" "user_notification_policy" {
  policy_id = "_default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    # condition {
    #   test     = "StringEquals"
    #   variable = "AWS:SourceOwner"

    #   values = [
    #    var.account_id,
    #    ]
    # }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.user_notifications.arn,
    ]

    sid = "_default_statement_ID"
  }
}

# email subscription 

resource "aws_sns_topic" "tf_aws_sns_topic_with_subscription" {
  name = aws_sns_topic.user_notifications.name
  provisioner "local-exec" {
    command = "sh sns_subscription.sh"
    environment = {
      sns_arn = aws_sns_topic.user_notifications.arn
      sns_emails = var.sns_subscription_email_address
    }
  }
}