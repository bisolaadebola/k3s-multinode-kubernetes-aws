# K3s Kubernetes Troubleshooting

## Overview

During the K3s cluster deployment, I encountered issues involving worker authentication, networking, storage, and Portainer.

## Worker Node Authentication — 401 Unauthorized

### Problem

A worker node initially returned a `401 Unauthorized` error when attempting to join the K3s master.

### Troubleshooting

I verified the master private IP, K3s API endpoint, node token, and network connectivity.

### Resolution

The worker configuration and authentication details were corrected, allowing the worker to successfully join the cluster.

## Kubernetes Networking

### Problem

Some connectivity tests to Kubernetes services and the API server experienced timeouts.

### Troubleshooting

I used `ip route`, Kubernetes service information, and cluster status commands to investigate the network configuration.

### Resolution

The issue was investigated by reviewing the different AWS, node, pod, and Kubernetes service network ranges.

## Local Path Provisioner

### Problem

The K3s Local Path Provisioner entered a `CrashLoopBackOff` state, affecting local storage provisioning.

### Troubleshooting

I checked pod status, logs, events, and the `local-path` StorageClass.

### Lesson

This demonstrated the dependency between Kubernetes workloads, PersistentVolumeClaims, StorageClasses, and storage provisioners.

## Portainer PVC

### Problem

The Portainer PersistentVolumeClaim remained in a `Pending` state.

### Troubleshooting

I reviewed the PVC, StorageClass, pod status, and Kubernetes events to identify the volume-binding issue.

## Portainer Security Timeout

### Problem

Portainer displayed a security timeout message and required the installation to be re-enabled.

### Troubleshooting

I reviewed the Portainer installation and access configuration before continuing with the setup.

## Final Outcome

After troubleshooting the deployment issues, all three worker nodes were successfully added to the K3s master, completing the multi-node cluster setup.
