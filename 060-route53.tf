data "aws_route53_zone" "selected" {
  name         = "mguarinos.xyz."
  private_zone = false
}

data "aws_elb_hosted_zone_id" "main" {}

resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = data.aws_route53_zone.selected.name
  type    = "A"

  alias {
    name                   = local.internet_load_balancer_hostname
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }

}

resource "aws_route53_record" "wildcard" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "*.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = local.internet_load_balancer_hostname
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }

}
