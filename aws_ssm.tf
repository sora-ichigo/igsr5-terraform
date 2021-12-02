resource "aws_ssm_parameter" "igsr5_db_username" {
  name        = "/igsr5/db/username"
  value       = "admin"
  type        = "String"
  description = "db username"
}

resource "aws_ssm_parameter" "igsr5_db_password" {
  name        = "/igsr5/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DB password"
}

resource "aws_ssm_parameter" "igsr5_db_host" {
  name        = "/igsr5/db/host"
  value       = "igsr5.c7g7mmxlp5ol.ap-northeast-1.rds.amazonaws.com:3306"
  type        = "String"
  description = "DB password"
}

resource "aws_ssm_parameter" "igsr5_db_port" {
  name        = "/igsr5/db/port"
  value       = "3306"
  type        = "String"
  description = "DB password"
}

resource "aws_ssm_parameter" "igsr5_db_name" {
  name        = "/igsr5/db/name"
  value       = "igsr5-sandbox-muson"
  type        = "String"
  description = "DB password"
}
