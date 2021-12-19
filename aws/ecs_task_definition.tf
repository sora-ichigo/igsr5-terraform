resource "aws_ecs_task_definition" "igsr5_sandbox_muson" {
  family                   = "igsr5_sandbox_muson"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./containers/sandbox_muson_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn

  volume {
    name = "igsr5-sandbox-muson"

    efs_volume_configuration {
      file_system_id = aws_efs_file_system.igsr5_sandbox_muson.id
      root_directory = "/"
    }
  }
}

resource "aws_ecs_task_definition" "igsr5_time_management_slack" {
  family                   = "igsr5_time_management_slack"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./containers/time_management_slack_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
  lifecycle {
    ignore_changes = [container_definitions]
  }
}
