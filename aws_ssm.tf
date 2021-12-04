resource "aws_ssm_parameter" "igsr5_sandbox_db_username" {
  name        = "/igsr5/sandbox/db/username"
  value       = "admin"
  type        = "String"
  description = "db username"
}

resource "aws_ssm_parameter" "igsr5_sandbox_db_password" {
  name        = "/igsr5/sandbox/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DB password"
}

resource "aws_ssm_parameter" "igsr5_sandbox_db_host" {
  name        = "/igsr5/sandbox/db/host"
  value       = "igsr5-sandbox.c7g7mmxlp5ol.ap-northeast-1.rds.amazonaws.com"
  type        = "String"
  description = "DB password"
}

resource "aws_ssm_parameter" "igsr5_sandbox_db_port" {
  name        = "/igsr5/sandbox/db/port"
  value       = "3306"
  type        = "String"
  description = "DB password"
}
