Generate Keygen

```bash
ssh-keygen
chmod 600 ~/.ssh/<FILE> && chmod 600 ~/.ssh/<FILE>.pub
```

Create VM

```bash
terraform init
terraform apply -var "hcloud_token=$HETZNER_TOKEN" -var "ssh_pub_file=~/.ssh/FILE.pub"
```

SSH to VM

```bash
ssh root@<VM-IP>
```