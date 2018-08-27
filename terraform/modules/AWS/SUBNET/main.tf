variable "vpc_id" { }
variable "cidr_block" {}
variable "subnet_name" {}
variable "subnet_availability_zone" {}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.cidr_block}"
  availability_zone = "${var.subnet_availability_zone}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.subnet_name}"
  }
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}
