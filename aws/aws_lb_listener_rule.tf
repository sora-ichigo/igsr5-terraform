resource "aws_lb_listener_rule" "igsr5_sandbox_muson" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.igsr5_sandbox_muson.id
  }

  condition {
    host_header {
      values = ["sandbox_muson.igsr5.com"]
    }
  }
}

resource "aws_lb_listener_rule" "igsr5_time_management_slack" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.igsr5_time_management_slack.id
  }

  condition {
    host_header {
      values = ["time_management.igsr5.com"]
    }
  }
}
