output "instance_public_dns" {
  value = "${aws_eip.eip.public_dns}"
}

output "instance_public_ip" {
  value = "${aws_eip.eip.public_ip}"
}

