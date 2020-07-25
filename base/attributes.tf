provider "aws"{
    region = "ap-south-1"
}

resource "aws_eip" "lb" {
  vpc      = true
}

output "public_ip" {
    value = aws_eip.lb.public_ip
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "my-tf-test-bucket-july"
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.s3_bucket.arn
}
