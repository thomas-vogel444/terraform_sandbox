# resource "aws_security_group" "vpc_endpoint_security_group" {
#     vpc_id = "${aws_vpc.vpc.id}"
#     name = "ECR Security Group"
#     egress {
#         cidr_blocks = ["0.0.0.0/0"]
#         from_port = 0
#         to_port = 65535
#         protocol = "tcp"
#     }

#     ingress {
#         cidr_blocks = ["0.0.0.0/0"]
#         from_port = 0
#         to_port = 65535
#         protocol = "tcp"
#     }

#     tags {
#         Name = "Upscan Sandbox"
#     }
# }


# resource "aws_vpc_endpoint" "ecr_endpoint" {
#     vpc_id = "${aws_vpc.vpc.id}"
#     subnet_ids = ["${aws_subnet.public_subnet_a.id}", "${aws_subnet.public_subnet_b.id}"]
#     vpc_endpoint_type = "Interface"
#     service_name = "com.amazonaws.eu-west-1.ecr.dkr"
#     security_group_ids = ["${aws_security_group.vpc_endpoint_security_group.id}"]
# }

# resource "aws_vpc_endpoint" "s3_endpoint" {
#     vpc_id = "${aws_vpc.vpc.id}"
#     service_name = "com.amazonaws.eu-west-1.s3"
# }

# resource "aws_vpc_endpoint_route_table_association" "route" {
#     route_table_id = "${aws_route_table.route_table.id}"
#     vpc_endpoint_id = "${aws_vpc_endpoint.s3_endpoint.id}"
# }