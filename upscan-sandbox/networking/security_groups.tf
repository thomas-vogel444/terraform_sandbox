resource "aws_security_group" "ecs_sg" {
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 1
        to_port = 65535
        protocol = "tcp"
    }
    
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 1
        to_port = 65535
        protocol = "tcp"
    }

    tags {
        Name = "Upscan Sandbox Security Group"
    }
}