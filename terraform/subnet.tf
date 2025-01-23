resource "aws_subnet" "first_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.first_subnet_cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "first_subnet"
  }
}

resource "aws_subnet" "second_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.second_subnet_cidr
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "second_subnet"
  }
}