resource "aws_vpc" "myvpc" {
  cidr_block       = var.aws_vpc_cidr

  tags = {
    Name = "myvpc"
  }
}