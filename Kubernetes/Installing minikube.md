Link to installation https://minikube.sigs.k8s.io/docs/start/
Note: Make sure you have virtualBox or Docker Desktop installed on your machine

### Using Choco on Windows
```
choco install minikube kubernetes-cli
```

```
minikube start

```
_X Exiting due to HOST_VIRT_UNAVAILABLE: Failed to start host: creating host: create: precreate: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory_
_* Suggestion: Virtualization support is disabled on your computer. If you are running minikube within a VM, try '--driver=docker'. Otherwise, consult your systems BIOS manual for how to enable virtualization._
_* Related issues:_
  _- https://github.com/kubernetes/minikube/issues/3900_

#### If you are encountering the error above when starting minikube use 
``` 
minikube start --no-vtx-check 
```
