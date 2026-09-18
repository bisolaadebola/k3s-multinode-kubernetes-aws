# K3s Multi-Node Kubernetes Cluster on AWS

![AWS](https://img.shields.io/badge/AWS-EC2-orange)
![Ubuntu](https://img.shields.io/badge/OS-Ubuntu-orange)
![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-blue)
![Portainer](https://img.shields.io/badge/Management-Portainer-13BEF9)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-black)
![DevOps](https://img.shields.io/badge/Focus-DevOps-blueviolet)

## 📌 Project Overview

This project demonstrates the deployment and configuration of a **multi-node Kubernetes cluster using K3s on AWS EC2**.

The cluster was built using **one K3s server/control-plane node and three worker/agent nodes running Ubuntu Linux**. Portainer was also configured to provide a graphical interface for managing the Kubernetes environment.

This hands-on project was completed as part of my Cloud and DevOps learning journey, with a focus on gaining practical experience in:

* AWS infrastructure
* Linux administration
* Kubernetes
* K3s
* Networking
* Container orchestration
* Portainer
* Troubleshooting
* Git and GitHub
* Technical documentation

---

# 🏗️ Architecture

```text
                         AWS
                          │
                    ┌─────┴─────┐
                    │    VPC    │
                    │           │
                    │ ┌────────┐│
                    │ │ K3s    ││
                    │ │ Server  ││
                    │ │MasterNode│
                    │ └────┬───┘│
                    │      │    │
              ┌─────┴──────┼────┴─────┐
              │            │           │
              ▼            ▼           ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │ Worker 1 │ │ Worker 2 │ │ Worker 3 │
        │   K3s    │ │   K3s    │ │   K3s    │
        └──────────┘ └──────────┘ └──────────┘
              │            │           │
              └────────────┼───────────┘
                           │
                           ▼
                    ┌────────────┐
                    │ Portainer  │
                    │  Cluster   │
                    │ Management │
                    └────────────┘
```

### Cluster Topology

| Node        | Role                       | Platform         |
| ----------- | -------------------------- | ---------------- |
| MasterNode  | K3s Server / Control Plane | AWS EC2 / Ubuntu |
| WorkerNode1 | K3s Agent / Worker         | AWS EC2 / Ubuntu |
| WorkerNode2 | K3s Agent / Worker         | AWS EC2 / Ubuntu |
| WorkerNode3 | K3s Agent / Worker         | AWS EC2 / Ubuntu |

---

# ☁️ AWS Infrastructure

The Kubernetes cluster was deployed on **Amazon EC2** using Ubuntu Linux instances.

### Infrastructure Components

* Amazon EC2
* AWS VPC
* Security Groups
* Private IP networking
* Ubuntu Linux
* K3s Kubernetes

The EC2 instances communicate using their private IP addresses within the AWS network.

The Kubernetes API server uses **TCP port 6443** for communication between the K3s server and worker nodes.

Security Group rules were configured to allow the required communication between the cluster nodes.

---

# 🛠️ Technologies Used

### Cloud

* AWS
* Amazon EC2
* Amazon VPC
* AWS Security Groups

### Operating System

* Ubuntu Linux
* Bash

### Kubernetes

* Kubernetes
* K3s
* kubectl
* containerd
* Flannel/CNI

### Cluster Management

* Portainer Community Edition

### DevOps Tools

* Git
* GitHub
* Linux CLI
* SSH

---

# 🎯 Project Objectives

The main objectives of this project were to:

1. Provision multiple Ubuntu EC2 instances on AWS.
2. Configure a K3s server/control-plane node.
3. Configure three K3s worker/agent nodes.
4. Connect the worker nodes to the K3s server.
5. Configure AWS networking and Security Groups.
6. Understand Kubernetes node communication.
7. Validate the Kubernetes cluster using `kubectl`.
8. Manage the cluster using Portainer.
9. Troubleshoot Kubernetes connectivity and authentication issues.
10. Document the complete deployment process.

---

# 🚀 K3s Installation

## 1. Install K3s on the Server

K3s was installed on the master/control-plane node using the official installation script.

```bash
curl -sfL https://get.k3s.io | sh -
```

After installation, the K3s service was verified:

```bash
sudo systemctl status k3s
```

The Kubernetes cluster was then checked:

```bash
sudo kubectl get nodes
```

---

# 🔐 2. Retrieve the K3s Node Token

The K3s server generates a token used to authenticate worker nodes joining the cluster.

The token can be retrieved from:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```


---

# 👷 3. Join the Worker Nodes

Each worker node was configured as a K3s agent and connected to the K3s server.

The general installation command is:

```bash
curl -sfL https://get.k3s.io | \
K3S_URL=https://<MASTER_PRIVATE_IP>:6443 \
K3S_TOKEN=<NODE_TOKEN> \
sh -
```

The actual master private IP and node token are intentionally excluded from this documentation.

After installation, the worker service can be checked using:

```bash
sudo systemctl status k3s-agent
```

---

# ✅ 4. Verify the Kubernetes Cluster

Once all three workers joined the cluster, the nodes were verified from the master node.

```bash
sudo kubectl get nodes
```

The expected cluster structure is:

```text
NAME           STATUS   ROLES
MasterNode     Ready    control-plane,master
WorkerNode1    Ready    <none>
WorkerNode2    Ready    <none>
WorkerNode3    Ready    <none>
```

The `Ready` status confirms that the nodes successfully registered with the Kubernetes cluster.

---

# 🔍 Cluster Validation

Several Kubernetes commands were used to inspect and validate the cluster.

### Check Nodes

```bash
sudo kubectl get nodes
```

### Detailed Node Information

```bash
sudo kubectl get nodes -o wide
```

### Check Pods

```bash
sudo kubectl get pods -A
```

### Check Services

```bash
sudo kubectl get services -A
```

### Check Persistent Volume Claims

```bash
sudo kubectl get pvc -A
```

### Check Cluster Information

```bash
sudo kubectl cluster-info
```

### Check Kubernetes Events

```bash
sudo kubectl get events -A
```

---

# 🌐 Kubernetes Networking

K3s uses **Flannel** as its default Container Network Interface (CNI).

During troubleshooting, Linux networking and Kubernetes networking were inspected to understand communication between:

* AWS EC2 instances
* K3s server
* K3s agents
* Kubernetes API server
* Pod networks
* Kubernetes services

Useful Linux commands included:

```bash
ip addr
```

```bash
ip route
```

```bash
ping <PRIVATE_IP>
```

```bash
curl <API_ENDPOINT>
```

---

# 🖥️ Portainer Cluster Management

**Portainer Community Edition** was configured to provide a graphical interface for managing the Kubernetes environment.

The Portainer interface provides visibility into the Kubernetes cluster and its resources.

The final cluster contains:

```text
Portainer
    │
    └── Kubernetes Environment
           │
           ├── MasterNode
           ├── WorkerNode1
           ├── WorkerNode2
           └── WorkerNode3
```

Portainer was used to inspect and manage the Kubernetes environment through a web-based interface.

### Portainer Resources

The environment can be used to inspect Kubernetes resources such as:

* Nodes
* Namespaces
* Pods
* Workloads
* Services
* Persistent Volumes
* Persistent Volume Claims

---

# 🐛 Challenges and Troubleshooting

This project involved several real-world troubleshooting scenarios.

## 1. Worker Node `401 Unauthorized`

During the initial worker-node registration, a worker returned:

```text
401 Unauthorized
```

The issue required checking several layers of the environment:

* Master private IP address
* K3s API server
* Port 6443 connectivity
* K3s node token
* Worker configuration
* AWS Security Group rules
* K3s service status

This provided hands-on experience troubleshooting Kubernetes authentication and node registration.

---

## 2. Kubernetes API Connectivity

Connectivity to the Kubernetes API server was investigated during the cluster setup.

The Kubernetes API server operates on:

```text
TCP 6443
```

Linux routing information was inspected using:

```bash
sudo ip route
```

The API endpoint was also tested to determine whether the issue was related to networking or Kubernetes itself.

---

## 3. Flannel / CNI Networking

K3s networking was investigated when validating communication between nodes and Kubernetes workloads.

This included inspecting Linux routes and Kubernetes networking components.

The troubleshooting process helped demonstrate how Kubernetes networking depends on multiple layers working together.

---

## 4. Local Path Storage

The K3s local-path storage provisioner was also investigated while configuring Portainer.

This introduced practical experience with:

* StorageClasses
* PersistentVolumeClaims
* Persistent Volumes
* Pod scheduling
* `WaitForFirstConsumer`
* Local storage

---

## 5. Portainer Deployment and Timeout

During the Portainer setup, the Portainer interface displayed a timeout/security message.

The deployment was investigated by checking Kubernetes resources, pods, PVCs, and events.

Useful commands included:

```bash
sudo kubectl get pods -A
```

```bash
sudo kubectl get pvc -A
```

```bash
sudo kubectl get events -A
```

This provided additional hands-on experience troubleshooting Kubernetes applications and storage dependencies.

---

# 🧰 Troubleshooting Commands

### Linux Networking

```bash
ip addr
ip route
ping <PRIVATE_IP>
curl <ENDPOINT>
```

### K3s

```bash
sudo systemctl status k3s
sudo journalctl -u k3s
sudo journalctl -u k3s -f
```

### K3s Worker

```bash
sudo systemctl status k3s-agent
sudo journalctl -u k3s-agent
```

### Kubernetes

```bash
sudo kubectl get nodes
sudo kubectl get pods -A
sudo kubectl get svc -A
sudo kubectl get pvc -A
sudo kubectl get events -A
sudo kubectl cluster-info
```

---

# 📚 Key Skills Demonstrated

Through this project, I gained practical experience with:

* AWS EC2
* AWS VPC
* AWS Security Groups
* Ubuntu Linux
* Linux networking
* Kubernetes fundamentals
* K3s
* Kubernetes cluster installation
* Kubernetes node management
* Kubernetes networking
* Flannel/CNI
* Kubernetes storage
* Portainer
* Bash
* Git
* GitHub
* Troubleshooting
* Technical documentation

---

# 💡 Lessons Learned

### Networking Is Fundamental

Understanding private IP addresses, routing, ports, and Security Groups was essential when connecting the K3s server and worker nodes.

### Authentication Matters

K3s worker nodes require valid authentication when joining the cluster. A `401 Unauthorized` response can indicate a problem with the node token or server configuration.

### Troubleshooting Requires a Layered Approach

The troubleshooting process followed a layered approach:

```text
AWS Infrastructure
       ↓
Network / Security Groups
       ↓
Linux
       ↓
K3s
       ↓
Kubernetes
       ↓
Pods / Services
       ↓
Application
```

This approach helped isolate problems instead of treating the entire cluster as one system.

### Kubernetes Storage Can Affect Application Deployment

Portainer's deployment exposed the relationship between workloads, PersistentVolumeClaims, StorageClasses, and pod scheduling.

# 📁 Project Documentation

Detailed documentation will be maintained in the `docs/` directory.

```text
docs/
├── architecture.md
├── aws-infrastructure.md
├── k3s-installation.md
├── cluster-management.md
├── portainer.md
├── troubleshooting.md
└── challenges-and-lessons.md
```

---

# 🚀 Future Improvements

Future improvements to this project may include:

* Deploying multiple K3s server/control-plane nodes for control-plane high availability.
* Automating AWS infrastructure with Terraform.
* Automating K3s installation with Ansible.
* Adding GitHub Actions CI/CD.
* Deploying sample applications to the Kubernetes cluster.
* Configuring Kubernetes Ingress.
* Implementing monitoring and observability.
* Exploring production-oriented persistent storage.
* Strengthening network security and access controls.

---

# 🎓 Project Outcome

The completed project resulted in a functioning **four-node K3s Kubernetes environment on AWS**, consisting of:

```text
1 × K3s Server / Control Plane
3 × K3s Worker / Agent Nodes
1 × Portainer Management Interface
```

The project provided hands-on experience deploying, connecting, validating, managing, and troubleshooting a Kubernetes cluster in an AWS environment.

---

# 👩🏽‍💻 Author

**Bisola Adebola**

Cloud & DevOps Engineer 

**Skills:** AWS | Linux | Kubernetes | K3s | Docker | CI/CD | Cloud Infrastructure

**GitHub:**
https://github.com/bisolaadebola

**LinkedIn:**
https://linkedin.com/in/bisolaadebola-acipm

---

# 🔗 References

* K3s Documentation — https://docs.k3s.io/
* K3s Architecture — https://docs.k3s.io/architecture
* K3s Quick Start — https://docs.k3s.io/quick-start
* K3s Tokens — https://docs.k3s.io/cli/token
* K3s GitHub — https://github.com/k3s-io/k3s
* Kubernetes Documentation — https://kubernetes.io/docs/
* Portainer Documentation — https://docs.portainer.io/

