resource "aws_route_table" "route" {
  vpc_id = aws_vpc.myvpc.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}


resource "aws_route_table_association" "first_subnet" {
  subnet_id      = aws_subnet.first_subnet.id
  route_table_id = aws_route_table.route.id
}


resource "aws_route_table_association" "second_subnet" {
  subnet_id      = aws_subnet.second_subnet.id
  route_table_id = aws_route_table.route.id
}