# Create a new load balancer
variable "name"  {}
variable "subnet_ids"  { type = "list" }
variable "security_groups"  { type = "list"}
variable "ssl_certificate_arn"  {}
variable "cross_zone_load_balancing"  {}
variable "idle_timeout"  {}
variable "connection_draining_timeout"  {}
variable "connection_draining"  {}

resource "aws_elb" "elb" {
  name = "${var.name}"
  subnets  = ["${var.subnet_ids}"]
  security_groups = ["${var.security_groups}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.ssl_certificate_arn}"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 3
    target = "tcp:80"
    interval = 5
  }
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout = "${var.idle_timeout}"
  connection_draining = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  tags {
    Name = "${var.name}"
  }
}

output "name" {
  value = "${aws_elb.elb.name}"
}
output "dns" {
  value = "${aws_elb.elb.dns_name}"
}
