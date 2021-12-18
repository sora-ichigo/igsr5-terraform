data "aws_route53_zone" "igsr5" {
  name = "igsr5.com"
}

resource "aws_route53_record" "igsr5" {
  zone_id = data.aws_route53_zone.igsr5.zone_id
  name    = data.aws_route53_zone.igsr5.name
  type    = "A"

  alias {
    name                   = aws_lb.igsr5.dns_name
    zone_id                = aws_lb.igsr5.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "igsr5_sandbox_muson" {
  zone_id = data.aws_route53_zone.igsr5.zone_id
  name    = format("sandbox_muson.%s", data.aws_route53_zone.igsr5.name)
  type    = "A"

  alias {
    name                   = aws_lb.igsr5.dns_name
    zone_id                = aws_lb.igsr5.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "igsr5_time_management_slack" {
  zone_id = data.aws_route53_zone.igsr5.zone_id
  name    = format("time_management.%s", data.aws_route53_zone.igsr5.name)
  type    = "A"

  alias {
    name                   = aws_lb.igsr5.dns_name
    zone_id                = aws_lb.igsr5.zone_id
    evaluate_target_health = true
  }
}



resource "aws_route53_record" "igsr5_certificate" {
  name    = tolist(aws_acm_certificate.igsr5.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.igsr5.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.igsr5.domain_validation_options)[0].resource_record_value]
  zone_id = data.aws_route53_zone.igsr5.id
  ttl     = 60
}

output "domain_name" {
  value = aws_route53_record.igsr5.name
}
