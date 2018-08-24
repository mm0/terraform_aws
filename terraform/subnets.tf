module "database_subnet" {
  source = "./SUBNET"
  cidr_block = "10.20.10.0/24"
  vpc_id = "${module.VPC.vpc_id}"
  subnet_availability_zone = "us-west-2b"
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
