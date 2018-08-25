module "app_elb" {
  source = "./ELB"
  name = "APPELB"
  subnet_ids = ["${module.application_subnet.subnet_id}"]
  security_groups = ["${module.app_elb_sg.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining_timeout = 400
  connection_draining = true
  ssl_certificate_arn = "${module.app_iam_server_cert.ssl_certificate_arn}"
}
module "app_elb_sg" {
  source = "./SG"
  vpc_id = "${module.VPC.vpc_id}"
  name = "elb_sg"
  description = "ELB Security Group"
}
module "app_elb_sg_rule" {
  source = "./SGRULE"
  description = "allow traffic on port 80"
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "80"
  to_port = "80"
  security_group_id = "${module.app_elb_sg.id}"
}
module "app_elb_sg_rule_https" {
  source = "./SGRULE"
  description = "allow traffic on port 80"
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "443"
  to_port = "443"
  security_group_id = "${module.app_elb_sg.id}"
}
module "app_elb_sg_rule_egress" {
  source = "./SGRULE"
  description = "allow traffic on port 80"
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "80"
  to_port = "80"
  security_group_id = "${module.app_elb_sg.id}"
}
module "app_elb_sg_rule_egress_https" {
  source = "./SGRULE"
  description = "allow traffic on port 80"
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "443"
  to_port = "443"
  security_group_id = "${module.app_elb_sg.id}"
}
