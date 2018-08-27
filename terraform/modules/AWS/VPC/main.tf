variable "module_name" { }
variable "organization" { }
variable "provider" { }
variable "profile" { }
variable "aws_region" { }
variable "availability_zone" { }
variable "vpc_cidr" { }
variable "public_subnet_cidr" { }

resource "aws_vpc" "project_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${title(var.organization)} VPC"
  }
}

output "vpc_id" {
  value = "${aws_vpc.project_vpc.id}"
}
