## Quick sample for building microservice with Spring Boot + Kubernetes and debug remotely

This project will show you how to setup kubernetes cluster by kubeadm , deploy spring boot micro service, and how to debug your code

## Setup Kubernetes Cluster
See [Setup Kubernetes By Kubeadm](https://github.com/shawnliujw/kubeadm-kubernetes/blob/master/README.md)
## Preparation  
* create cluster role  
`kubectl create clusterrolebinding admin --clusterrole=cluster-admin --serviceaccount=default:default` 
* Init mongodb  
`kubectl apply -f kubernetes/mongodb`  
## How To Deploy

* build projects
`mvn clean install`
* build docker images  
`bash build.sh` 
* push docker images  
`bash push.sh` **Please skip this step if you run locally**
* deploy to cluster  
`kubectl apply -f kubernetes/projects`  
* deploy ingress  
`kubectl apply -f kubernetes/ingress.yaml`
* configure host  
run `kubectl cluster-info` to get  `cluster_ip`  
add host to `/etc/hosts` with:
   `<cluster_ip>  micro.info`

## How To Test
* Init Data:  
   `curl -d '{"id":1,"id":1,"name":"company name","address":"company address"}' -H 'Content-Type:application/json' shawn.info/organization/` 
   
   `curl -d '{"organizationId":1,"id":1,"name":"department name"}' -H 'Content-Type:application/json' shawn.info/department/` 
   
   `curl -d '{"organizationId":1,"departmentId":1,"id":1,"name":"employee"}' -H 'Content-Type:application/json' shawn.info/employee/` . 
    
* check result:  

    `curl micro.info/employee/1` . 
   
    `curl micro.info/department/1` . 
    
    `curl micro.info/department/organization/1/with-employees`
    
## How To Debug  With Telepresence

#### Install Telepresence  

**OS X**
```
brew cask install osxfuse
brew install datawire/blackbird/telepresence
```  
**Ubuntu 16.04 or later**  
```
curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | sudo bash
sudo apt install --no-install-recommends telepresence
```  

for other OS, [See More](https://www.telepresence.io/reference/install)

  
#### Configure 
* generate env.json  
`telepresence --swap-deployment <service in k8s> --env-json service.env.json`
* load env in IDEA  
you will need to install the [Env File plugin](https://plugins.jetbrains.com/plugin/7861-envfile).
load the `service.env.json` generated above
* debug your code as usual  
Refer To: [Using Telepresence with IntelliJ](https://www.telepresence.io/tutorials/intellij)

## Serverless  
[Click Here](https://github.com/shawnliujw/serverless-kubernetes-sample/blob/master/README.md) to check the samples  

## Monitor(Prometheus,Grafana,Alert)  
Click [Here](https://github.com/shawnliujw/kubeadm-kubernetes/blob/master/README.md)

### install 
`kubectl apply -f monitor/`
### access  
* Prometheus  

`kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090`  
Then access via `http://localhost:9090`

* Grafana

`kubectl --namespace monitoring port-forward svc/grafana 3000`  
Then access via http://localhost:3000 and use the default grafana user:password of `admin:admin`.

* Alert Manager

`kubectl --namespace monitoring port-forward svc/alertmanager-main 9093`  
Then access via    `http://localhost:9093`


See more [here](https://github.com/coreos/kube-prometheus)
>>>>>>> 58967bfcf65d7298c1c5d15f065c4710d83cab00
