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
    Name = "igsr5_private_0"
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

/*
 * nat gateway
 * */
resource "aws_eip" "igsr5_0" {
  vpc        = true
  depends_on = [aws_internet_gateway.igsr5]
}

resource "aws_nat_gateway" "igsr5_0" {
  allocation_id = aws_eip.igsr5_0.id
  subnet_id     = aws_subnet.igsr5_public_0.id
  depends_on    = [aws_internet_gateway.igsr5]
}

resource "aws_eip" "igsr5_1" {
  vpc        = true
  depends_on = [aws_internet_gateway.igsr5]
}

resource "aws_nat_gateway" "igsr5_1" {
  allocation_id = aws_eip.igsr5_1.id
  subnet_id     = aws_subnet.igsr5_public_1.id
  depends_on    = [aws_internet_gateway.igsr5]
}

resource "aws_route" "igsr5_private_0" {
  route_table_id         = aws_route_table.igsr5_private_0.id
  nat_gateway_id         = aws_nat_gateway.igsr5_0.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "igsr5_private_1" {
  route_table_id         = aws_route_table.igsr5_private_1.id
  nat_gateway_id         = aws_nat_gateway.igsr5_1.id
  destination_cidr_block = "0.0.0.0/0"
}
