# Deploying Our App in Kubernetes
We are using ingress with our spring boot app because 
1. Allows us to map traffic to different services/servers
2. Helps us with load balancing 
3. Allows for scalibility and flexibility

**Now, this assumes you have already have minikubed installed and have ran the following command:**
```
minikube start
```
Now run this command, to enable ingress:
```
minikube addons enable ingress
```
To verify that NGINX Ingress controller is running: 
```
kubectl get pods -n ingress-nginx
```
The **output** should be similar to: 
```
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-cr47x        0/1     Completed   0          53s
ingress-nginx-admission-patch-v7drx         0/1     Completed   1          53s
ingress-nginx-controller-6cc5ccb977-9vmjj   1/1     Running     0          53s
``` 

## Now the README will show how to deploy a spring boot app!!!!! 
## Create and Ingress within springboot 

(we didnt end up needing to do this but the research will tell you how)
