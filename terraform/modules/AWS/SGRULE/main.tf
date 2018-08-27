variable "protocol"  { default="tcp" }
variable "description"  { default=""}
variable "from_port"  {}
variable "to_port"  {}
variable "type"  {}
variable "cidr_blocks"  { type = "list" , default = []}
variable "security_group_id"  {}
variable "source_security_group"  { default = "" }

resource "aws_security_group_rule" "sg" {
  count = "${length(var.cidr_blocks)}"
  type        = "${var.type}"
  description = "${var.description}"
  from_port   = "${var.from_port}"
  to_port     = "${var.to_port}"
  protocol    = "${var.protocol}"
  cidr_blocks = "${var.cidr_blocks}"
  #source_security_group_id = "${var.source_security_group}"
  security_group_id = "${var.security_group_id}"
}
resource "aws_security_group_rule" "sg2" {
  count = "${length(var.cidr_blocks) != 1 ? 1 : 0}"
  type        = "${var.type}"
  description = "${var.description}"
  from_port   = "${var.from_port}"
  to_port     = "${var.to_port}"
  protocol    = "${var.protocol}"
  #cidr_blocks = "${var.cidr_blocks}"
  source_security_group_id = "${var.source_security_group}"
  security_group_id = "${var.security_group_id}"
}

output "id" {
  value = "${var.security_group_id}"
}
