#!/usr/bin/env bash

echo "Install Docker"
apt-get update && apt install -y docker.io apt-transport-https curl&& systemctl enable docker


echo "Install kubeadm"
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF


apt-get update && apt-get install -y  kubeadm


echo "Init Cluster"
swapoff /swapfile   && sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# use Flannel as pod network plugin
kubeadm init --pod-network-cidr=10.244.0.0/16  --image-repository gcr.akscn.io/google_containers

echo "Configure kubeconfig"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config


echo "disable master node isolate"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "Install Network Plugin"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "Config Ingress"

kubectl apply -f https://raw.githubusercontent.com/shawnliujw/spring-boot-kubernetes/master/kubernetes/ingress-default-backend.yaml
kubectl apply -f https://raw.githubusercontent.com/shawnliujw/spring-boot-kubernetes/master/kubernetes/ingress-daemo.yaml
kubectl apply -f https://raw.githubusercontent.com/shawnliujw/spring-boot-kubernetes/master/kubernetes/ingress.yaml

echo "Configure Dashboard"

kubectl apply -f https://raw.githubusercontent.com/shawnliujw/spring-boot-kubernetes/master/kubeadm/kubernetes-dashboard.yaml

kubectl apply -f https://raw.githubusercontent.com/shawnliujw/spring-boot-kubernetes/master/kubeadm/admin-role.yaml



echo "Print Access Token"

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret|grep admin-token | awk '{print $1}')

echo "Done"