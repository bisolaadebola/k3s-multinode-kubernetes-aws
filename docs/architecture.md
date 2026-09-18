

````markdown
# K3s Multi-Node Kubernetes Architecture on AWS

## 📌 Overview

This document describes the architecture of the multi-node K3s Kubernetes cluster deployed on Amazon Web Services (AWS).

The environment consists of four Ubuntu Linux EC2 instances:

- 1 K3s Server / Control Plane node
- 3 K3s Worker / Agent nodes
- Portainer Community Edition for Kubernetes cluster management

The purpose of the architecture is to demonstrate how multiple EC2 instances can be connected to form a Kubernetes cluster using K3s.

---

# 🏗️ Architecture Diagram

```text
                         AWS CLOUD
                             │
                    ┌────────┴────────┐
                    │       VPC       │
                    │                 │
                    │   ┌─────────┐   │
                    │   │ K3s     │   │
                    │   │ Server  │   │
                    │   │         │   │
                    │   │MasterNode│  │
                    │   └────┬────┘   │
                    │        │        │
                    │        │        │
              ┌─────┴────────┼────────┴─────┐
              │              │              │
              ▼              ▼              ▼
        ┌───────────┐  ┌───────────┐  ┌───────────┐
        │ Worker    │  │ Worker    │  │ Worker    │
        │ Node 1    │  │ Node 2    │  │ Node 3    │
        │           │  │           │  │           │
        │ K3s Agent │  │ K3s Agent │  │ K3s Agent │
        └───────────┘  └───────────┘  └───────────┘
              │              │              │
              └──────────────┼──────────────┘
                             │
                             ▼
                      ┌─────────────┐
                      │  Portainer  │
                      │ Kubernetes  │
                      │ Management  │
                      └─────────────┘
````

---

# ☁️ AWS Infrastructure Layer

The Kubernetes cluster runs on Amazon EC2 instances within an AWS networking environment.

### Components

* Amazon EC2
* AWS VPC
* Security Groups
* Private IP networking
* Ubuntu Linux

Each EC2 instance acts as a Kubernetes node.

The nodes communicate with each other over the AWS private network.

---

# 🖥️ Cluster Nodes

## MasterNode

The `MasterNode` is the K3s server/control-plane node.

Its responsibilities include:

* Running the Kubernetes API server
* Managing the Kubernetes cluster
* Maintaining cluster state
* Registering worker nodes
* Scheduling workloads
* Managing Kubernetes resources

The Kubernetes API server listens on:

```text
TCP 6443
```

Worker nodes use this API endpoint when joining and communicating with the cluster.

---

## WorkerNode1

`WorkerNode1` is configured as a K3s agent.

Its role is to provide compute capacity for Kubernetes workloads assigned by the control plane.

---

## WorkerNode2

`WorkerNode2` is configured as a K3s agent.

It provides additional capacity for running Kubernetes workloads across the cluster.

---

## WorkerNode3

`WorkerNode3` is configured as a K3s agent.

It provides the third worker node in the cluster and increases the available worker capacity.

---

# 🔗 Node Communication

The worker nodes communicate with the K3s server through the AWS private network.

The general communication flow is:

```text
Worker Node
     │
     │ HTTPS / TCP 6443
     ▼
K3s Server
     │
     ▼
Kubernetes API
```

During the installation process, each worker node uses:

* The K3s server private IP address
* The Kubernetes API port
* The K3s node authentication token

The authentication token is intentionally excluded from this documentation.

---

# 🔐 Security Groups

AWS Security Groups provide network-level access control for the EC2 instances.

The rules were configured to permit the required communication between the Kubernetes nodes.

Important traffic includes:

```text
Worker Nodes
     │
     └──────► MasterNode:6443
```

SSH access was also used for administrative access to the Ubuntu EC2 instances.

> **Security Note:** Production environments should follow the principle of least privilege and restrict access to known sources whenever possible.

---

# 🌐 Kubernetes Networking

K3s uses a Container Network Interface (CNI) to provide networking for Kubernetes workloads.

The default K3s networking configuration uses Flannel.

The cluster therefore contains multiple network layers:

```text
AWS Private Network
        │
        ▼
EC2 Node Network
        │
        ▼
K3s / Flannel Network
        │
        ▼
Kubernetes Pod Network
```

Linux routing information was inspected during troubleshooting using:

```bash
ip route
```

This helped identify routes associated with the AWS network and Kubernetes pod networking.

---

# 📦 Kubernetes Components

The K3s environment provides several Kubernetes components required for cluster operation.

Important components include:

* Kubernetes API server
* Scheduler
* Controller Manager
* Kubelet
* Container Runtime
* CoreDNS
* Flannel
* Local Path Provisioner

These components work together to manage Kubernetes workloads and networking.

---

# 🖥️ Portainer

Portainer provides a graphical interface for managing the Kubernetes environment.

The architecture can be represented as:

```text
                 Portainer
                     │
                     ▼
          Kubernetes Environment
                     │
          ┌──────────┴──────────┐
          │                     │
     K3s Server            K3s Agents
     MasterNode             │
                            ├── WorkerNode1
                            ├── WorkerNode2
                            └── WorkerNode3
```

Portainer provides visibility into Kubernetes resources including:

* Nodes
* Namespaces
* Pods
* Workloads
* Services
* Storage
* Persistent Volume Claims

---

# 💾 Storage

The K3s cluster includes the local-path storage provisioner.

This provides local storage capabilities for Kubernetes workloads.

Storage-related resources investigated during the project included:

* StorageClass
* PersistentVolume
* PersistentVolumeClaim

The local-path provisioner was also part of the troubleshooting process during the Portainer deployment.

---

# 🔄 Cluster Workflow

The overall cluster workflow is:

```text
1. AWS EC2 instances provisioned
              ↓
2. Ubuntu configured
              ↓
3. K3s installed on MasterNode
              ↓
4. K3s node token retrieved
              ↓
5. Worker nodes configured
              ↓
6. Workers join MasterNode
              ↓
7. Kubernetes nodes validated
              ↓
8. Kubernetes networking validated
              ↓
9. Portainer configured
              ↓
10. Cluster managed through Portainer
```

---

# 🔍 Cluster Validation

The cluster was validated using Kubernetes commands from the master node.

### View Nodes

```bash
sudo kubectl get nodes
```

### View Detailed Node Information

```bash
sudo kubectl get nodes -o wide
```

### View Cluster Information

```bash
sudo kubectl cluster-info
```

### View Kubernetes Pods

```bash
sudo kubectl get pods -A
```

### View Services

```bash
sudo kubectl get services -A
```

---

# 📊 Final Cluster Structure

The completed environment consists of:

```text
K3s Kubernetes Cluster
│
├── MasterNode
│   └── K3s Server / Control Plane
│
├── WorkerNode1
│   └── K3s Agent
│
├── WorkerNode2
│   └── K3s Agent
│
└── WorkerNode3
    └── K3s Agent

Portainer
└── Kubernetes Cluster Management
```

---

# 🎯 Architecture Summary

This project demonstrates a four-node Kubernetes environment running on AWS EC2 using K3s.

The architecture consists of:

```text
AWS EC2
   │
   ├── MasterNode
   │      └── K3s Server / Control Plane
   │
   ├── WorkerNode1
   │      └── K3s Agent
   │
   ├── WorkerNode2
   │      └── K3s Agent
   │
   └── WorkerNode3
          └── K3s Agent

             +
             
        Portainer
```

The project provided hands-on experience with cloud infrastructure, Linux administration, Kubernetes networking, cluster configuration, node management, storage, troubleshooting, and graphical Kubernetes management.

````

