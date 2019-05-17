resource "aws_network_acl" "public-acl" {
  vpc_id = "${aws_vpc.default-vpc.id}"
  subnet_ids = ["${aws_subnet.public-subnet}"]

  ingress {
    action = "allow"
    from_port = 22
    protocol = "tcp"
    rule_no = 100
    to_port = 22
  }
}

resource "aws_network_acl" "private-acl" {
  vpc_id = "${aws_vpc.default-vpc.id}"
}