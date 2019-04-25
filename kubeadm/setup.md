## Setup Kubernetes Single Node Cluster By Kubeadm on Ubuntu 18.04

**Install**  
* run `sh install.sh`

**Configure Kubectl remote access**   
copy `$HOME/.kube/config` to your localhost and edith below section：
 
```javascript

apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://ip_address:port

```

**Access Dashboard**  

* Run `kubectl proxy`  
* access `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/`  
use the token generated above to login

**Configure Docker**  
`kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>`