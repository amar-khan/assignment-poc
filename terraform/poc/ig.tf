resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
    Name = "${var.service}-${var.environment}-igw"
    service = var.service
    environment = var.environment
    created-by = "amar"
  }
}
