Link to installation https://minikube.sigs.k8s.io/docs/start/
### Using Choco on Windows
```
choco install minikube kubernetes-cli
```

```
minikube start

```
#### If you are encountering the error below when starting minikube 

_X Exiting due to HOST_VIRT_UNAVAILABLE: Failed to start host: creating host: create: precreate: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory
* Suggestion: Virtualization support is disabled on your computer. If you are running minikube within a VM, try '--driver=docker'. Otherwise, consult your systems BIOS manual for how to enable virtualization.
* Related issues:
  - https://github.com/kubernetes/minikube/issues/3900_
