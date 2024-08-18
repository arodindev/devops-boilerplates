# Todoapp

Deployment of sample Todo-App on Kubernetes. Istio must be installed on the cluster.

* Source Code: https://github.com/arodindev/todoapp

## Getting Started

```bash
kubectl apply -k ./todoapp
kubectl apply -k ./argocd
kubectl apply -k ./cert-manager
```

```bash
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80
```

```bash
curl -H "Host: todoapp.arodindev.com" http://localhost:8080/api/v1/healthz
```

## GitOps

You can apply these [GitOps](https://github.com/arodindev/gitops-boilerplates) manifests to sync changes to this repo. with your cluster.

## Monitoring

```bash
kubectl port-forward -n todoapp svc/grafana 3000:3000
```

