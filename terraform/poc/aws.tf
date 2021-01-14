# terraform {
#     backend "s3" {
#         bucket = "bitwala"
#         key    = "infra/state.tfstate"
#     }
# }

provider "aws" {
    region = "${var.region}"
}