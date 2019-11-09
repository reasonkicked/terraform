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

  tags = {
    Name = "terraform-example"
  }
}