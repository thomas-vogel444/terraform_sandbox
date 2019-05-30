resource "aws_s3_bucket" "upscan_inbound_bucket" {
    bucket = "thomas-vogel444-upscan-sandbox"
    region = "eu-west-1"
    acl = "bucket-owner-full-control"

    tags {
        Name = "Upscan Sandbox"
    }
}
