provider "aws" {
  profile = "${var.profile}"
  region = "${var.aws_region}"
}
data "template_file" "user_data" {
  template = "${file("templates/user.data")}"

  vars {
    endpoint   = "${module.app_rds.endpoint}"
    db         = "wagdb"
    username   = "wag"
    password   = "wagwagwg"
  }
}
