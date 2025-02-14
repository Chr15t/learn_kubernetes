#!/bin/sh
# Load the overlay module
sudo modprobe overlay

# Load the br_netfilter module
sudo modprobe br_netfilter

# Persist module loading on boot
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Configure sysctl settings for Kubernetes networking
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

# Apply sysctl settings
sudo sysctl --system

# Add Docker's official GPG key and repository
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt-get update

# Install containerd
sudo apt-get install -y containerd.io

# Generate default containerd configuration file
sudo containerd config default | sudo tee /etc/containerd/config.toml 

# Edit the configuration file to set `SystemdCgroup = true`
# Path: /etc/containerd/config.toml


# restart service 
systemctl restart containerd

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Prevent the installed versions from being automatically upgraded
sudo apt-mark hold kubelet kubeadm kubectl


sudo systemctl enable kubelet.service
sudo systemctl enable containerd.service

# Download the Calico network plugin configuration file for pod networking
wget https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml

# Edit the Calico configuration file
vi calico.yaml


# Search for CALICO_IPV4POOL_CIDR and change the default network if needed


# Disable swap memory to ensure kubelet works properly
sudo swappoff -a 

# Enable IP forwarding for networking between pods
echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward


# Configure sysctl settings for networking
# Uncomment the following line in /etc/sysctl.conf to enable IP forwarding
# net.ipv4.ip_forward=1 


# Initialize the Kubernetes control plane
sudo kubeadm init

