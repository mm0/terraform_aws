module "iam_role" {
  source = "./IAMROLE"
  name = "asg_ec2_role"
}
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${module.iam_role.name}"
}
module "app_iam_server_cert" {
  source = "./IAMSERVERCERT"
  name_prefix  = "app_server_cert"
  certificate_body = "${file("files/cert.cert")}"
  private_key      = "${file("files/key.pem")}"
  create_before_destroy = true
}
