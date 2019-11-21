variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
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