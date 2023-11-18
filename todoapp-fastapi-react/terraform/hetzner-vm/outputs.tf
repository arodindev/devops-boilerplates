output "taskapp_servers_status" {
  value = {
    for server in hcloud_server.taskapp :
    server.name => server.status
  }
}

output "taskapp_servers_ips" {
  value = {
    for server in hcloud_server.taskapp :
    server.name => server.ipv4_address
  }
}