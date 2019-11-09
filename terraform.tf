/*  region = "us-east-2"
}

resource "<PROVIDER>_<TYPE>" "<NAME>" {
  [CONFIG ...]
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
ami-02df9ea15c1778c9c
*/
/*
git init
git add main.tf
git commit -m "Initial commit"
*/
provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {

  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] #<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>

    user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

