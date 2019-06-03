resource "aws_network_acl" "public_subnet_nacl" {
    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.public_subnet_a.id}", "${aws_subnet.public_subnet_b.id}"]

    ingress {
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 65535
        protocol = "tcp"
    }

    egress {
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 65535
        protocol = "tcp"
    }

    tags {
        Name = "Upscan Sandbox Public NACL"
    }
}

resource "aws_network_acl" "private_subnet_nacl" {
    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.private_subnet_a.id}", "${aws_subnet.private_subnet_b.id}"]

    ingress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 65535
    }
    
    egress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 65535
    }

    tags {
        Name = "Upscan Sandbox Private NACL"
    }
}