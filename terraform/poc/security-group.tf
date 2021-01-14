resource "aws_security_group" "ecs_sg" {
    vpc_id      = aws_vpc.vpc.id
    name        = "${var.service}-${var.environment}-app-allow-sg"
    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 5000
        to_port         = 5000
        protocol        = "tcp"
        cidr_blocks     = ["10.0.0.0/24"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags       = {
      Name = "${var.service}-${var.environment}-app-allow-sg"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}