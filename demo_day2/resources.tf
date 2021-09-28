variable DO_token {
 type = string
 sensitive = true
}

data digitalocean_ssh_key aipc-sept27 {
 name = "test-machine"
}

resource digitalocean_droplet myserver {
 count = 1
 name = "myserver-${count.index}"
 image = "ubuntu-21-04-x64"
 size = "s-1vcpu-1gb"
 region = "sgp1"

 ssh_keys = [data.digitalocean_ssh_key.aipc-sept27.id]

}

resource local_file inventory {
 filename= "inventory.yaml"
 file_permission = "0444"
 content = templatefile("inventory.yaml.tpl",{
    droplets = digitalocean_droplet.myserver
 })
}

output ipv4 {
 value = join (",", digitalocean_droplet.myserver[*].ipv4_address)
}
