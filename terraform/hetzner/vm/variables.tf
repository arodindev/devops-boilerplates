variable "hcloud_token" {
}

variable "ssh_pub_file" {
}

variable "ssh_username" {
  default = "root"
}

variable "location" {
  default = "nbg1"
}

variable "http_protocol" {
  default = "http"
}

variable "http_port" {
  default = "80"
}

variable "instances" {
  default = "1"
}

variable "server_type" {
  default = "cx31"
}

variable "image" {
  default = "ubuntu-22.04"
}

variable "disk_size" {
  default = "20"
}

variable "ip_range" {
  default = "10.0.1.0/24"
}