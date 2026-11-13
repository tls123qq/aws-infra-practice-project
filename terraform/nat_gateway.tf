resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "aws_infra_practice_eip"
  }
}

resource "aws_nat_gateway" "NATGW_1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name = "aws_infra_practice_natgw"
  }
}