# resource "aws_cloudwatch_log_group" "cloud_flask_group" {
#   name              = "cloud_flask_group"
#   retention_in_days = 1
# }

# data "alb_target_group" "infra" {
#     backend = "local"
#     config = {
#         path = "${path.module}/../terraform.tfstate"
#     }
# }


data "aws_lb_target_group" "nginx_tg" {
  name = "nginx-target-group"
}



resource "aws_ecs_task_definition" "ecs_flask_td" {
  family = "flask-task"
  network_mode = "host"
  container_definitions = <<EOF
[
  {
    "name": "flask",
    "image": "279865790913.dkr.ecr.us-east-2.amazonaws.com/flask:v1.0",
    "cpu": 0,
    "memory": 256,
    "networkMode": "host",
    "portMappings": [
        {
          "hostPort": 5000,
          "containerPort": 5000,
          "protocol": "tcp"
        }
      ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group": "flask-group",
        "awslogs-stream-prefix": "ecs-flask"
      }
    }
  },
   {
    "name": "nginx",
    "image": "279865790913.dkr.ecr.us-east-2.amazonaws.com/nginx:v1.0",
    "cpu": 0,
    "memory": 256,
    "networkMode": "host",
    "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80,
          "protocol": "tcp"
        }   
      ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group": "nginx-group",
        "awslogs-stream-prefix": "ecs-nginx"
      }
    }
  }
]
EOF
}


resource "aws_ecs_service" "flask-service" {
  name            = "flask-service"
  cluster         = "${var.service}-${var.environment}-cluster"
  task_definition = aws_ecs_task_definition.ecs_flask_td.arn

  desired_count = 2

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  load_balancer {
    target_group_arn = "${data.aws_lb_target_group.nginx_tg.arn}"
    container_name   = "nginx"
    container_port   = 80
    }

  #  service_registries {
  #    registry_arn = "arn:aws:servicediscovery:us-east-2:279865790913:namespace/ns-lprst75ocmf2zbmo"
  #  }
    
}
