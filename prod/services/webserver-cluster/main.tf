provider "aws" {
  region = "eu-west-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-ts-pgs"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
instance_type = "t2.micro"
  min_size = 4
  max_size = 10
}