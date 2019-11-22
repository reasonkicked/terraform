provider "aws" {
  region = "eu-west-1"
}


resource "aws_db_instance" "prod_database" {
  identifier_prefix   = "terraform-up-and-running-prod"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "database_prod"
  username            = "admin"

  # How should we set the password?
  password            = "db_password"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ts-pgs"
    key            = "prod/data-stores/mysql/terraform.tfstate"
    region         = "eu-west-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-ts-pgs01"
    encrypt        = true
  }
}
