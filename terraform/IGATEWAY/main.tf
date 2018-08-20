variable "vpc_id" {}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
}

output "id" {
  value = "${aws_internet_gateway.gw.id}"
}
