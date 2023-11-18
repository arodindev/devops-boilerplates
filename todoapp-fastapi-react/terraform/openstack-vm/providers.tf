# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "openstack" {
  user_name   = "dpfisterer-bigdata"
  password    = "bd22"
  domain_name = "default"
  tenant_id   = "63998599b8d44243a8ed2c995f64b8e5"
  auth_url    = "https://cloud.4c.dhbw-mannheim.de:5000"
}