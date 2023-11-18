resource "hcloud_ssh_key" "hetzner-cloud-native" {
  name       = "hetzner-cloud-native"
  public_key = file(var.ssh_pub_file)
}