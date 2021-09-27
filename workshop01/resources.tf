resource docker_image fortune {
  name = "chukmunnlee/fortune:v2"
}

resource docker_container fortune {
    name = "f0"
    image = docker_image.fortune.latest
    ports {
        internal = 3000 
        external = 8080
    }
}
