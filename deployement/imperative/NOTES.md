


## create and run deployment
```sh
kubectl create deployment nginx --image=nginx #create deployment
kubectl run nginx --image=nginx # deploy and run on pod 

# --dry-run=client -o yaml > deployement.yaml create the manifest
```


kubectl set image deployment hello-world hello-world=hello-app:2.0

--record

kubectl rollout status deployment deployyment_name: check in live the modification