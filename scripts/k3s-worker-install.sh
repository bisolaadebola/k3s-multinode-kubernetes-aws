

# K3s Worker Node Installation
# Installs K3s agent and connects the worker to the master

set -e

MASTER_IP="${MASTER_IP:-10.0.0.6}"

if [ -z "$K3S_TOKEN" ]; then
    echo "Error: K3S_TOKEN is not set."
    echo "Run the script with your K3s token."
    exit 1
fi

echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "Connecting worker node to K3s master at ${MASTER_IP}:6443..."

curl -sfL https://get.k3s.io | \
    K3S_URL="https://${MASTER_IP}:6443" \
    K3S_TOKEN="${K3S_TOKEN}" \
    sh -

echo "Enabling K3s agent service..."
sudo systemctl enable k3s-agent
sudo systemctl start k3s-agent

echo "Checking K3s agent service..."
sudo systemctl status k3s-agent --no-pager

echo ""
echo "K3s worker installation completed."
echo "The worker should now be connected to the master."
```

### How to run the worker script

First, on the **MasterNode**, retrieve your token:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

Then, on each worker, run:

```bash
export K3S_TOKEN="YOUR_NODE_TOKEN"
```

Then:

```bash
chmod +x k3s-worker-install.sh
./k3s-worker-install.sh
```

Because your master IP is already set to `10.0.0.6` in the script, you don't need to enter it every time.

After installing each worker, return to the master and verify:

```bash
sudo kubectl get nodes
```

You should eventually have:

```text
MasterNode
WorkerNode1
WorkerNode2
WorkerNode3
```

with all nodes showing **Ready**.


