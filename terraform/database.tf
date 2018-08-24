resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [ "${module.application_subnet.subnet_id}" ,"${module.database_subnet.subnet_id}"] 
  tags {
    Name = "My DB subnet group"
  }
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
  password             = "wagwagwg"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids = ["${module.rds_sg.id}"]
}
module "rds_sg" {
  source = "./SG"
  vpc_id = "${module.VPC.vpc_id}"
  name = "rds_sg"
  description = "Allow 3306 traffic from app servers"
}
module "app_rds_sg_rule_ingress" {
  source = "./SGRULE"
  description = "MySQL Access"
  type = "ingress"
  from_port = "3306"
  to_port = "3306"
  security_group_id = "${module.rds_sg.id}"
  source_security_group = "${module.app_ec2_sg.id}"
}
module "app_rds_sg_rule_egress" {
  source = "./SGRULE"
  description = "MySQL Access"
  type = "egress"
  from_port = "3306"
  to_port = "3306"
  security_group_id = "${module.rds_sg.id}"
  source_security_group = "${module.app_ec2_sg.id}"
}
