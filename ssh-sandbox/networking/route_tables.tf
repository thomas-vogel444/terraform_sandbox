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

resource "aws_route_table_association" "tf_association" {
    subnet_id = "${aws_subnet.subnet_a.id}"
    route_table_id = "${aws_route_table.route_table.id}"
}