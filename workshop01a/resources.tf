variable DO_token {
  type = string
  sensitive = true
}

data digitalocean_ssh_key aipc {
  name = "test-machine"
}


variable DO_image {
  type = string
  default = "ubuntu-20-04-x64"
}

variable DO_region {
  type = string
  default = "sgp1"
}

variable DO_size {
  type = string
  default = "s-1vcpu-1gb"
}


resource "digitalocean_droplet" "my-droplet" {
  name = "my-droplet"
  region = var.DO_region
  size = var.DO_size
  image = var.DO_image
  ssh_keys = [data.digitalocean_ssh_key.aipc.id]

  connection {
     type = "ssh"
     user = "root"
     host =  self.ipv4_address
     private_key = file("../keys/mykey")
  }
  
  provisioner "remote-exec" {
    inline = [
        "sudo apt update", 
        "sudo apt install -y nginx",
        "sudo systemctl enable nginx",
        "sudo systemctl start nginx"
    ]
  }
}

resource "local_file" "root_at_ip" {
 filename = "root@${digitalocean_droplet.my-droplet.ipv4_address}"
 file_permission="0444"

}


output droplet_ipv4 {
  value = digitalocean_droplet.my-droplet.ipv4_address
}

output droplet_ipv4_private {
  value = digitalocean_droplet.my-droplet.ipv4_address_private
}
