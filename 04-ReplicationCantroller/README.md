# Docker login
```
docker login
ls /root/.docker/config.js
```

# Create a Secret in K8s for Docker Registry
```
kubectl create secret generic regcred --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson

kubectl get secrets
```

# Create Replication Cantroller
```
kubectl create -f 04-ReplicationCantroller/helloworld-rc.yaml
```

# Scale the replicas to 5.
```
kubectl scale --replicas=5 rc  helloworld-controller
```

# Status 
```
watch -n .5 kubectl get pods,rc -o wide
```

```

NAME                              READY   STATUS    RESTARTS   AGE     IP              NODE       NOMINATED NODE   READINESS GATES
pod/hello-k8s-2                   1/1     Running   0          3h27m   192.168.30.70   worker02   <none>           <none>
pod/hello-k8s-3                   1/1     Running   0          172m    192.168.5.6     worker01   <none>           <none>
pod/helloworld-controller-6kx4q   1/1     Running   0          9m34s   192.168.5.18    worker01   <none>           <none>
pod/helloworld-controller-ps86v   1/1     Running   0          9m34s   192.168.30.80   worker02   <none>           <none>

NAME                                          DESIRED   CURRENT   READY   AGE     CONTAINERS           IMAGES                      SELECTOR
replicationcontroller/helloworld-controller   2         2         2       9m34s   docker-get-started   amitvashist7/k8s-tiny-web   app=docker-get-started
```

