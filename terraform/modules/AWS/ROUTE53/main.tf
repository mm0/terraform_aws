variable "internal_dns_main_zone_domain"{ }
variable "vpc_id" { }
variable "aws_region" { }

variable "provider" { }
variable "profile" { }
variable "records" { }

provider "${var.provider}" {
  profile = "${var.profile}"
  region = "${var.aws_region}"
}

resource "aws_route53_zone" "main" {
  name = "${var.internal_dns_main_zone_domain}"
  vpc_id = "${var.vpc_id}"
  vpc_region = "${var.aws_region}"
}

