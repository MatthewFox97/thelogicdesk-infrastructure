resource "aws_instance" "logicdesk_webserver1" {
  ami                         = "${var.aws_ami}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.webserver_sg.id}"]
  subnet_id                   = "${aws_subnet.webservers_1.id}"
  key_name                    = "${aws_key_pair.aws_key_pair.key_name}"
  associate_public_ip_address = true

  tags = {
    Name        = "LogicServer1"
    Role        = "webserver"
    Environment = "live"
  }
}

resource "aws_instance" "logicdesk_webserver2" {
  ami                         = "${var.aws_ami}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.webserver_sg.id}"]
  subnet_id                   = "${aws_subnet.webservers_2.id}"
  key_name                    = "${aws_key_pair.aws_key_pair.key_name}"
  associate_public_ip_address = true

  tags = {
    Name        = "LogicServer2"
    Role        = "webserver"
    Environment = "live"
  }
}
