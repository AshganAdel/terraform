resource "aws_subnet" "public" {
  vpc_id     = var.vpc_id
  map_public_ip_on_launch = true
  cidr_block = var.public_cidr
  tags = {
    Name = var.public_name
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_cidr)
  vpc_id     = var.vpc_id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.private_cidr[count.index]
  tags = {
    Name = var.private_name[count.index]
  }
}

