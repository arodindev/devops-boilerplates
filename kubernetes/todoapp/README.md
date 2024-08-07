# Todoapp

Deployment of sample Todo-App to Kubernetes. Istio must be installed on the cluster.

* App: https://github.com/arodindev/todoapp

## Getting Started

```bash
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80
```

```bash
curl -H "Host: todoapp.acme.com" http://localhost:8080/api/v1/healthz
```

## Monitoring

These are the Istio template dashboards: https://istio.io/latest/docs/tasks/observability/metrics/using-istio-dashboard/

```bash
kubectl port-forward -n todoapp svc/grafana 3000:3000
```

http://localhost:3000