data "digitalocean_droplet_snapshot" "mysql8_snapshot" {
  name_regex  = "^mysql8"
  region      = "sgp1"
  most_recent = true
}

data digitalocean_ssh_key aipc {
  name = "test-machine"
}

variable DO_token {
  type = string
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

resource "local_file" "root_at_ip" {
 filename = "root@${digitalocean_droplet.mysql8_droplet.ipv4_address}"
 file_permission="0444"
}

resource "digitalocean_droplet" "mysql8_droplet" {
  name = "mysql8-droplet"
  region = var.DO_region
  size = var.DO_size
  image  = data.digitalocean_droplet_snapshot.mysql8_snapshot.id
  ssh_keys = [data.digitalocean_ssh_key.aipc.id]

}

output droplet_ipv4 {
    value = digitalocean_droplet.mysql8_droplet.ipv4_address
}
  
