## Running our app with ONLY kibana and elastic search (The words that precede the commands are important)

1. Start up a clean minikube cluster and install the `kibana-testing-chart` chart
2. Once that is running, the following commands, each in their own terminal
    ```
    kubectl port-forward service/quickstart-es-http 9200
    ``` 
    ```
    kubectl port-forward service/quickstart-kb-http 5601
    ```
3. Run the following commands:
    ```
    PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
    ```
    ```
    curl -u "elastic:$PASSWORD" -k "https://localhost:9200"
    ```
4. Run the following command. This string generated is your password for accessing kibana, your username is `elastic`
    ```
    echo $PASSWORD
    ```
5. Now go to `localhost:5601`, log into kibana, and create and format your map data. Once that is done, go to share and get the line of code required to embede it
6. Go to the `kibana.html` file in the static folder of our app (folder name: initial). Replace the old line for connecting to kibana with the new one.
7. Rebuild our app, create an image using the remade jar file, then push that to dockerhub.
8. Change the image to be used in the `spring_deployment.yaml` to the one you just pushed. Apply that yaml file.
9. Congratulations! You're done.

## Running the final project

1. Start up a clean minikube cluster and enable the ingress addon
2. install the `FinalChart` chart
3. WAIT a minute for everything to start up run, then run the following commands, each in their own terminal
    ```
    kubectl port-forward service/quickstart-es-http 9200
    ``` 
    ```
    kubectl port-forward service/quickstart-kb-http 5601
    ```
4. Run the following commands:
    ```
    PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
    ```
    ```
    curl -u "elastic:$PASSWORD" -k "https://localhost:9200"
    ```
5. Run the following command. This string generated is your password for accessing kibana, your username is `elastic`
    ```
    echo $PASSWORD
    ```
6. Run the following:
   ```
   KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io &&
     echo "" &&
     echo "Keycloak:                 $KEYCLOAK_URL" &&
     echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
     echo "Springboot App:           http://$(minikube ip):30001" &&
     echo ""
   ```
7. Go to keycloak, create a realm using the `realm3.json` file, then create a user and give them a non-temporary password.
8. Now go to `localhost:5601`, log into kibana, and create and format your map data. Once that is done, go to share and get the line of code required to embede it
9. Go to the `kibana.html` file in the static folder of our app (folder name: initial). Replace the old line for connecting to kibana with the new one.
10. Rebuild our app, create an image using the remade jar file, then push that to dockerhub.
11. Change the image to be used in the `spring_deployment.yaml` to the one you just pushed. Apply that yaml file.
12. Congratulations! You're done.