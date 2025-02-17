## KUBERNETES COMMAND
  ```sh 
  kubectl cluster-info
  ```
- Output all ihformation of a cluster
```sh
kubectl get nodes 
```
- Output all nodes of the cluster
-  -o wide: all supplement information of a node

```sh
kubectl get pods 
```
- Get all pods of the default namespace


```sh
kubectl get all 
```
- Retrieve all services of a cluster 
```sh
kubectl api-ressources 
```
- Retrieve all api ressources 

```sh
sudo kubeadm reset
```
- reset the cluster kubernetes