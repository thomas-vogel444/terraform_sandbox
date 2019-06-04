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

data "aws_lb_target_group" "upscan_target_group" {
    name = "upscan-target-group"
}

data "aws_lb_target_group" "sunny_upload_target_group" {
    name = "sunny-upload-target-group"
}

data "aws_security_group" "ecs_sg" {
    tags {
        Name = "Upscan Sandbox Security Group"
    }
}

data "aws_iam_role" "ecsTaskDefinitionRole" {
    name = "ecsTaskExecutionRole"
}
