data "aws_lb_target_group" "upscan_target_group" {
    tags {
        Name = "Upscan Sandbox"
    }
}

resource "aws_ecs_service" "upscan_service" {
    launch_type = "FARGATE"
    task_definition = "upscan_app:5"
    
    cluster = "upscan-cluster"
    name = "upscan_app"

    
    desired_count = 2

    network_configuration {        
        subnets = ["${data.aws_subnet.subnet_a.id}", "${data.aws_subnet.subnet_b.id}"]
        assign_public_ip = true
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