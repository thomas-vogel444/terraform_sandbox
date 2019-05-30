resource "aws_subnet" "subnet_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.0.0/24"
    
    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_network_acl" "name" {
    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.subnet_a.id}"]

    # Allow ssh connection from anyone
    ingress {
        action = "allow"
        rule_no = 50
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress {
        action = "allow"
        rule_no = 75
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    # Allow the instances on the subnet to connect to the internet
    egress {
        action = "allow"
        rule_no = 50
        cidr_block = "0.0.0.0/0"
        from_port = 1034
        to_port = 65535
        protocol = "tcp"
    }

    tags {
        Name = "ssh sandbox"
    }
}

