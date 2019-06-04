resource "aws_ecs_service" "sunny_upload_service" {
    launch_type = "FARGATE"
    task_definition = "${aws_ecs_task_definition.task_definition.family}:${aws_ecs_task_definition.task_definition.revision}"
    
    cluster = "upscan-cluster"
    name = "sunny_upload"
    
    desired_count = 2

    network_configuration {        
        subnets = ["${data.aws_subnet.private_subnet_a.id}", "${data.aws_subnet.private_subnet_b.id}"]
        security_groups = ["${data.aws_security_group.ecs_sg.id}"]
    }
    
    load_balancer {
        target_group_arn = "${data.aws_lb_target_group.sunny_upload_target_group.arn}"
        container_name = "upscan-app"
        container_port = 9000
    }

    # enable_ecs_managed_tags = true

    # tags {
    #     Name = "Upscan Sandbox"
    # }
}