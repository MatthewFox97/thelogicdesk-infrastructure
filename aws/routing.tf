resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.logicdesk_network.id}"

  tags {
    Name = "Private route table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.logicdesk_network.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

# Associate loadbalancer subnet with public route table
resource "aws_route_table_association" "loadbalancer1_association" {
  subnet_id      = "${aws_subnet.loadbalancer_1.id}"
  route_table_id = "${aws_vpc.logicdesk_network.main_route_table_id}"
}

resource "aws_route_table_association" "loadbalancer2_association" {
  subnet_id      = "${aws_subnet.loadbalancer_1.id}"
  route_table_id = "${aws_vpc.logicdesk_network.main_route_table_id}"
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

# Associate webserver subnet with private route table
resource "aws_route_table_association" "webservers1_association" {
  subnet_id      = "${aws_subnet.webservers_1.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate webserver subnet with private route table
resource "aws_route_table_association" "webservers2_association" {
  subnet_id      = "${aws_subnet.webservers_2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate database_1 subnet with private route table
resource "aws_route_table_association" "database_1_association" {
  subnet_id      = "${aws_subnet.database_1.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate database_2 subnet with private route table
resource "aws_route_table_association" "database_2_association" {
  subnet_id      = "${aws_subnet.database_2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
