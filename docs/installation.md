# K3s Kubernetes Cluster Installation

## Overview

This project involved deploying a multi-node Kubernetes cluster using K3s on AWS EC2.

The final cluster consists of:

* 1 K3s Master Node
* 3 K3s Worker Nodes
* Ubuntu Linux
* Flannel networking
* Local Path Provisioner
* Portainer for cluster management

## 1. Prepare the EC2 Instances

Four Ubuntu EC2 instances were created for the Kubernetes cluster:

* MasterNode
* WorkerNode1
* WorkerNode2
* WorkerNode3

The nodes were configured within the same AWS network to allow private communication between them.

## 2. Install K3s on the Master

K3s was installed on the master node using the K3s installation script:

```bash
curl -sfL https://get.k3s.io | sh -
```

The K3s service was verified with:

```bash
sudo systemctl status k3s
```

The cluster was then checked using:

```bash
sudo kubectl get nodes
```

## 3. Retrieve the K3s Node Token

The K3s node token was retrieved from the master so the worker nodes could authenticate and join the cluster:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

The token was kept private and was not included in the GitHub repository.

## 4. Join the Worker Nodes

Each worker node was configured to connect to the K3s master using the master's private IP address and the K3s node token.

The master node used during the deployment had the private IP:

```text
10.0.0.6
```

The K3s API server uses port `6443`.

The workers were joined using:

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://10.0.0.6:6443 K3S_TOKEN=<NODE_TOKEN> sh -
```

This process was completed for all three worker nodes.

## 5. Verify the Cluster

After joining the workers, the cluster was verified from the master:

```bash
sudo kubectl get nodes
```

The completed cluster contained:

```text
MasterNode
WorkerNode1
WorkerNode2
WorkerNode3
```

All nodes were successfully added to the cluster and reported a `Ready` status.

## 6. Verify Kubernetes Components

The Kubernetes workloads and services were checked using:

```bash
sudo kubectl get pods -A
```

```bash
sudo kubectl get svc -A
```

The cluster networking and routing were also inspected using:

```bash
sudo ip route
```

K3s uses Flannel for pod networking and the Local Path Provisioner for local storage.

## 7. Configure Portainer

Portainer was configured as the graphical management interface for the Kubernetes cluster.

It was used to view and manage Kubernetes resources, including nodes, pods, workloads, and storage.

## Final Result

The completed environment consisted of:

**1 Master Node + 3 Worker Nodes + Portainer**

This project provided hands-on experience with K3s installation, Kubernetes node configuration, networking, storage, cluster verification, and Kubernetes management.
