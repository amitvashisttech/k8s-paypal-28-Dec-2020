# Docker login
```
docker login
ls /root/.docker/config.js
```

# Create a Secret in K8s for Docker Registry
```
 kubectl create secret generic regcred --from-file=.dockerconfigjson=/root/.docker/config.js on --type=kubernetes.io/dockerconfigjson
```

```
kubectl get secrets
```
