variable "vpc_id"  {}
variable "name"  {}
variable "port"  {}
variable "description"  {}
#variable "prefix_list_ids"  { type = "list" }
variable "cidr_blocks"  { type = "list" }

resource "aws_security_group" "sg" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${var.cidr_blocks}"]
#    prefix_list_ids = ["${var.prefix_list_ids}"]
  }
}

output "id" {
  value = "${aws_security_group.sg.id}"
}
