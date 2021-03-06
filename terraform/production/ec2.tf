module "app_ec2_sg" {
  source = "../modules/AWS/SG"
  vpc_id = "${module.VPC.vpc_id}"
  name = "app_server_sg"
  description = "App Server Security Group"
}
module "app_ec2_sg_rule_egress" {
  source = "../modules/AWS/SGRULE"
  description = "allow outbound traffic on port 80"
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "80"
  to_port = "80"
  security_group_id = "${module.app_ec2_sg.id}"
  #source_security_group = "${module.app_ec2_sg.id}"
}
module "app_ec2_rds_sg_rule_egress" {
  source = "../modules/AWS/SGRULE"
  description = "allow outbound traffic on port 3306"
  type = "egress"
  from_port = "3306"
  to_port = "3306"
  security_group_id = "${module.app_ec2_sg.id}"
  source_security_group = "${module.rds_sg.id}"
}
module "app_ec2_sg_rule_egress_https" {
  source = "../modules/AWS/SGRULE"
  description = "allow outbound traffic on port 443"
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = "443"
  to_port = "443"
  security_group_id = "${module.app_ec2_sg.id}"
  #source_security_group = "${module.app_ec2_sg.id}"
}
module "app_ec2_sg_rule_https" {
  source = "../modules/AWS/SGRULE"
  description = "allow traffic on port 443"
  type = "ingress"
  #cidr_blocks = []
  from_port = "443"
  to_port = "443"
  security_group_id = "${module.app_ec2_sg.id}"
  source_security_group = "${module.app_elb_sg.id}"
}
module "app_ec2_sg_rule" {
  source = "../modules/AWS/SGRULE"
  description = "allow traffic on port 443"
  type = "ingress"
  #cidr_blocks = []
  from_port = "80"
  to_port = "80"
  security_group_id = "${module.app_ec2_sg.id}"
  source_security_group = "${module.app_elb_sg.id}"
}
