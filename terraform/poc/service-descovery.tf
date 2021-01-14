# resource "aws_service_discovery_private_dns_namespace" "bitwala" {
#   name        = "local.bitwala.com"
#   description = "bitwala"
#   vpc         = aws_vpc.vpc.id
# }

# resource "aws_service_discovery_service" "bitwala" {
#   name = "bitwala"

#   dns_config {
#     namespace_id = aws_service_discovery_private_dns_namespace.bitwala.id

#     dns_records {
#       ttl  = 5
#       type = "A"
#     }
#   }
# }
