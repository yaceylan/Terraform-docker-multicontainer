variable "nginx_image" {
  type    = string
  default = "nginx:latest"
}

variable "app_image" {
  type    = string
  default = "python:3.11-slim"
}
