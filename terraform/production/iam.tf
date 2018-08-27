module "iam_role" {
  source = "../modules/AWS/IAMROLE"
  name = "asg_ec2_role"
}
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${module.iam_role.name}"
}
module "app_iam_server_cert" {
  source = "../modules/AWS/IAMSERVERCERT"
  name_prefix  = "app_server_cert"
  certificate_body = "${file("files/cert.cert")}"
  private_key      = "${file("files/key.pem")}"
  create_before_destroy = true
}
