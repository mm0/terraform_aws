variable "launch_configuration_name"  {}
variable "role_arn"  {}
variable "tag_key"  {}
variable "tag_value"  {}
variable "propagate_at_launch"  {}
variable "desired_capacity"  {}
variable "force_delete"  {}
variable "health_check_type"  {}
variable "health_check_grace_period"  {}
variable "max_size"  {}
variable "min_size"  {}
variable "vpc_zone_identifier"  { type = "list" }
variable "name"  {}
variable "delete_timeout"  {}
variable "availability_zones"  { type = "list" }

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.name}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  desired_capacity          = "${var.desired_capacity}"
  force_delete              = "${var.force_delete}"
  #placement_group           = "${var.placement_group}"
  launch_configuration      = "${var.launch_configuration_name}"
  availability_zones        = ["${var.availability_zones}"]
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]

  initial_lifecycle_hook {
    name                 = "${var.name}"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    #role_arn                = "${var.role_arn}"
  }

  tag {
    key                 = "${var.tag_key}"
    value               = "${var.tag_value}"
    propagate_at_launch = "${var.propagate_at_launch}"
  }

  timeouts {
    delete = "${var.delete_timeout}"
  }
}
