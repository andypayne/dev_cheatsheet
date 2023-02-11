# Kubernetes Notes

## Install minikube and kubectl

On Mac:

```
brew install minikube
```

This will install kubectl as a dependency.

Note: The [hyperkit driver](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/) doesn't work on Mac M1. See this issue: [Mac M1: hyperkit not supported](https://github.com/kubernetes/minikube/issues/11885). So instead I'm using the docker driver.

## Run minikube

First, be sure that [Docker Desktop](https://docs.docker.com/desktop/install/mac-install/) is installed and running. 

Then run minikube:

```
minikube start --driver=docker --alsologtostderr
```


## Status/Monitoring

The status should show that it's running:

```
$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```


List all pods:

```
$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE
kube-system   coredns-787d4945fb-hq8n7           1/1     Running   0             16h
kube-system   etcd-minikube                      1/1     Running   0             16h
kube-system   kube-apiserver-minikube            1/1     Running   0             16h
kube-system   kube-controller-manager-minikube   1/1     Running   0             16h
kube-system   kube-proxy-cgrm9                   1/1     Running   0             16h
kube-system   kube-scheduler-minikube            1/1     Running   0             16h
kube-system   storage-provisioner                1/1     Running   1 (16h ago)   16h
```

Show cluster info:
```
$ kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:60006
CoreDNS is running at https://127.0.0.1:60006/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

Run the dashboard:

```
minikube dashboard
```

This will open the [dashboard web app](http://127.0.0.1:63406/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/) in your browser.


List nodes:

```
$ kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   21h   v1.26.1
```

List services:

```
$ kubectl get services
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   24h
```

