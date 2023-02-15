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

List deployments:

```
$ kubectl get deployments
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
nginx-depl   1/1     1            1           2m51s
```

List replica sets:

```
$ kubectl get replicaset
NAME                   DESIRED   CURRENT   READY   AGE
nginx-depl-56cb8b6d7   1         1         1       5m23s
```

Show pod logs:

```
$ kubectl logs nginx-depl-56cb8b6d7-7pphh
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/02/11 00:27:43 [notice] 1#1: using the "epoll" event method
2023/02/11 00:27:43 [notice] 1#1: nginx/1.23.3
2023/02/11 00:27:43 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6)
2023/02/11 00:27:43 [notice] 1#1: OS: Linux 5.10.104-linuxkit
2023/02/11 00:27:43 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2023/02/11 00:27:43 [notice] 1#1: start worker processes
2023/02/11 00:27:43 [notice] 1#1: start worker process 29
2023/02/11 00:27:43 [notice] 1#1: start worker process 30
2023/02/11 00:27:43 [notice] 1#1: start worker process 31
2023/02/11 00:27:43 [notice] 1#1: start worker process 32
2023/02/11 00:27:43 [notice] 1#1: start worker process 33
```


## Create a deployment

To create a deployment of the default nginx image named "nginx-depl":

```
$ kubectl create deployment nginx-depl --image=nginx
deployment.apps/nginx-depl created
```

### Create a deployment from a file

Here's an example file `nginx-deployment.yml`:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.23
        ports:
        - containerPort: 80

```

Run:

```
$ kubectl apply -f nginx-deployment.yml
deployment.apps/nginx-deployment created
```

## Edit a deployment

To load the deployment configuration in an editor:

```
kubectl edit deployment nginx-depl
```

Saving changes will trigger a redeployment.


## Start an interactive shell

To start an interactive shell inside a running pod:

```
$ kubectl exec -it nginx-depl-56cb8b6d7-7pphh -- /bin/bash
root@nginx-depl-56cb8b6d7-7pphh:/#
```


## Delete a deployment

```
$ kubectl delete deployment nginx-depl
deployment.apps "nginx-depl" deleted
```



