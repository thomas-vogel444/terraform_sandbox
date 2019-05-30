resource "aws_key_pair" "toms_key_pair" {
    key_name = "personal_aws_rsa"
    public_key = "${file("~/.ssh/personal_aws_rsa.pub")}"
}