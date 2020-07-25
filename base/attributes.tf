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

resource "aws_instance" "public_instance1" {
    ami = "ami-08706cb5f68222d09"
    instance_type = "t2.micro"
}

resource "aws_eip_association" "eip_assoc" {
    instance_id = "${aws_instance.public_instance1.id}"
    allocation_id = "${aws_eip.lb.id}"
}

resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    description = "allow inbound 443 from eip"

    ingress {
    description = "TLS from EC2"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
    }
}
