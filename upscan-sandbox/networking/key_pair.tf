resource "aws_key_pair" "personal_aws_rsa" {
    key_name = "personal_aws_rsa"
    public_key = "${file("/Users/thomasvogel/.ssh/personal_aws_rsa.pub")}"
}
