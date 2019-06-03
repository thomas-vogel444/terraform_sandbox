# **********************************************************************
# Public Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_route_table_association" "rt_association_public_a" {
    route_table_id = "${aws_route_table.public_route_table.id}"
    subnet_id = "${aws_subnet.public_subnet_a.id}"
}

resource "aws_route_table_association" "rt_association_public_b" {
    route_table_id = "${aws_route_table.public_route_table.id}"
    subnet_id = "${aws_subnet.public_subnet_b.id}"
}

# **********************************************************************
# Private Route Table
resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_route_table_association" "rt_association_private_a" {
    route_table_id = "${aws_route_table.private_route_table.id}"
    subnet_id = "${aws_subnet.private_subnet_a.id}"
}

resource "aws_route_table_association" "rt_association_private_b" {
    route_table_id = "${aws_route_table.private_route_table.id}"
    subnet_id = "${aws_subnet.private_subnet_b.id}"
}