output "key_pair_name" {
  value = "${aws_key_pair.toms_key_pair.key_name}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.subnet_a.id}"
}
