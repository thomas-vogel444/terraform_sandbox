resource "aws_network_acl" "public-acl" {
  vpc_id = "${aws_vpc.default-vpc.id}"
  subnet_ids = ["${aws_subnet.public-subnet.id}"]

  ingress {
    action = "allow"
    from_port = 22
    protocol = "tcp"
    rule_no = 100
    to_port = 22
  }
}
