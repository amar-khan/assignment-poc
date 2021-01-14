resource "aws_launch_configuration" "ecs_launch_config" {
    image_id             = data.aws_ami.amazon_linux_ecs.id
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.ecs_sg.id]
    # user_data              = data.template_file.user_data.rendered
    # key_name = var.keypair
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.service}-${var.environment}-cluster >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config"
    instance_type        = "t2.micro"
    associate_public_ip_address = true
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    name                      = "asg"
    vpc_zone_identifier       = [aws_subnet.pub_subnet.id,aws_subnet.pub_subnet_two.id]
    launch_configuration      = aws_launch_configuration.ecs_launch_config.name

    desired_capacity          = 2
    min_size                  = 1
    max_size                  = 10
    health_check_grace_period = 300
    health_check_type         = "EC2"
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user-data.sh")

  vars = {
    cluster_name = "${var.service}-${var.environment}-cluster"
  }
}

data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

locals {
  name        = "ecs"
  environment = "dev"

  # This is the convention we use to know what belongs to each other
  ec2_resources_name = "${var.service}-${var.environment}-cluster"
}