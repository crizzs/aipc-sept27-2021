variable DO_token {
 type = string
 sensitive = true
}

data digitalocean_ssh_key aipc-sept27 {
 name = "test-machine"
}

resource digitalocean_droplet myserver {
 name = "myserver"
 image = "ubuntu-21-04-x64"
 size = "s-1vcpu-2gb"
 region = "sgp1"

 ssh_keys = [data.digitalocean_ssh_key.aipc-sept27.id]

}

output myserver_ip {
    value = digitalocean_droplet.myserver.ipv4_address
}
