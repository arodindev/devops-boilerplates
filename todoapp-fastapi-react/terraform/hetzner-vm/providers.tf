# use hetzner cloud provider with specified api token
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.42.1"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}