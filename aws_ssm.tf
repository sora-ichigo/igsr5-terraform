resource "aws_ssm_parameter" "db_username" {
  name = "/db/username"
  value = "root"
  type = "String"
  description = "DB username"
}

resource "aws_ssm_parameter" "db_password" {
  name = "/db/password"
  value = "root"
  type = "SecureString"
  description = "DB password"
}
