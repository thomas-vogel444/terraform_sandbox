resource "aws_ecs_cluster" "upscan_cluster" {
    name = "upscan-cluster"

    tags {
        Name = "Upscan Sandbox"
    }
}
