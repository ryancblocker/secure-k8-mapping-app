- ### **Deploying ECK to Allow for Elasticsearch and Kibana Deployment**
  #### Deploying Elastic Cloud on Kubernetes in a Kubernetes cluster

1. Install custom resource definitions (crd):
   ```sh
    kubectl create -f https://download.elastic.co/downloads/eck/2.8.0/crds.yaml
    ```
2. Install the operator with its RBAC rules:
    ```sh
    kubectl apply -f https://download.elastic.co/downloads/eck/2.8/operator.yaml
    ```

#### Deploying an Elasticsearch Cluster
1. Run the elasticsearch yaml you begin the quick deployment
    ```sh
    kublectl apply -f quickstart-es.yaml
    ```
2. Ensure the cluster and pods have been correctly created
    ```sh
    kubectl get elasticsearch
    
    NAME          HEALTH    NODES     VERSION   PHASE         AGE
    quickstart    green     1         8.8.1     Ready         1m
    ```
    ```sh
    kubectl get pods --selector='elasticsearch.k8.elastic.co/cluster-name=quickstart'

    NAME                      READY   STATUS    RESTARTS   AGE
    quickstart-es-default-0   1/1     Running   0          79s
    ```
3. Requesting Elasticsearch Access
    ```sh
    kubectl get service quickstart-es-http

    NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    quickstart-es-http   ClusterIP   10.15.251.145   <none>        9200/TCP   34m
    ```
    1. Get Credentials: A default username elastic 
        ```sh
        PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
        ```
    2. From your terminal,
        ```sh
        kubectl port-forward service/quickstart-es-http 9200
        ```
    3. Then request localhost, this ensures elasticsearch has deployed correctly
        ```sh
        curl -u "elastic:$PASSWORD" -k "https://localhost:9200"

        {
        "name" : "quickstart-es-default-0",
        "cluster_name" : "quickstart",
        "cluster_uuid" : "XqWg0xIiRmmEBg4NMhnYPg",
        "version" : {...},
        "tagline" : "You Know, for Search"
        }
        ```