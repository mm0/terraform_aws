resource "aws_key_pair" "ec2key" {
  key_name   = "${var.aws_key_name}"
  public_key = "${var.ssh_public_key}"
}

module "VPC" {
  source = "../modules/AWS/VPC"
  organization = "${var.organization}"
  provider = "${var.provider}"
  module_name = "${var.module_name}"
  profile = "${var.profile}"
  aws_region = "${var.aws_region}"
  availability_zone = "${var.availability_zone}"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet_cidr = "${var.public_subnet_cidr}"
}
module "main_internet_gateway" {
  source = "../modules/AWS/IGATEWAY"
  vpc_id = "${module.VPC.vpc_id}"
}
module "network_if" {
  source = "../modules/AWS/NETWORKINTERFACE"
  subnet_id = "${module.public_subnet.subnet_id}"
}
module "network_interface_eip" {
  source = "../modules/AWS/EIP"
  network_interface = "${module.network_if.id}"
#  depends_on = ["module.main_internet_gateway"]
}
module "main_nat_gateway" {
  source = "../modules/AWS/NATGATEWAY"
  subnet_id = "${module.public_subnet.subnet_id}"
  #allocation_id = "${module.nat_eip.allocation_id}"
#  depends_on = ["module.main_internet_gateway"]
}
module "public_route_table" {
  source = "../modules/AWS/ROUTETABLE"
  vpc_id = "${module.VPC.vpc_id}"
  cidr_block = "0.0.0.0/0"
  igw_id = "${module.main_internet_gateway.id}"
  route_table_name = "public_route_table"
}

module "public_route_table_association" {
  source = "../modules/AWS/ROUTETABLEASSOCIATION"
  subnet_id = "${module.public_subnet.subnet_id}"
  route_table_id = "${module.public_route_table.route_table_id}"
}
module "public_route_table_association_2" {
  source = "../modules/AWS/ROUTETABLEASSOCIATION"
  subnet_id = "${module.application_subnet.subnet_id}"
  route_table_id = "${module.public_route_table.route_table_id}"
}
module "main_nacl" {
  source = "../modules/AWS/NACL"
  port = 22
  vpc_id = "${module.VPC.vpc_id}"
  subnet_ids = "${module.public_subnet.subnet_id}"
  cidr_block = "0.0.0.0/0"
  name = "public nacl"
  protocol = "tcp"
}
# placement groups not compatibility with t2.nano instances
#module "placement_group" {
#  source = "../modules/AWS/PLACEMENTGROUP"
#  name = "prod"
#  strategy = "cluster"
#}

