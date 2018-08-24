# User Variables
variable "module_name" {
  default = "wag_vpc"
}
variable "organization" {
  default = "wag"
}
variable "provider" { }
variable "profile" { }
variable "aws_region" { }
variable "availability_zone" { }
variable "aws_key_name" { }
variable "vpc_cidr" { 
  default = "10.20.0.0/16"
}
variable "vpc_name" { }
variable "iam_role" { }
variable "public_subnet_cidr" { }
variable "ec2_iam_instance_profile" { }

variable "my_ip_address" { }
variable "ssh_public_key" { }
variable "instance_type" { }
variable "ami" { }
variable "destination_ansible_hosts_file" { }
variable "domain" { }
variable "server_name" {
  default = "homesite"
}
variable "internal_subdomain" {
  default ="prod"
}
variable "internal_dns_main_zone_domain"{
  default = "organization.internal"
}
