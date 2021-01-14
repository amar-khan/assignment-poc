resource "aws_alb" "ecs-load-balancer" {
    name                = "ecs-load-balancer"
    security_groups     = [aws_security_group.ecs_sg.id]
    subnets             = [aws_subnet.pub_subnet.id,aws_subnet.pub_subnet_two.id]

    tags = {
      Name = "${var.service}-${var.environment}-alb"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}

resource "aws_alb_target_group" "nginx-target-group" {
    name                = "nginx-target-group"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              =  aws_vpc.vpc.id
    deregistration_delay = "20" 
    health_check {
        healthy_threshold   = "2"
        unhealthy_threshold = "5"
        interval            = "10"
        matcher             = "200"
        path                = "/healthcheck"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags = {
      Name = "${var.service}-${var.environment}-nginx-tg"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}

resource "aws_alb_target_group" "flask-target-group" {
    name                = "flask-target-group"
    port                = "5000"
    protocol            = "HTTP"
    vpc_id              =  aws_vpc.vpc.id
    deregistration_delay = "20"
    health_check {
        healthy_threshold   = "2"
        unhealthy_threshold = "5"
        interval            = "10"
        matcher             = "200"
        path                = "/actuator/health"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags = {
      Name = "${var.service}-${var.environment}-flask-tg"
      service = var.service
      environment = var.environment
      created-by = "amar"
    }
}

resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.nginx-target-group.arn}"
        type             = "redirect"

         redirect {
                host        = "#{host}"
                path        = "/#{path}"
                port        = "443"
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
            }
    }
}


resource "aws_alb_listener" "https-listner" {
  load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.nginx-target-group]
  certificate_arn   = aws_acm_certificate.cert.arn
   
  default_action {
    target_group_arn = "${aws_alb_target_group.nginx-target-group.arn}"
    type             = "forward"

   

  }
}



resource "aws_alb_listener" "flask-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "5000"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.flask-target-group.arn}"
        type             = "forward"
    }
}