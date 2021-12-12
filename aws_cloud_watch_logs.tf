resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/igsr5/sandbox/muson"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "prod_time_management_go" {
  name              = "/ecs/igsr5/prod/time_management_go"
  retention_in_days = 180
}
