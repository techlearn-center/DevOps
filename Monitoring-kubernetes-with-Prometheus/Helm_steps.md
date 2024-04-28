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
To know which node the prometheus-kube-prometheus is scheduled on :
```
kubectl get pods -o wide 
```

#### This will help you know the node (ip) to access the prometheus. 
kubectl expose service prometheus-kube-prometheus-prometheus --type=NodePort --target-port=9090 --name=prometheus-server-ext
http://IP:port ( port of prometheus-server-ext svc)


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
