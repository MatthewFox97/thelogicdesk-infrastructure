# Create a new load balancer
resource "aws_lb" "logic-desk" {
  name               = "logicdesk-terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.loadbalancer_sg.id}"]
  subnets            = ["${aws_subnet.loadbalancer_1.id}", "${aws_subnet.loadbalancer_2.id}"]

  enable_deletion_protection = false
  ip_address_type            = "ipv4"

  access_logs {
    bucket  = "${aws_s3_bucket.logs.id}"
    prefix  = "logicdesk-terraform-alb"
    enabled = true
  }

  tags = {
    Name        = "logicdesk-terraform-alb"
    Environment = "Live"
  }
}

# Create the target group for servers to attach to
resource "aws_lb_target_group" "logicdesk-web" {
  name     = "web-targetgroup"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.logicdesk_network.id}"

  health_check {
    path                = "/"
    interval            = "31"
    port                = 8080
    protocol            = "HTTP"
    timeout             = "30"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
  }
}

# Add servers to target group
resource "aws_lb_target_group_attachment" "logicdesk-webserver1" {
  target_group_arn = "${aws_lb_target_group.logicdesk-web.arn}"
  target_id        = "${aws_instance.logicdesk_webserver1.id}"
  port             = 8080
}

# Add servers to target group
resource "aws_lb_target_group_attachment" "logicdesk-webserver2" {
  target_group_arn = "${aws_lb_target_group.logicdesk-web.arn}"
  target_id        = "${aws_instance.logicdesk_webserver2.id}"
  port             = 8080
}

# Create a https listener to manage traffic
resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = "${aws_lb.logic-desk.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${data.aws_acm_certificate.logicdesk.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.logicdesk-web.arn}"
  }
}

# Create a http listener to redirect traffic to https
resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = "${aws_lb.logic-desk.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create a http listener rule to forward the traffic to the servers
resource "aws_lb_listener_rule" "logicdesk_webservers" {
  listener_arn = "${aws_lb_listener.front_end_https.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.logicdesk-web.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["*"]
  }
}
