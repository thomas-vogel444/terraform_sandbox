resource "aws_ecs_task_definition" "task_definition" {
  family                   = "sunny_upload"
  task_role_arn            = "${data.aws_iam_role.ecsTaskDefinitionRole.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = "${data.aws_iam_role.ecsTaskDefinitionRole.arn}"

  container_definitions    = "${module.container_definition.json}"
}


module "container_definition" {
  source = "cloudposse/ecs-container-definition/aws"
  version = "v0.7.0"

  container_name = "upscan-app"
  container_image = "773209191623.dkr.ecr.eu-west-1.amazonaws.com/sunny-upscan-app:latest"

  container_cpu = 1024
  container_memory = 2048
  container_memory_reservation = 2048

  port_mappings = [
    {
      containerPort = 9000
      hostPort = 9000
      protocol = "tcp"
    }
  ]

  log_options = {
    "awslogs-group" = "/ecs/upscan-app"
    "awslogs-region" = "eu-west-1"
    "awslogs-stream-prefix" = "ecs"
  }
}