# use hetzner cloud provider with specified api token
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.45.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}