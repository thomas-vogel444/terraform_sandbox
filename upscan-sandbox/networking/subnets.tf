resource "aws_subnet" "public_subnet_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-1a"
    
    tags {
        Name = "Upscan Sandbox Public Subnet A"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1b"

    tags {
        Name = "Upscan Sandbox Public Subnet B"
    }
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-1a"

    tags {
        Name = "Upscan Sandbox Private Subnet A"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-1b"

    tags {
        Name = "Upscan Sandbox Private Subnet B"
    }
}