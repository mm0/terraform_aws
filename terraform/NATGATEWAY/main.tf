variable "allocation_id" {}
variable "subnet_id" {}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${var.allocation_id}"
  subnet_id     = "${var.subnet_id}"
}

output "id" {
  value = "${aws_nat_gateway.gw.id}"
}
