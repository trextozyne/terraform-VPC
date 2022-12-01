resource "aws_eip" "nat-1" {
  //EIP may require IGW to exist prior to association, use depends_on to set explicit dependency on the IGW
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat-2" {
  //EIP may require IGW to exist prior to association, use depends_on to set explicit dependency on the IGW
  depends_on = [aws_internet_gateway.main]
}