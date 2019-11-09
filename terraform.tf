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

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

resource "aws_instance" "example" {

  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] #<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>

    user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
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

resource "aws_launch_configuration" "example" {
  image_id        = "ami-02df9ea15c1778c9c"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required when using a launch configuration with an auto scaling group.
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}