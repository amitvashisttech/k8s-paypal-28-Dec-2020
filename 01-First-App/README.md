# Creating out First App

## Check the health of Cluster
```
kubectl get nodes 
```

## Deploy Hello OK App
```
kubectl run hello-k8s --image=gcr.io/google_containers/hpa-example --port=80
```

## Check the status of PODs 
```  
kubectl get pods 
kubectl describe pods hello-k8s
```
```
kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
hello-k8s        1/1     Running   0          6m22s
```

