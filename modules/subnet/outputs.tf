output "subnet" {
  value = aws_subnet.myapp-subnet-1
}

output "default_route_table" {
  value = aws_default_route_table.main-rtb
}