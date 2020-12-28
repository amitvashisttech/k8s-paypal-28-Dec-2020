# K8s Datastore - ETCD

## Check the status of ETCD
```
kubectl get pods -n kube-system | grep -i  etcd
```

## Let explore ETCD POD
```
kubectl exec -it etcd-kmaster -n kube-system   -- /bin/sh
```

## Check the ETCD Status
```  
ETCDCTL_API=3 etcdctl --cacert="/etc/kubernetes/pki/etcd/ca.crt"  --cert="/etc/kubernetes/pki/etcd/server.crt" --key="/etc/kubernetes/pki/etcd/server.key" endpoint status

```

## Checking the ETCD Prefix
```
ETCDCTL_API=3 etcdctl --cacert="/etc/kubernetes/pki/etcd/ca.crt"  --cert="/etc/kubernetes/pki/etcd/server.crt" --key="/etc/kubernetes/pki/etcd/server.key" get / --prefix --keys-only

```
