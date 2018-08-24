module "app_launch_config" {
  source = "./LAUNCHCONFIG"
  image_id = "${var.ami}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.arn}"
  user_data =  "${data.template_file.user_data.rendered}"
  key_name = "${aws_key_pair.ec2key.id}"
  security_groups = ["${module.app_ec2_sg.id}","${module.ssh_sg.id}"]
}
module "app_asg" {
  source = "./ASG"
 # placement groups not compatibility with t2.nano instances
 # placement_group = "${module.placement_group.id}"
  launch_configuration_name = "${module.app_launch_config.name}"
  role_arn = "${module.iam_role.arn}"
  tag_key = "environment"
  tag_value = "production"
  max_size = 2
  min_size = 0
  name = "APP_ASG"
  desired_capacity = 1
  force_delete = "true"
  health_check_type = "ELB"
  health_check_grace_period= "300"
  propagate_at_launch = "true"
  delete_timeout       = "15m"
  vpc_zone_identifier = [ "${module.application_subnet.subnet_id}"] 
  availability_zones  = [ "${var.availability_zone }" ]

}

