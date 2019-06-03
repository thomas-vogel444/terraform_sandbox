data "aws_security_group" "sg" {
    tags {
        Name = "Upscan Sandbox Security Group"
    }
}

data "aws_subnet" "private_subnet_a" {
    tags {
        Name = "Upscan Sandbox Private Subnet A"
    }
}

data "aws_subnet" "public_subnet_a" {
    tags {
        Name = "Upscan Sandbox Public Subnet A"
    }
}

resource "aws_instance" "public_instance" {
    ami = "ami-030dbca661d402413"
    instance_type = "t2.micro"
    key_name = "personal_aws_rsa"
    security_groups = ["${data.aws_security_group.sg.id}"]
    subnet_id = "${data.aws_subnet.public_subnet_a.id}"

    tags {
        Name = "Upscan Sandbox Public Instance"
    }
}
resource "aws_instance" "private_instance" {
    ami = "ami-030dbca661d402413"
    instance_type = "t2.micro"
    key_name = "personal_aws_rsa"
    security_groups = ["${data.aws_security_group.sg.id}"]
    subnet_id = "${data.aws_subnet.private_subnet_a.id}"

    tags {
        Name = "Upscan Sandbox Private Instance"
    }
}

resource "aws_eip" "public_eip" {
    vpc = true
    instance = "${aws_instance.public_instance.id}"

    tags {
        Name = "Upscan Sandbox Public Instance EIP"
    }
}

output "public_ip" {
  value = "${aws_eip.public_eip.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.private_instance.private_ip}"
}
