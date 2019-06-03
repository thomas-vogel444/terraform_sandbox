data "aws_security_group" "sg" {
    tags {
        Name = "Upscan Sandbox Security Group"
    }
}


resource "aws_lb" "elb" {
    name = "upscan-elb"
    internal = false
    load_balancer_type = "application"
    subnets = ["${data.aws_subnet.public_subnet_a.id}", "${data.aws_subnet.public_subnet_b.id}"]
    security_groups = ["${data.aws_security_group.sg.id}"]
    
    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_lb_listener" "upscan_listener" {
    load_balancer_arn = "${aws_lb.elb.arn}"
    # Change to port 443 on HTTPS when adding the certificate
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

# ********************************************************
# For upscan-app
resource "aws_lb_target_group" "upscan_target_group" {
    name = "upscan-target-group"
    vpc_id = "${data.aws_vpc.vpc.id}"
    
    port = 5000
    protocol = "HTTP"
    target_type = "ip"

    # health_check {
    #     enabled = true
    # }

    tags {
        Name = "Upscan Sandbox"
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

# ********************************************************
# For sunny_upload
resource "aws_lb_target_group" "sunny_upload_target_group" {
    name = "sunny-upload-target-group"
    vpc_id = "${data.aws_vpc.vpc.id}"
    
    port = 9000
    protocol = "HTTP"
    target_type = "ip"

    health_check {
        path = "/ping/ping"
    }

    tags {
        Name = "Upscan Sandbox Sunny Upload Target Group"
    }
}

resource "aws_lb_listener_rule" "sunny_upload_listener_rule" {
    listener_arn = "${aws_lb_listener.upscan_listener.arn}"
    priority = 2

    condition {
        field = "path-pattern"
        values = ["/v1/uploads/*"]
    }

    action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.sunny_upload_target_group.arn}"
    }
}