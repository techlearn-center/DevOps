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

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana stable/grafana
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext
minikube service grafana-ext

To get user name and password in Grafana:

kubectl get secret --namespace default grafana -o yaml
echo "RkpwY21aTFNXRDVJN3Z4RWFFUjlibkV1SDBDbnFBendadmc0bmROZQ==" | openssl base64 -d ; echo

or 

kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
----------------------------------------------------------

Dashboards: 
https://grafana.com/grafana/dashboards/6417
https://grafana.com/grafana/dashboards/3662
Prometheus Playlist: https://www.youtube.com/playlist?list=PLVx1qovxj-anCTn6um3BDsoHnIr0O2tz3
