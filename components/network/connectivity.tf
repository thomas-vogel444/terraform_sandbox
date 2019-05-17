resource "aws_vpc" "default-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = "${aws_vpc.default-vpc.id}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.default-vpc.id}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "Private Subnet"
  }
}

// ******************************************
// Provide internet access to the public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.default-vpc.id}"
}

resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.default-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public-rta" {
  route_table_id = "${aws_route_table.public-rt.id}"
  subnet_id = "${aws_subnet.public-subnet.id}"
}

// ******************************************
// Provide egress internet access to private subnet via a NAT gateway
resource "aws_eip" "nat-gw-ip" {
  vpc = true
  public_ipv4_pool = "amazon"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat-gw-ip.id}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.default-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  tags {
    Name = "Private Route Table"
  }

}

resource "aws_route_table_association" "private-rta" {
  route_table_id = "${aws_route_table.private-rt.id}"
  subnet_id = "${aws_subnet.private-subnet.id}"
}