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


