# terraform {
#     backend "s3" {
#         bucket = "bitwala"
#         key    = "app/state.tfstate"
#     }
# }

provider "aws" {
    region = "${var.region}"
}