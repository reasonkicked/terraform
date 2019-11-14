provider "aws" {
  region = "eu-west-1"
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-ts-pgs"


  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_instance" "example-workspace" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-ts-pgs"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
#com

/* backend config to store config in s3
terraform {
  backend "<BACKEND_NAME>" {
    [CONFIG...]
  }
}
*/
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ts-pgs"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-ts-pgs"
    encrypt        = true

  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
  }

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}