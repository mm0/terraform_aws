variable "route_table_name" {}
variable "vpc_id" {}
variable "cidr_block" {}
variable "igw_id" {}

resource "aws_route_table" "route_table" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "${var.cidr_block}"
    gateway_id = "${var.igw_id}"
  }
  tags {
    Name = "${var.route_table_name}"
  }
}

output "route_table_id" {
  value = "${aws_route_table.route_table.id}"
}
