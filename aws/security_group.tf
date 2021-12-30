module "https_sg" {
  source      = "./modules/security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "mysql_sg" {
  source      = "./modules/security_group"
  name        = "mysql-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 3306
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "nginx_sg" {
  source      = "./modules/security_group"
  name        = "nginx-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 80
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "time_management_slack_sg" {
  source      = "./modules/security_group"
  name        = "time-management-slack-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 3000
  cidr_blocks = ["0.0.0.0/0"]
}

module "vpc_endpoint_sg" {
  source      = "./modules/security_group"
  name        = "vpc-endpoint-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 443
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "igsr5_debug_server_sg" {
  source      = "./modules/security_group"
  name        = "igsr5-debug-server-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 22
  cidr_blocks = ["0.0.0.0/0"]
}

module "igsr5_debug_server_sg_80" {
  source      = "./modules/security_group"
  name        = "igsr5-debug-server-sg-80"
  vpc_id      = aws_vpc.igsr5.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "igsr5_sandbox_muson_sg" {
  source      = "./modules/security_group"
  name        = "igsr5-sandbox-muson-efs-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 2049
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}
