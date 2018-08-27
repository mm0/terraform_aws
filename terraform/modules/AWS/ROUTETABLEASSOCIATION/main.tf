variable "subnet_id" { }
variable "route_table_id" { }

resource "aws_route_table_association" "route_table_assn" {
  subnet_id = "${var.subnet_id}"
  route_table_id = "${var.route_table_id}"
}
output "id" {
  value = "${aws_route_table_association.route_table_assn.id}"
}
