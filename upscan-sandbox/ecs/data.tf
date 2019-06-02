data "aws_vpc" "vpc" {
    tags {
        Name = "Upscan Sandbox"
    }
}

data "aws_subnet" "subnet_a" {
    availability_zone = "eu-west-1a"

    tags {
        Name = "Upscan Sandbox"
    }
}

data "aws_subnet" "subnet_b" {
    availability_zone = "eu-west-1b"

    tags {
        Name = "Upscan Sandbox"
    }
}