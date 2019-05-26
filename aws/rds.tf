resource "aws_db_instance" "logicdesk_db" {
  identifier             = "logicdesk-db-server"
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "thelogicdeskdb"
  username               = "root"
  password               = "xofwehttam"
  db_subnet_group_name   = "${aws_db_subnet_group.logicdesk_sub.id}"
  vpc_security_group_ids = ["${aws_security_group.database_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true

  tags = {
    Name        = "LogicDesk_DB_Server"
    Role        = "database"
    Environment = "live"
  }
}

resource "aws_db_subnet_group" "logicdesk_sub" {
  name       = "main"
  subnet_ids = ["${aws_subnet.database_1.id}", "${aws_subnet.database_2.id}"]

  tags = {
    Name = "DB subnet group"
  }
}
