resource "aws_subnet" "loadbalancer_1" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.1.0/24"
  availability_zone = "${var.avail_zone_a}"

  tags = {
    Name = "loadbalancer_sub"
  }
}

resource "aws_subnet" "loadbalancer_2" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.2.0/24"
  availability_zone = "${var.avail_zone_b}"

  tags = {
    Name = "loadbalancer_sub"
  }
}

resource "aws_subnet" "webservers_1" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.10.0/24"
  availability_zone = "${var.avail_zone_a}"

  tags = {
    Name = "webservers"
  }
}

resource "aws_subnet" "webservers_2" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.11.0/24"
  availability_zone = "${var.avail_zone_b}"

  tags = {
    Name = "webservers"
  }
}

resource "aws_subnet" "database_1" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.20.0/24"
  availability_zone = "${var.avail_zone_a}"

  tags = {
    Name = "database_1"
  }
}

resource "aws_subnet" "database_2" {
  vpc_id            = "${aws_vpc.logicdesk_network.id}"
  cidr_block        = "10.10.21.0/24"
  availability_zone = "${var.avail_zone_b}"

  tags = {
    Name = "database_2"
  }
}
