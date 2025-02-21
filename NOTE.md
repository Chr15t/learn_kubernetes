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
kubectl api-resources 
```
- Retrieve all api ressources 


```sh
kubectl explain pod | more 
kubectl explain deployment.spec # output an explanation of spec 
```
- Retrieve explanation of a resources 




```sh
kubectl describe nodes/pods name | more
```
- Retrieve description of a pod or nodes

```sh
sudo kubeadm reset
```
- reset the cluster kubernetes

```sh
kubectl apply -f deployment.yaml
# -f specify the manifest 
# manifest can be JSON or YAML
```
- deploy and run on pod

```sh 
sudo crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps
```
output all pod running 


### Controller

```sh
kubectl run podName --image=source_image
```
Deploy a pod without controller
### Scalling 
```sh
sudo kubectl scale deployment deployment_name 
```