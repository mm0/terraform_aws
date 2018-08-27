variable "name" {}
variable "strategy" {}

resource "aws_placement_group" "group" {
  name     = "${var.name}"
  strategy = "${var.strategy}"
}

output "id" {
  value = "${aws_placement_group.group.id}"
}

