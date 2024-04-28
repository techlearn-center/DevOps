Since this Prometheus instance is designed to monitor a Kubernetes cluster, you must first provision the cluster using kOps. You can find the detailed instructions [here](https://github.com/techlearn-center/DevOps/blob/CICD/Kubernetes/kOps.md) . 

After the cluster is provisioned, follow the steps outlined below to install Prometheus and Grafana:

Steps to Install Prometheus:
--------------------------------
```
helm search repo prometheus
```
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```
```
helm repo update
```
```
helm install prometheus prometheus-community/prometheus
```
```
kubectl get all
```

Now to make the service, which is normally only accessible within the cluster, available outside, we will be exposing it on each node's IP at a specific port. This can be helpful for accessing the service from external systems or for debugging purposes.

By running below command, Kubernetes creates a new service object that routes external traffic coming to each node on a specific port (assigned by Kubernetes if not specified) to the port 9090 on the pods selected by the original service prometheus-kube-prometheus-prometheus. This makes the Prometheus server accessible from outside the cluster.

```
kubectl expose service prometheus-kube-prometheus-prometheus --type=NodePort --target-port=9090 --name=prometheus-server-ext
```


To find out which node the prometheus-kube-prometheus pod is scheduled on, use the following command:
```
kubectl get pods -o wide|grep prometheus-prometheus-kube-prometheus-prometheus-0|awk '{print  $7}'
```
- Now that you have the node name, navigate to your EC2 dashboard, search for that specific EC2 instance, and note its IP address. 

- Additionally, make sure to edit the security group to allow traffic on the port that Grafana is listening on. 

- To find out which port Prometheus is using, you can use the following command:
prometheus-server-ext

```
echo $(kubectl get svc prometheus-server-ext -o=jsonpath='{.spec.ports[0].nodePort}')
```
- You can now access Grafana by opening your browser and entering the IP address and port in the format IP:Port. For example, use http://3.93.10.212:32531/ where 3.93.10.212 is the IP of the EC2 instance where your Grafana pod is scheduled, and 32531 is the NodePort used for accessing Grafana.



Steps to install Grafana:
--------------------------
```
helm repo add grafana https://grafana.github.io/helm-charts
```
```
helm repo update
```
```
helm install grafana stable/grafana
```
```
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext
```

To know which node the Grafana pod is scheduled on, use below command 
```
kubectl get pods -o wide | grep 'grafana' | grep -v 'prometheus' | awk '{print  $7}'
```
- Now that you have the node name, navigate to your EC2 dashboard, search for that specific EC2 instance, and note its IP address. 

- Additionally, make sure to edit the security group to allow traffic on the port that Grafana is listening on. 

- To find out which port Grafana is using, you can use the following command:
```
kubectl get svc |grep grafana-ext|awk '{print $5}'|cut -d":" -f2|cut -d"/" -f1
```
or 
```
echo $(kubectl get svc grafana-ext -o=jsonpath='{.spec.ports[0].nodePort}')
```
- You can now access Grafana by opening your browser and entering the IP address and port in the format IP:Port. For example, use http://3.93.10.212:32531/ where 3.93.10.212 is the IP of the EC2 instance where your Grafana pod is scheduled, and 32531 is the NodePort used for accessing Grafana.

- Your Grafana dashboard is now operational. To access it, please enter the username and password. To retrieve these credentials, use the following command:

```
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```


----------------------------------------------------------

Here are Grafana dashboard templates that you can import: 
- [Dashboard 6417](https://grafana.com/grafana/dashboards/6417)
- [Dashboard 3662](https://grafana.com/grafana/dashboards/3662)
