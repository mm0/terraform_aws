variable "vpc_id"  {}
variable "name"  {}
variable "description"  {}

resource "aws_security_group" "sg" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"
}

output "id" {
  value = "${aws_security_group.sg.id}"
}
