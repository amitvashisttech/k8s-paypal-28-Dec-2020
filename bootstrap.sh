#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.100 loadbalancer.example.com  loadbalancer
172.16.16.101 kmaster1.example.com kmaster1
172.16.16.102 kmaster2.example.com kmaster2
172.16.16.103 kmaster3.example.com kmaster3
172.16.16.201 kworker1.example.com kworker1
172.16.16.202 kworker1.example.com kworker1
EOF


# Install docker from Docker-ce repository
echo "[TASK 2] Install docker container engine"
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')


# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

# Disable SELinux
#echo "[TASK 4] Disable SELinux"
#setenforce 0
#sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "[TASK 5] Stop and Disable firewalld"
#systemctl disable firewalld >/dev/null 2>&1
#systemctl stop firewalld
ufw disable

# Add sysctl settings
echo "[TASK 6] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "[TASK 7] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add yum repo file for Kubernetes
echo "[TASK 8] Add APT repo file for kubernetes"
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF


# Install Kubernetes
echo "[TASK 9] Install Kubernetes (kubeadm, kubelet and kubectl)"
apt-get update >/dev/null 2>&1
apt-get install -y kubeadm=1.19.2-00 kubelet=1.19.2-00 kubectl=1.19.2-00 >/dev/null 2>&1


# Start and Enable kubelet service
echo "[TASK 10] Enable and start kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 12] Set root password"
echo root:kubeadmin | /usr/sbin/chpasswd >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
