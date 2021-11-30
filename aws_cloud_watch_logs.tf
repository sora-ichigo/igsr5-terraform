resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/igsr5"
  retention_in_days = 180
}
