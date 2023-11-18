resource "openstack_compute_instance_v2" "my_openstack_instance" {
  name            = "dstoecklein_tf"
  image_id        = "7eefd82f-4a4e-4b21-b9c7-3f8d26dbc3f1"
  flavor_name     = "m1.small"
  key_pair        = "dstoecklein"
  security_groups = ["default"]

  network {
    name = "cloud23"
  }
}


resource "openstack_compute_floatingip_v2" "my_ip" {
  pool = "DHBW"
}


resource "openstack_compute_floatingip_associate_v2" "my_ip" {
  floating_ip = openstack_compute_floatingip_v2.my_ip.address
  instance_id = openstack_compute_instance_v2.my_openstack_instance.id
}

/*
resource "local_file" "ipfile" {
  content  = openstack_compute_floatingip_v2.my_ip.address
  filename = "${path.module}/ipfile.txt"
}
*/

# generate hosts file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      vm_ips = openstack_compute_floatingip_v2.my_ip.address
    }
  )
  filename = ".${path.module}/hosts.cfg"
}