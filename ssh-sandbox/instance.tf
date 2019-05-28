resource "aws_key_pair" "toms_key_pair" {
    key_name = "personal_aws_rsa"
    public_key = "${file("~/.ssh/personal_aws_rsa.pub")}"
}

resource "aws_eip" "eip" {
    vpc = true
    instance = "${aws_instance.instance.id}"

    tags {
        Name = "ssh sandbox"
    }
}

resource "aws_security_group" "security_group" {
    vpc_id  = "${aws_vpc.vpc.id}"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        from_port = 22
        to_port = 22
    }

    tags {
        Name = "ssh sandbox"
    }
}


resource "aws_instance" "instance" {
    depends_on = ["aws_key_pair.toms_key_pair"]

    subnet_id = "${aws_subnet.subnet_a.id}"
    ami = "ami-030dbca661d402413"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.toms_key_pair.key_name}"

    vpc_security_group_ids = ["${aws_security_group.security_group.id}"]

    tags {
        Name = "ssh sandbox"
    }
}