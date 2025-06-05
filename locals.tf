locals {
  network_name = "${var.project_name}-net"
  nginx_container_name = "${var.project_name}-nginx"
  app_container_name   = "${var.project_name}-app"
}
