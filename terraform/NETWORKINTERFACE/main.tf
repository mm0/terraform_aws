variable "subnet_id" {}

resource "aws_network_interface" "if" {
  subnet_id   = "${var.subnet_id}"
}

output "id" {
  value = "${aws_network_interface.if.id}"
}
