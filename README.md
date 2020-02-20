# Kubernetes Cluster on Vbox

This is a tool I use to play with K8s clusters on my MacOS using Vagrant and Virtual Box. 

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

## How to check if the cluster is running?

You can access to each Virtual Machine (node in K8s terminology) with the command:

```
vagrat ssh <node name>
```

where <node name> could be ```k8s-head```, ```k8s-node-1```, and ```k8s-node-2```. To check if the cluster is running, and for all the administration tasks, you can access to the master node and use kubectl commands as vagrant user. The following command shows you the status of all the three nodes.
 
```
kubectl get nodes
```

You should see all the nodes in Ready status.


