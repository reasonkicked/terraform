provider "docker" {}

# declare any input variables

# create docker volume resource

# create docker network resource

# create db container
resource "docker_container" "db" {
  name  = "db"
  image = "mysql:5.7"
  restart = "always"
}

# create wordpress container
resource "docker_container" "wordpress" {
  name  = "wordpress"
  image = "wordpress:latest"
  restart = "always"
  port_internal = "80"
  port_external = "8080"
  
}