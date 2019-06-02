resource "aws_subnet" "public_subnet_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-1a"

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1b"

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_network_acl" "subnet_nacl" {
    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.public_subnet_a.id}", "${aws_subnet.public_subnet_b.id}"]

    egress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1024
        to_port = 65535
    }

    ingress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 65535
    }

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_route_table_association" "route_table_association_a" {
    route_table_id = "${aws_route_table.route_table.id}"
    subnet_id = "${aws_subnet.public_subnet_a.id}"
}

resource "aws_route_table_association" "route_table_association_b" {
    route_table_id = "${aws_route_table.route_table.id}"
    subnet_id = "${aws_subnet.public_subnet_b.id}"
}