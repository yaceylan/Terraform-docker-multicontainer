resource "docker_container" "this" {
  name  = var.container_name
  image = var.image

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  networks_advanced {
    name = var.network_name
  }

  command = ["sleep", "3600"]
}
