data "aws_acm_certificate" "logicdesk" {
  domain   = "*.${var.domain}"
  statuses = ["ISSUED"]
}
