# Kubernetes Cluster Demo

This is tool I created to play with K8s clusters on my MacOS using Vagrant and Virtual Box. 

I started from the [following project](https://github.com/ecomm-integration-ballerina/kubernetes-cluster/) that I fixed to work with K8s 1.6 API. I reworked the code to have the setup on more than one script instead of on one big Vagrantfile hard to read.

## Pre-requisites

 * **[Vagrant 2.1.4+](https://www.vagrantup.com)**
 * **[Virtualbox 5.2.18+](https://www.virtualbox.org)**
 
## Run the K8s Cluster

Execute the following command to start a new Kubernetes cluster. Default configuration will start one master (called ```k8s-head```) and two workers (called ```k8s-node-1``` and ```k8s-node-2```).

```
git clone https://github.com/sasadangelo/k8s-cluster
cd k8s-cluster
vagrant up
```


