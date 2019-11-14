provider "aws" {
  region = "eu-west-1"
}



resource "aws_instance" "example-workspace" {
  
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ts-pgs"
    key            = "workspaces-example/terraform.tfstate"
    region         = "eu-west-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-ts-pgs"
    encrypt        = true
  }
}

