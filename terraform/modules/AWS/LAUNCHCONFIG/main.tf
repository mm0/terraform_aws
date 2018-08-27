variable "image_id"       {}
variable "instance_type"  {}
variable "iam_instance_profile"  {}
variable "key_name"  {}
variable "security_groups"  { type = "list" }
variable "user_data"  { 
  type = "string"
  default = false 
}

resource "aws_launch_configuration" "as_conf" {
  image_id      = "${var.image_id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.security_groups}"]
  iam_instance_profile = "${var.iam_instance_profile}"
  user_data = "${var.user_data}"
  key_name = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

output "id" {
  value = "${aws_launch_configuration.as_conf.id}"
}
output "name" {
  value = "${aws_launch_configuration.as_conf.name}"
}
