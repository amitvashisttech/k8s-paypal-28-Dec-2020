# Install Helm

## Download the latest version of helm : as of today: 3.4.2
```
wget https://get.helm.sh/helm-v3.4.2-linux-amd64.tar.gz
tar -zxvf helm-v3.4.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
```

## Initialize Helm
```
kubectl create -f helm-rbac.yaml
helm init --service-account tiller --override spec.selector.matchLabels.'name'='tiller',spec.selector.matchLabels.'app'='helm' --output yaml | sed 's@apiVersion: extensions/v1beta1@apiVersion: apps/v1@' | kubectl apply -f -
```

## Install Wordpress
```
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
helm search wordpress
helm install my-release azure-marketplace/wordpress
```

Have Fun.!!
