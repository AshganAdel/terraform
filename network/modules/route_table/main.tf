resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "public-rt-as" {
  subnet_id      = var.public_subnet
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-as" {
  count = length(var.private_subnet)
  subnet_id      = var.private_subnet[count.index]
  route_table_id = aws_route_table.private-rt.id
}

