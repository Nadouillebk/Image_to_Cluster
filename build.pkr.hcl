packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "nginx_custom" {
  image  = "nginx:latest"
  commit = true
}

build {
  sources = ["source.docker.nginx_custom"]

  # Injection de ton fichier local index.html dans l'image
  provisioner "file" {
    source      = "index.html"
    destination = "/usr/share/nginx/html/index.html"
  }

  post-processor "docker-tag" {
    repository = "my-custom-nginx"
    tags       = ["latest"]
  }
}
