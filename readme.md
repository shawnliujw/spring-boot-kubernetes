## Quick sample for building microservice with Spring Boot + Kubernetes

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

## Scripts
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
