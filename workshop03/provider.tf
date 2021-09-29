terraform {
  required_version=">=1.0.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.12.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
  backend "s3" {
    endpoint                    = "sgp1.digitaloceanspaces.com"
    key                         = "workshop03/terraform.tfstate"
    bucket                      = "terraformstate2909"
    region                      = "sgp1"
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
  }
}

provider "digitalocean" {
  token = var.DO_token
}
