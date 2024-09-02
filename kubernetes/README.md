# Todoapp

Deployment of sample Todo-App on Kubernetes. Istio must be installed on the cluster.

* Source Code: https://github.com/arodindev/todoapp

## Getting Started

Start Minikube

```bash
minikube start --cpus 4 --memory 8192 --driver=docker --container-runtime=docker
istioctl install
```

Deploy apps

```bash
kubectl apply -k ./todoapp
```

Create self-signed certificate

```bash
cd ../ansible/create-self-signed-certificate
ansible-playbook -c local -i inventory.ini playbook.yaml -K
```

Create secret

```bash
sudo -E env "PATH=$PATH" kubectl -n istio-system create secret tls tls-secret --cert=/etc/ssl/crt/todoapp.arodindev.com.crt --key=/etc/ssl/private/privkey.pem
```

Establish Minikube tunnel

```bash
minikube tunnel --cleanup
```

Get external-ip

```bash
kubectl get svc istio-ingressgateway -n istio-system
```

Add entry to `etc/hosts`

```bash
<MINIKUBE-EXTERNAL-IP>    todoapp.arodindev.com
```

Test connection

```bash
curl -k https://todoapp.arodindev.com/api/v1/healthz
```

```bash
{"name":"todoapp","status":"OK"}
```

## Monitoring

```bash
kubectl port-forward -n todoapp svc/grafana 3000:3000
```

## ArgoCD for GitOps

Install ArgoCD

```bash
kubectl apply -k ./argocd
```

Access ArgoCD dashboard

```bash
kubectl port-forward -n argocd svc/argocd-server 8080:80
```

Retrieve ArgoCD password

```bash
kubectl get secrets -n argocd argocd-initial-admin-secret -o yaml
echo "<password>" | base64 -d
```

```bash
admin
<password>
```

Now you can apply these [GitOps](https://github.com/arodindev/gitops-boilerplates) manifests to sync changes to this repo.
