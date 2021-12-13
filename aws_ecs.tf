resource "aws_ecs_cluster" "igsr5" {
  name = "igsr5"
}

/*
 * sandbox muson
 */
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

resource "aws_ecs_service" "igsr5_sandbox_muson" {
  name                              = "igsr5_sandbox_muson"
  cluster                           = aws_ecs_cluster.igsr5.arn
  task_definition                   = aws_ecs_task_definition.igsr5_sandbox_muson.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]
    subnets = [
      aws_subnet.igsr5_private_0.id,
      aws_subnet.igsr5_private_1.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.igsr5.arn
    container_name   = "igsr5_sandbox_muson"
    container_port   = 80
  }
}

module "nginx_sg" {
  source      = "./modules/security_group"
  name        = "nginx-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 80
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

/*
 * time management slack
 */
resource "aws_ecs_service" "igsr5_time_management_slack" {
  name                              = "igsr5_time_management_slack"
  cluster                           = aws_ecs_cluster.igsr5.arn
  task_definition                   = aws_ecs_task_definition.igsr5_time_management_slack.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = false
    security_groups  = []
    subnets = [
      aws_subnet.igsr5_private_0.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.igsr5.arn
    container_name   = "igsr5_time_management_go"
    container_port   = 8000
  }
}

resource "aws_ecs_task_definition" "igsr5_time_management_slack" {
  family                   = "igsr5_time_management_slack"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./containers/time_management_slack_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}


