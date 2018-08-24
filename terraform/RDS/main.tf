variable "allocated_storage"     {}
variable "storage_type"          {}
variable "engine"                {}
variable "engine_version"        {}
variable "instance_class"        {}
variable "name"                  {}
variable "username"              {}
variable "password"              {}
variable "parameter_group_name"  {}
variable "db_subnet_group_name"  {}
variable "vpc_security_group_ids"  { type="list" }
resource "aws_db_instance" "default" {
  allocated_storage    = "${var.allocated_storage}"   
  storage_type         = "${var.storage_type}"        
  engine               = "${var.engine}"              
  engine_version       = "${var.engine_version}"      
  instance_class       = "${var.instance_class}"      
  name                 = "${var.name}"                
  username             = "${var.username}"            
  password             = "${var.password}"            
  parameter_group_name = "${var.parameter_group_name}"
  db_subnet_group_name = "${var.db_subnet_group_name}"
  skip_final_snapshot =  true
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
}

output "endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}
