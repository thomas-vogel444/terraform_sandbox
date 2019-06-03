resource "aws_eip" "nat_eip" {
    vpc = true

    tags {
        Name = "Upscan Sandbox NAT EIP"
    }
}


resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id = "${aws_subnet.public_subnet_a.id}"

    tags {
        Name = "Upscan Sandbox"
    }
}
