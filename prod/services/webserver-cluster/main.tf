provider "aws" {
  region = "eu-west-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
}