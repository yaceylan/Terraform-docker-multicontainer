terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.3.0"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
