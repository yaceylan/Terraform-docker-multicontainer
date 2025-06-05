variable "nginx_image" {
  type        = string
  default     = "nginx:latest"
  description = "Docker Image für NGINX"
}

variable "app_image" {
  type        = string
  default     = "hashicorp/http-echo"
  description = "Docker Image für die App"
}

variable "nginx_ports" {
  type        = list(number)
  default     = [8080]
  description = "Liste der Ports für NGINX"
}

variable "enable_volume" {
  type        = bool
  default     = true
  description = "Volume für die App aktivieren?"
}

variable "project_name" {
  type        = string
  default     = "demoapp"
  description = "Basisname für Netzwerk, Container usw."
}
