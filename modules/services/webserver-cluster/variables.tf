variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}
variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "db_location" {
  description = "db location"
  type = string
}
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}
variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}
variable "enable_new_user_data" {
  description = "If set to true, use the new User Data script"
  type        = bool
}
/*
output "<NAME>" {
  value = <VALUE>
  [CONFIG ...]
}
variable "NAME" {
  [CONFIG ...]description, default, type...
  
}
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}
 terraform plan -var "server_port=8080"
 or
 export TF_VAR_server_port=8080
 terraform plan

variable "number_example" {
  description = "An example of a number variable in Terraform"
  type        = number
  default     = 42
}
variable "list_example" {
  description = "An example of a list in Terraform"
  type        = list
  default     = ["a", "b", "c"]
}
variable "list_numeric_example" {
  description = "An example of a numeric list in Terraform"
  type        = list(number)
  default     = [1, 2, 3]
}
variable "map_example" {
  description = "An example of a map in Terraform"
  type        = map(string)

  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}
variable "object_example" {
  description = "An example of a structural type in Terraform"
  type        = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })
   default = {
    name    = "value1"
    age     = 42
    tags    = ["a", "b", "c"]
    enabled = true
  }
}

dla data source
data "<PROVIDER>_<TYPE>" "<NAME>" {
  [CONFIG ...]
}
data "aws_vpc" "default" {
  default = true
}
czyli
data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
data.aws_vpc.default.id
lub
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}


*/