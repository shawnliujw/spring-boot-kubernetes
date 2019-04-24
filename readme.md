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
   ```javascript
   <cluster_ip>  micro.info
    ```

## How To Test
1. create department:
   ```javascript
   curl -d '{"organizationId":1,"id":2,"name":"core"}' -H 'Content-Type:application/json' micro.info/department```
   
2. create employee:
   ```javascript
   curl -d '{"organizationId":1,"id":2,"name":"core"}' -H 'Content-Type:application/json' micro.info/employee
    ```
    
3. check result:
   ```javascript
    curl micro.info/employee
    ```    
    ```javascript
     curl micro.info/department
    ```  
    
4. check FeignClient works:
   ```javascript
    curl micro.info/department/organization/1/with-employees
    ```      
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

