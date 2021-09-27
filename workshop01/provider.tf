terraform {
    required_version = ">= 1.0.0"
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.15.0"
        }
    }
}

provider docker {
    host = "tcp://157.245.201.142:2376"
    cert_path = "/root/.docker/machine/machines/test-machine"
}
