resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_network_acl" "name" {
    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.subnet_a.id}"]

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
        rule_no = 50
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_subnet" "subnet_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.0.0/24"
    
    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "ssh sandbox"
    }
}
