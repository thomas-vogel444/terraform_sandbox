resource "aws_vpc" "toms-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "toms-public-subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = "${aws_vpc.toms-vpc.id}"

  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "toms-private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.toms-vpc.id}"
}

// *******************************************************
// NAT Gateway to provide internet access to the public subnet
resource "aws_internet_gateway" "toms-IG" {
  vpc_id = "${aws_vpc.toms-vpc.id}"
}

resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.toms-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.toms-IG.id}"
  }
}

resource "aws_route_table_association" "web-public-rt" {
  route_table_id = "${aws_route_table.web-public-rt.id}"
  subnet_id = "${aws_subnet.toms-public-subnet.id}"
}

// *******************************************************
// Security groups
resource "aws_security_group" "public-sg" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  vpc_id = "${aws_vpc.toms-vpc.id}"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// *******************************************************
// key-pair
resource "aws_key_pair" "toms-personal-aws-key" {
  key_name = "toms-personal-aws-key"
  public_key = "${file("~/.ssh/personal_aws_rsa.pub")}"
}

//resource "aws_instance" "toms-instance" {
//  ami = "ami-00103874"
//  instance_type = "t2.micro"
//}