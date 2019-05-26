resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.logicdesk_network.id}"

  tags = {
    Name = "igw"
  }
}
