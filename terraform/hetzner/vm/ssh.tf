resource "hcloud_ssh_key" "myvm-ssh" {
  name       = "myvm-ssh"
  public_key = file(var.ssh_pub_file)
}