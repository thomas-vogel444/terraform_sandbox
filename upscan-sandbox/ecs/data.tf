data "aws_vpc" "vpc" {
    tags {
        Name = "Upscan Sandbox"
    }
}

data "aws_subnet" "private_subnet_a" {
    availability_zone = "eu-west-1a"

    tags {
        Name = "Upscan Sandbox Private Subnet A"
    }
}

data "aws_subnet" "private_subnet_b" {
    availability_zone = "eu-west-1b"

    tags {
        Name = "Upscan Sandbox Private Subnet B"
    }
}