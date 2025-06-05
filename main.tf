resource "docker_network" "shared" {
  name = "my-app-network"
}

module "nginx" {
  source         = "./modules/container_service"
  container_name = "nginx-container"
  image          = "nginx:latest"
  internal_port  = 80
  external_port  = 80
  network_name   = docker_network.shared.name

  providers = {
    docker = docker
  }
}

module "app" {
  source         = "./modules/container_service"
  container_name = "app-container"
  image          = "python:3.11-slim"
  internal_port  = 5000
  external_port  = 5000
  network_name   = docker_network.shared.name

  providers = {
    docker = docker
  }
}
