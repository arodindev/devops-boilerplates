# Chaos Mesh

Run chaos experiments against the sample [todoapp](https://github.com/arodindev/todoapp)

## Getting Started

Spin up a minikube cluster as described [here](https://github.com/arodindev/devops-boilerplates/tree/main/kubernetes)

Install Chaos Mesh

```bash
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm repo update
helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-testing --create-namespace
```

Create chaos-testing namespace

```bash
kubectl apply -f namespace.yaml
```

## Run Experiments

- `singleshot` experiments are running once
- `scheduled` experiments are running on timed cronjob
- `workflows` experiments are running as a series of experiments
- `chaos-studio` experiments are Chaos-Mesh definitions for Azure Chaos Studio

Simply apply the manifests with kubectl and observe the behaviour of the todoapp.

```bash
kubectl apply -f <EXPERIMENT.yaml>
```