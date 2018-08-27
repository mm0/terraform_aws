module "ssh_sg" {
  source = "../modules/AWS/SG"
  vpc_id = "${module.VPC.vpc_id}"
  name = "ssh_access_sg"
  description = "SSH Access Security Group"
}
module "ssh_sg_rule" {
  source = "../modules/AWS/SGRULE"
  description = "allow ssh traffic "
  type = "ingress"
  cidr_blocks = ["${var.my_ip_address}/32"]
  from_port = "22"
  to_port = "22"
  security_group_id = "${module.ssh_sg.id}"
  #source_security_group = "${module.app_elb_sg.id}"
}
