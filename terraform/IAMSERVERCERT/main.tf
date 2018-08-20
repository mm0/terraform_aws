variable "name_prefix"           {}
variable "certificate_body"      {}
variable "private_key"           {}
variable "create_before_destroy" {}

resource "aws_iam_server_certificate" "cert" {
  name_prefix      = "${var.name_prefix}"
  certificate_body = "${var.certificate_body}"
  private_key      = "${var.private_key}"

  lifecycle {
    create_before_destroy = true
  }
}
output "ssl_certificate_arn" {
  value = "${aws_iam_server_certificate.cert.arn}"
}
