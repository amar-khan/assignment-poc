# terraform {
#     backend "s3" {
#         bucket = "bitwala"
#         key    = "lambda/state.tfstate"
#     }
# }

provider "aws" {
    region = "${var.region}"
}