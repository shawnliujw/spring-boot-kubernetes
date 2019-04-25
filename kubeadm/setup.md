## Setup Kubernetes Single Node Cluster By Kubeadm on Ubuntu 18.04

**Install docker**  
```
apt-get update && apt install -y docker.io && systemctl enable docker
   
   ```
    
**Install kubeadm,kubectl,kubelet**  
```
apt-get update && apt-get install -y apt-transport-https curl 

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - 

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update && apt-get install -y kubelet kubeadm kubectl && apt-mark hold kubelet kubeadm kubectl 
```  
* 如果以上无法安装，可以切换国内源  
```bash
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

apt-get update
```
**Init Cluster**  
```
swapoff /swapfile   && sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# use Flannel as pod network plugin
kubeadm init --pod-network-cidr=10.244.0.0/16  
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#disable master node isolate
kubectl taint nodes --all node-role.kubernetes.io/master-   

#copy kubeconfig to HOME

mkdir -p $HOME/.kube
scp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

```
**Configure Kubectl remote access**   
copy `$HOME/.kube/config` to your localhost and edith below section：
 
```javascript

apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://ip_address:port

```

**Create Admin Role**  

Run `kubectl apply -f admin-role.yaml`  

Run `kubectl -n kube-system get secret|grep admin-token `  

****Output:****
```javascript
kubectl -n kube-system get secret|grep admin-token
admin-token-bbbm4                                kubernetes.io/service-account-token   3      35m
```  

Run `kubectl -n kube-system describe secret admin-token-bbbm4`  
****Output:****
```javascript
kubectl -n kube-system describe secret admin-token-bbbm4
Name:         admin-token-bbbm4
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: admin
              kubernetes.io/service-account.uid: 7f947d1c-6653-11e9-8a08-00163e0c006c

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  11 bytes
token:      xxxxxxxxx
```


**Enable Metric**
--requestheader-client-ca-file=/etc/kubernetes/ssl/ca.pem
--requestheader-allowed-names=aggregator
--requestheader-extra-headers-prefix=X-Remote-Extra-
--requestheader-group-headers=X-Remote-Group
--requestheader-username-headers=X-Remote-User


**Configure Dashboard**  

* `kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml`
* Run `kubectl proxy`  
* access `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/`  
use the token generated above to login

**Configure Docker**  
`kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>`