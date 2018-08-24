variable "subnet_id" {}

resource "aws_eip" "ip" {
  vpc = true
}
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.ip.id}"
  subnet_id     = "${var.subnet_id}"
}

output "id" {
  value = "${aws_nat_gateway.gw.id}"
}
