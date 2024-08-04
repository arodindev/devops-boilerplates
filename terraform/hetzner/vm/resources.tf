# create a hetzner server (vm) with name 'myvm'
resource "hcloud_server" "myvm" {
  count       = var.instances
  name        = "myvm"
  image       = var.image
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.myvm-ssh.id]
  labels = {
    type = "myvm"
  }
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

# create a volume for the server
resource "hcloud_volume" "myvm-volume" {
  count    = var.instances
  name     = "myvm-volume"
  size     = var.disk_size
  location = var.location
  format   = "xfs"
}

# attach volume to server
resource "hcloud_volume_attachment" "myvm-volume-attachment" {
  count     = var.instances
  volume_id = hcloud_volume.myvm-volume[count.index].id
  server_id = hcloud_server.myvm[count.index].id
  automount = true
}

# network setup
resource "hcloud_network" "hc-private" {
  name     = "hc-private"
  ip_range = var.ip_range
}

resource "hcloud_server_network" "myvm-network" {
  count     = var.instances
  server_id = hcloud_server.myvm[count.index].id
  subnet_id = hcloud_network_subnet.hc-private-subnet.id
}

resource "hcloud_network_subnet" "hc-private-subnet" {
  network_id   = hcloud_network.hc-private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.ip_range
}

# generate hosts file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      vm_ips = hcloud_server.myvm.*.ipv4_address
    }
  )
  filename = "${path.module}/hosts.cfg"
}