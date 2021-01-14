resource "aws_subnet" "pub_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.0.0/25"
    availability_zone       = var.availability_zone
    tags       = {
      Name = "${var.service}-${var.environment}-pub-subnet-1"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}

resource "aws_subnet" "pub_subnet_two" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.0.128/25"
    availability_zone       = var.secondary_availability_zone
    tags       = {
      Name = "${var.service}-${var.environment}-pub-subnet-2"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}