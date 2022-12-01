
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway or a virtual private gateway
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private-1" {
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway or a virtual private gateway
    nat_gateway_id = aws_nat_gateway.gw-1.id
  }

  tags = {
    Name = "private-1"
  }
}

resource "aws_route_table" "private-2" {
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway or a virtual private gateway
    nat_gateway_id = aws_nat_gateway.gw-2.id
  }

  tags = {
    Name = "private-2"
  }
}