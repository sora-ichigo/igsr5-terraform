resource "aws_key_pair" "igsr5_debug_server_key_pair" {
  key_name   = "igsr5_debug_server"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "igsr5_debug_server" {
  ami                    = data.aws_ssm_parameter.amzn2_ami.value
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.igsr5_debug_server_key_pair.id
  subnet_id              = aws_subnet.igsr5_public_0.id
  vpc_security_group_ids = [module.igsr5_debug_server_sg.security_group_id, module.igsr5_debug_server_sg_80.security_group_id]
  tags = {
    Name = "igsr5-debug"
  }
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
