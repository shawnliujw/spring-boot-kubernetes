## Quick sample for building microservice with Spring Boot + Kubernetes and debug remotely

This project will show you how to setup kubernetes cluster by kubeadm , deploy spring boot micro service, and how to debug your code

## Setup Kubernetes Cluster
See [Setup Kubernetes By Kubeadm](./kubeadm/setup.md)

**Note**
create account first:  
```javascript
kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts
```

## How To Deploy
1. $ kubectl create clusterrolebinding admin --clusterrole=cluster-admin --serviceaccount=default:default
2. `mvn clean install`
3. `bash build.sh`
4. `bash push.sh` Please skip this step if you run locally
5. `bash deploy.sh`
6. run `kubectl cluster-info` to get your cluster ip
7. add host to `/etc/hosts` with:
   `<cluster_ip>  micro.info`

## How To Test
1. Init Data:  
   `curl -d '{"id":1,"id":1,"name":"company name","address":"company address"}' -H 'Content-Type:application/json' micro.info/organization` 
   
   `curl -d '{"organizationId":1,"id":1,"name":"department name"}' -H 'Content-Type:application/json' micro.info/department` 
   
   `curl -d '{"organizationId":1,"departmentId":1,"id":1,"name":"employee"}' -H 'Content-Type:application/json' micro.info/employee` . 
    
2. check result:  

    `curl micro.info/employee/1` . 
   
    `curl micro.info/department/1` . 
    
    `curl micro.info/department/organization/1/with-employees`
    
## How To Debug  With Telepresence
[Install Telepresence Before Start](https://www.telepresence.io/reference/install)

[Using Telepresence with IntelliJ](https://www.telepresence.io/tutorials/intellij)  
**Configuration**  
1. generate env.json  
`telepresence --swap-deployment <service in k8s> --env-json service_env.json`
2. load env in IDEA  
you will need to install the [Env File plugin](https://plugins.jetbrains.com/plugin/7861-envfile).
load the `service_env.json` generated above
3. debug your code as usual

