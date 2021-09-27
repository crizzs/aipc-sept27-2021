variable dov_bear {
  type = object({
	image_name = string
	container_port = number
  })
}


variable instances {
   type = number
   default = 5
}

variable base_external_port {
   type = number
   default = 8080
}


resource docker_image fortune {
   name = var.dov_bear.image_name
}


resource docker_container fortune {
   count = var.instances
   name = "f${count.index}"
   image = docker_image.fortune.latest
   ports {
       internal = var.dov_bear.container_port
       external = var.base_external_port + count.index
   }

}
