provider "aws" {
  region = "eu-west-1"
}
# Terraform state will be stored in S3

terraform {
  backend "s3" {
    bucket = "tsjenkins01-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-02df9ea15c1778c9c"
  instance_type          = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World 20" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
    Owner = "tstanislawczyk"
    Description = "opis testowy"
  }
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_security_group" "instance-jenkins" {
  name = "terraform-example-instance-jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}