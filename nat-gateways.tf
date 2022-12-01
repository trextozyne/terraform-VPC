
resource "aws_nat_gateway" "gw-1" {
  # The Allocation ID of Elastic IP address for the gateway
  allocation_id = aws_eip.nat-1.id

  # The subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "Nat 1"
  }
}

resource "aws_nat_gateway" "gw-2" {
  # The Allocation ID of Elastic IP address for the gateway
  allocation_id = aws_eip.nat-2.id

  # The subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_2.id

  tags = {
    Name = "Nat 2"
  }
}