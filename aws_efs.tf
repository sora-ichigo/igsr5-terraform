resource "aws_efs_file_system" "igsr5_sandbox_muson" {
  creation_token = "igsr5-sandbox-muson"
  tags = {
    Name = "igsr5-sandbox-muson"
  }
}

resource "aws_efs_mount_target" "igsr5_sandbox_muson_0" {
  file_system_id  = aws_efs_file_system.igsr5_sandbox_muson.id
  subnet_id       = aws_subnet.igsr5_private_0.id
  security_groups = [module.igsr5_sandbox_muson_sg.security_group_id]
}

resource "aws_efs_mount_target" "igsr5_sandbox_muson_1" {
  file_system_id  = aws_efs_file_system.igsr5_sandbox_muson.id
  subnet_id       = aws_subnet.igsr5_private_1.id
  security_groups = [module.igsr5_sandbox_muson_sg.security_group_id]
}

module "igsr5_sandbox_muson_sg" {
  source      = "./modules/security_group"
  name        = "igsr5-sandbox-muson-efs-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 2049
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}
