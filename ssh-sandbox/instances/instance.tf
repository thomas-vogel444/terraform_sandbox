data "terraform_remote_state" "networking" {
    backend = "local"

    config {
        path = "${path.module}/../networking/terraform.tfstate"
    }
}

resource "aws_instance" "instance" {
    subnet_id = "${data.terraform_remote_state.networking.subnet_id}"
    ami = "ami-030dbca661d402413"
    instance_type = "t2.micro"
    key_name = "${data.terraform_remote_state.networking.key_pair_name}"
    # key_name = "${aws_key_pair.toms_key_pair.key_name}"

    

    vpc_security_group_ids = ["${aws_security_group.security_group.id}"]

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_eip" "eip" {
    vpc = true
    instance = "${aws_instance.instance.id}"

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_security_group" "security_group" {
    vpc_id  = "${data.terraform_remote_state.networking.vpc_id}"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        from_port = 22
        to_port = 22
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        from_port = 22
        to_port = 22
    }

    tags {
        Name = "ssh sandbox"
    }
}