variable "network_interface" {}
resource "aws_eip" "ip" {
  vpc                       = true
  network_interface         = "${var.network_interface}"
}

output "allocation_id" {
  value = "${aws_eip.ip.id}"
}
