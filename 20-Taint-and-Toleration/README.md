# Taint & Tolerations

## Taint the nodes ( worker02 )  
```
kubectl taint nodes worker02 app=myapp:NoSchedule
kubectl describe nodes worker02 | grep -i taint
```


## Untaint the nodes
```
kubectl taint nodes worker02 myapp-
```
