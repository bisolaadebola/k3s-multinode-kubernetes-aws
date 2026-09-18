#!/bin/bash

# K3s Master Node Installation
# Installs K3s server on the master node

set -e

echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing K3s on the master node..."
curl -sfL https://get.k3s.io | sh -

echo "Enabling K3s service..."
sudo systemctl enable k3s
sudo systemctl start k3s

echo "Checking K3s service..."
sudo systemctl status k3s --no-pager

echo "K3s master installation completed."

echo "Cluster nodes:"
sudo kubectl get nodes

echo ""
echo "Retrieve the worker node token with:"
echo "sudo cat /var/lib/rancher/k3s/server/node-token"