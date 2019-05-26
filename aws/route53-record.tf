data "aws_route53_zone" "thelogicdesk" {
  name = "${var.domain}"
}

resource "aws_route53_record" "wwwlogicdesk" {
  zone_id = "${data.aws_route53_zone.thelogicdesk.zone_id}"
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = "${aws_lb.logic-desk.dns_name}"
    zone_id                = "${aws_lb.logic-desk.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "logicdesk" {
  zone_id = "${data.aws_route53_zone.thelogicdesk.zone_id}"
  name    = "${data.aws_route53_zone.thelogicdesk.name}"
  type    = "A"

  alias {
    name                   = "${aws_route53_record.wwwlogicdesk.name}"
    zone_id                = "${data.aws_route53_zone.thelogicdesk.zone_id}"
    evaluate_target_health = false
  }
}
