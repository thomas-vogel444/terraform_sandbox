data "aws_lb_target_group" "upscan_target_group" {
    tags {
        Name = "Upscan Sandbox"
    }
}

data "aws_security_group" "ecs_sg" {
    tags {
        Name = "Upscan Sandbox Security Group"
    }
}


resource "aws_ecs_service" "upscan_service" {
    launch_type = "FARGATE"
    task_definition = "upscan_app:5"
    
    cluster = "upscan-cluster"
    name = "upscan_app"
    
    desired_count = 2

    network_configuration {        
        subnets = ["${data.aws_subnet.private_subnet_a.id}", "${data.aws_subnet.private_subnet_b.id}"]
        security_groups = ["${data.aws_security_group.ecs_sg.id}"]
    }
    
    load_balancer {
        target_group_arn = "${data.aws_lb_target_group.upscan_target_group.arn}"
        container_name = "app"
        container_port = 5000
    }

    # enable_ecs_managed_tags = true

    # tags {
    #     Name = "Upscan Sandbox"
    # }
}