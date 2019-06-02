resource "aws_eip" "upscan_eip" {
    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_lb" "elb" {
    name = "upscan-elb"
    internal = false
    load_balancer_type = "application"
    subnets = ["${data.aws_subnet.subnet_a.id}", "${data.aws_subnet.subnet_b.id}"]
    
    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_lb_target_group" "upscan_target_group" {
    name = "upscan-target-group"
    port = "5000"
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${data.aws_vpc.vpc.id}"

    # health_check {
    #     enabled = true
    # }

    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_lb_listener" "upscan_listener" {
    load_balancer_arn = "${aws_lb.elb.arn}"
    port = "80"
    protocol = "HTTP"

    # certificate_arn = "some_arn"
    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "Doesn't exist man!"
            status_code = "404"
        }
    }
}

resource "aws_lb_listener_rule" "upscan_listener_rule" {
    listener_arn = "${aws_lb_listener.upscan_listener.arn}"
    priority = 1

    condition {
        field = "path-pattern"
        values = ["/"]
    }

    action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.upscan_target_group.arn}"
    }
}


output "eip_public_ip" {
  value = "${aws_eip.upscan_eip.public_ip}"
}

output "eip_public_dns" {
  value = "${aws_eip.upscan_eip.public_dns}"
}
