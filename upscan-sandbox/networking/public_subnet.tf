resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.0.0/24"

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"

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

resource "aws_route_table_association" "route_table_association" {
    route_table_id = "${aws_route_table.route_table.id}"
    subnet_id = "${aws_subnet.public_subnet.id}"
}
