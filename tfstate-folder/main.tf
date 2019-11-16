provider "aws" {
  region = "eu-west-1"
}
resource "aws_instance" "example" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
    tags          = {
    Name        = "Application Server"
    Owner = "tstanislawczyk"
    
    }

}

/* backend config to store config in s3
terraform {
  backend "<BACKEND_NAME>" {
    [CONFIG...]
  }
}
*/
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-ts-pgs01"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ts-pgs"
    key            = "workspaces-example/terraform.tfstate"
    region         = "eu-west-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-ts-pgs01"
    encrypt        = true

  }
}
