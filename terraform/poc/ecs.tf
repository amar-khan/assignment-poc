resource "aws_ecs_cluster" "ecs_cluster" {
    name  = "${var.service}-${var.environment}-cluster"
}