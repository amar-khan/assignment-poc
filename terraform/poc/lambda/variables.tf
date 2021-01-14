

variable "region" {
  description = "AWS region"
}

variable "service" {
  description = "name of application"
}

variable "environment" {
  description = "environment of application"
}

variable "sns_subscription_email_address" {
  #  type = list(string)
   description = "email addresses"
 }

#   variable "sns_subscription_protocol" {
#    type = string
#    default = "email"
#    description = "SNS subscription protocal"
#  }