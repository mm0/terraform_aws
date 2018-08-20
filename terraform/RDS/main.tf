variable "allocated_storage"     {}
variable "storage_type"          {}
variable "engine"                {}
variable "engine_version"        {}
variable "instance_class"        {}
variable "name"                  {}
variable "username"              {}
variable "password"              {}
variable "parameter_group_name"  {}

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
}

output "endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}
