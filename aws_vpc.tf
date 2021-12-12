/*
 * vpc
 * */
resource "aws_vpc" "igsr5" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "igsr5"
  }
}
/*
 * public subnet
 * */
resource "aws_subnet" "igsr5_public_0" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "igsr5_public_0"
  }
}

resource "aws_subnet" "igsr5_public_1" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "igsr5_public_1"
  }
}

resource "aws_internet_gateway" "igsr5" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5"
  }
}

resource "aws_route_table" "igsr5_public" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5_public"
  }
}

resource "aws_route" "igsr5_public" {
  route_table_id         = aws_route_table.igsr5_public.id
  gateway_id             = aws_internet_gateway.igsr5.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "igsr5_public_0" {
  subnet_id      = aws_subnet.igsr5_public_0.id
  route_table_id = aws_route_table.igsr5_public.id
}

resource "aws_route_table_association" "igsr5_public_1" {
  subnet_id      = aws_subnet.igsr5_public_1.id
  route_table_id = aws_route_table.igsr5_public.id
}
/*
 * private subnet
 * */
resource "aws_subnet" "igsr5_private_0" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.65.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "igsr5_private_0"
  }
}

resource "aws_subnet" "igsr5_private_1" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.66.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "igsr5_private_1"
  }
}

resource "aws_route_table" "igsr5_private_0" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5_private_0"
  }
}

resource "aws_route_table" "igsr5_private_1" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5_private_1"
  }
}

resource "aws_route_table_association" "private_0" {
  subnet_id      = aws_subnet.igsr5_private_0.id
  route_table_id = aws_route_table.igsr5_private_0.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.igsr5_private_1.id
  route_table_id = aws_route_table.igsr5_private_1.id
}

module "vpc_endpoint_sg" {
  source = "./modules/security_group"
  name = "vpc-endpoint-sg"
  vpc_id = aws_vpc.igsr5.id
  port = 443
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_0" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.igsr5_private_0.id
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_1" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.igsr5_private_1.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.igsr5.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.igsr5.id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
  security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.igsr5.id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
  security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.igsr5.id
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
  security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.igsr5.id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
  security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
  private_dns_enabled = true
}
