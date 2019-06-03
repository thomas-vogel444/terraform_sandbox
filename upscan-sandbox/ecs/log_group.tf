resource "aws_cloudwatch_log_group" "cloudwatch-log-group" {
 name              = "/ecs/upscan-app"
 retention_in_days = 14
}