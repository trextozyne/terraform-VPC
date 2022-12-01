
resource "aws_route_table_association" "public-1" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_1.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-2" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.public_2.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-1" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_1.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.private-1.id
}

resource "aws_route_table_association" "private-2" {
  # The subnet ID to create an association
  subnet_id = aws_subnet.private_2.id

  # The ID of the routing table to associate with.
  route_table_id = aws_route_table.private-2.id
}