variable DO_token {
  type = string
  default = env("DO_TOKEN")
  sensitive = true
}

variable DO_region {
  type = string
  default = "sgp1"
}

variable DO_size {
  type = string
  default = "s-1vcpu-1gb"
}

variable DO_image {
  type = string
  default = "ubuntu-20-04-x64"
}

variable MYSQL_root_password {
  type = string
  sensitive = true
}

source digitalocean mysql8_image {
  api_token = var.DO_token
  region = var.DO_region
  size = var.DO_size
  image = var.DO_image
  snapshot_name = "mysql8"
  ssh_username = "root"
}


build {
  sources = ["source.digitalocean.mysql8_image"]
  provisioner ansible {
    playbook_file = "./playbook.yaml"
    extra_arguments = ["-e", "mysql_root_password=${var.MYSQL_root_password}"]
  }

}
