resource "aws_nat_gateway" "nat" {
  subnet_id = var.public_subnet
  allocation_id = aws_eip.lb.id
  tags = {
    Name = "gw NAT"
  }
}
resource "aws_eip" "lb" {
  domain   = "vpc"
}