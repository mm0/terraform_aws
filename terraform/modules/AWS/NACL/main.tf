variable "vpc_id" {}
variable "subnet_ids" { }
variable "port" {}
variable "protocol" {}
variable "cidr_block" {}
variable "name" {}

resource "aws_network_acl" "main" {
  vpc_id = "${var.vpc_id}"
  subnet_ids = ["${var.subnet_ids}"]

  egress {
    protocol   = "${var.protocol}"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.cidr_block}"
    from_port  = "${var.port}"
    to_port    = "${var.port}"
  }

  ingress {
    protocol   = "${var.protocol}"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.cidr_block}"
    from_port  = "${var.port}"
    from_port  = "${var.port}"
    to_port    = "${var.port}"
  }

  tags {
    Name = "${var.name}"
  }
}
