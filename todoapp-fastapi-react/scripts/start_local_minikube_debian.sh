#!/bin/bash

# check if docker is installed
if ! [ -x "$(command -v docker)" ]; then
    echo "Docker is not installed. Installing..."
    apt -y update
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    sudo chown $USER /var/run/docker.sock
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo rm get-docker.sh
    echo "Docker installed."
else
    echo "Docker is already installed."
fi

# Check if kubectl is installed
if ! [ -x "$(command -v kubectl)" ]; then
  echo "kubectl is not installed. Installing..."
  apt -y update
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
  echo "kubectl has been installed."
else
  echo "kubectl is already installed."
fi

# Check if kubectx is installed
if ! [ -x "$(command -v kubectx)" ]; then
  echo "kubectx is not installed. Installing..."
  apt -y update
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
  echo "kubectl has been installed."
else
  echo "kubectx is already installed."
fi

# Check if Minikube is installed
if ! [ -x "$(command -v minikube)" ]; then
  echo "Minikube is not installed. Installing..."
  apt -y update
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  sudo mv minikube /usr/local/bin/
  echo "Minikube has been installed."
else
  echo "Minikube is already installed."
fi

# start minikube (if not already started)
if minikube status >/dev/null 2>&1; then
    echo "Minikube is already running"
    exit 0
fi

# minikube static ip
export MINIKUBE_IP="192.168.49.2"

minikube start --addons=ingress --driver=docker --static-ip=$MINIKUBE_IP --force

eval $(minikube docker-env)

# set up ingress and hosts
if ! grep -q "taskapp.acme.com" /etc/hosts; then
    export HOST_NAME="taskapp.acme.com"
    echo "$MINIKUBE_IP $HOST_NAME" | sudo tee -a /etc/hosts
fi

if ! grep -q "api.taskapp.acme.com" /etc/hosts; then
    export API_HOST_NAME="api.taskapp.acme.com"
    echo "$MINIKUBE_IP $API_HOST_NAME" | sudo tee -a /etc/hosts
fi
