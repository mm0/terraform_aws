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
variable "vpc_cidr" { }
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

provider "aws" {
  profile = "${var.profile}"
  region = "${var.aws_region}"
}

module "VPC" {
  source = "./VPC"
  organization = "${var.organization}"
  provider = "${var.provider}"
  module_name = "${var.module_name}"
  profile = "${var.profile}"
  aws_region = "${var.aws_region}"
  availability_zone = "${var.availability_zone}"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet_cidr = "${var.public_subnet_cidr}"
}
# TODO: Internet Gateway
module "main_internet_gateway" {
  source = "./IGATEWAY"
  vpc_id = "${module.VPC.vpc_id}"
}
module "public_subnet" {
  source = "./SUBNET"
  vpc_id = "${module.VPC.vpc_id}"
  cidr_block = "${var.public_subnet_cidr}"
  subnet_availability_zone = "${var.availability_zone}"
  subnet_name = "${title(var.organization)} - ${title(var.module_name)} - Public Subnet"
}
module "network_if" {
  source = "./NETWORKINTERFACE"
  subnet_id = "${module.public_subnet.subnet_id}"
}
module "nat_eip" {
  source = "./EIP"
  network_interface = "${module.network_if.id}"
}
# TODO: NAT Gateway
module "main_nat_gateway" {
  source = "./NATGATEWAY"
  subnet_id = "${module.public_subnet.subnet_id}"
  allocation_id = "${module.nat_eip.allocation_id}"
}
module "public_route_table" {
  source = "./ROUTETABLE"
  vpc_id = "${module.VPC.vpc_id}"
  cidr_block = "0.0.0.0/0"
  igw_id = "${module.main_internet_gateway.id}"
  route_table_name = "public_route_table"
}

module "public_route_table_association" {
  source = "./ROUTETABLEASSOCIATION"
  subnet_id = "${module.public_subnet.subnet_id}"
  route_table_id = "${module.public_route_table.route_table_id}"
}
module "main_nacl" {
  source = "./NACL"
  port = 22
  vpc_id = "${module.VPC.vpc_id}"
  subnet_ids = "${module.public_subnet.subnet_id}"
  cidr_block = "0.0.0.0/0"
  name = "public nacl"
  protocol = "TCP"
}
module "placement_group" {
  source = "./PLACEMENTGROUP"
  name = "prod"
  strategy = "cluster"
}
module "iam_role" {
  source = "./IAMROLE"
  name = "asg_ec2_role"
}
data "template_file" "user_data" {
  template = "${file("user.data")}"

  vars {
    endpoint   = "${module.app_rds.endpoint}"
    db         = "wagdb"
    username   = "wag"
    password   = "wag@wagw@g"
  }
}
module "app_launch_config" {
  source = "./LAUNCHCONFIG"
  image_id = "${var.ami}"
  instance_type = "t2.nano"
  iam_instance_profile = "${module.iam_role.arn}"
  user_data =  "${file("user.data")}" 
  #user_data = ""
}
module "app_iam_server_cert" {
  source = "./IAMSERVERCERT"
  name_prefix  = "app_server_cert"
  certificate_body = "${file("cert.cert")}"
  private_key      = "${file("key.pem")}"
  create_before_destroy = true
}
module "app_elb" {
  source = "./ELB"
  name = "APPELB"
  subnet_ids = "${module.application_subnet.subnet_id}"
  security_groups = "${module.app_elb_sg.id}"
  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining_timeout = 400
  connection_draining = true
  ssl_certificate_arn = "${module.app_iam_server_cert.ssl_certificate_arn}"
}
module "app_elb_sg" {
  source = "./SG"
  vpc_id = "${module.VPC.vpc_id}"
  name = "allow_all"
  description = "Allow all inbound traffic"
  # prefix_list_ids = 
  cidr_blocks = ["0.0.0.0/0"]
  port = "443"
}
module "app_asg" {
  source = "./ASG"
  placement_group = "${module.placement_group.id}"
  launch_configuration_name = "${module.app_launch_config.name}"
  role_arn = "${module.iam_role.arn}"
  tag_key = "environment"
  tag_value = "production"
  max_size = 2
  min_size = 0
  name = "APP_ASG"
  desired_capacity = 1
  force_delete = "true"
  health_check_type = "ELB"
  health_check_grace_period= "300"
  propagate_at_launch = "true"
  delete_timeout       = "15m"
}
module "app_rds" {
  source = "./RDS"
  allocated_storage    = 8
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wagdb"
  username             = "wag"
  password             = "wag@wagw@g"
  parameter_group_name = "default.mysql5.7"
}
module "database_subnet" {
  source = "./SUBNET"
  cidr_block = "10.20.10.0/24"
  vpc_id = "${module.VPC.vpc_id}"
  subnet_availability_zone = "${var.availability_zone}"
  subnet_name = "Database Subnet"
}
module "application_subnet" {
  source = "./SUBNET"
  cidr_block = "10.20.20.0/24"
  subnet_availability_zone = "${var.availability_zone}"
  vpc_id = "${module.VPC.vpc_id}"
  subnet_name = "Application Server Subnet"
}
module "elb_subnet" {
  source = "./SUBNET"
  cidr_block = "10.20.30.0/24"
  subnet_availability_zone = "${var.availability_zone}"
  subnet_name = "Load Balancer"
  vpc_id = "${module.VPC.vpc_id}"
  subnet_name = "ELB  Subnet"
}
