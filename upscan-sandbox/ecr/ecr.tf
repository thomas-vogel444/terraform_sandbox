resource "aws_ecr_repository" "ecr_repository" {
    name = "upscan_app"
  
    tags {
        Name = "Upscan Sandbox"
    }
}
