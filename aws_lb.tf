resource "aws_lb" "igsr5" {
  name                       = "igsr5"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = true

  subnets = [
    aws_subnet.igsr5_public_0.id,
    aws_subnet.igsr5_public_1.id,
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  security_groups = [
    module.https_sg.security_group_id,
  ]
}

module "https_sg" {
  source      = "./modules/security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.igsr5.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.igsr5.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "this is https."
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "igsr5" {
  name                 = "igsr5"
  target_type          = "ip"
  vpc_id               = aws_vpc.igsr5.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  //health_check {
  //  path                = "/"
  //  healthy_threshold   = 5
  //  unhealthy_threshold = 2
  //  timeout             = 5
  //  interval            = 300
  //  matcher             = 200
  //  port                = 80
  //  protocol            = "HTTP"
  //}
  depends_on = [aws_lb.igsr5]
}

resource "aws_lb_listener_rule" "igsr5" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.igsr5.id
  }

  condition {
    host_header {
      values = ["sandbox_muson.igsr5.com"]
    }
  }
}
