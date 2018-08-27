#route53
variable "aws_region" { }
variable "zone_id" { }
variable "name" { }
variable "type" { }
variable "ttl" {
  default = "60"
}
variable "records" {
  type = "list"
}

variable "provider" { }
variable "profile" { }

provider "${var.provider}" {
  profile = "${var.profile}"
  region = "${var.aws_region}"
}

resource "aws_route53_record" "route53_record" {
  // same number of records as instances
  zone_id = "${var.zone_id}"
  name = "${var.name}"
  type = "${var.type}"
  ttl = "${var.ttl}"
  // matches up record N to instance N
  records = ["${var.records}"]
}