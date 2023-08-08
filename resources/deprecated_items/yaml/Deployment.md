- ### **Creating a persistent PostgresSQl volume running in a Minikube Pod**
  #### **Modify your YAML file**

  1. In `postgres.yaml`, in the persitant volume file, replace the hostPath with the correct path. Also replace the given username with your computer username.
  2. Of note, in `secrets.yaml` the values for POSTGRES_DB, POSTGRES_USER, and POSTGRES_PASSWORD are all arbitrary, so you can assign those values to be anything you would like.
  3. Make sure you have a minikube cluster up and running
  4. Run the following commands in order (the postgresql yaml file will start a persistent volume, persistent volume claim, service, and deployment)
      ```bash
     kubectl apply -f secrets.yaml
     ```
     ```bash
     kubectl apply -f postgres.yaml
     ```

  5. Run `kubectl get all` to make sure that everything is running.

  #### **Accessing the PostgresSQL Database**
  1. Run `kubectl get pods` to view all of your active pods.
  2. To check the logs of database pod, you can check by issuing the command:

     ```bash
     kubectl logs pod/<name-of-your-pod>
     ```

  3. To access the database run:

     ```bash
     kubectl exec -it pod/<name-of-your-pod> bash`
     ```

  4. To connect to postgres, run `psql -U keycloak -d keycloak`. The first keycloak is the user and the second is the database, change these if you change them in the secrets.yaml file
  5. Your now in a postgresql terminal with access to the database. Good job.

<br>

- ### **Deploying Keycloak in a Minikube Pod**
  #### **Configure the Cluster for Keycloak**
  1. Once a minikube cluster is running _(use `minikube status` to check)_

  2. Run this _(If you haven't already)_ to configure the secrets the other yaml files will use:

     ```bash
     kubectl apply -f secrets.yaml
     ```
  3. Run this to enable ingress
      ```bash
      minikube addons enable ingress
      ``` 

  #### **Run Keycloak**
 
  1. Run the command `kubectl get services`. Run the below command, replaing <REPLACE_ME> with the cluster ip of the postgres service you found after running `kubectl get services`.

     ```bash
      cat keycloak.yaml | \
      sed "s/PGDB_IP/<REPLACE_ME>/" | \
      kubectl create -f -
     ```
     
  2. Run this to setup up an ingress with the keycloak pod
      
      ```bash
      cat keycloak-ingress.yaml | \
      sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" | \
      kubectl create -f -
      ```
  3. Run this to generate the links to your keycloak instance
      ```bash
      KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io &&
      echo "" &&
      echo "Keycloak:                 $KEYCLOAK_URL" &&
      echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
      echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" &&
      echo ""
      ```
  4. To configure your keycloak instance to work with our app you must create a realm named `saffire_realm` then a client named `saffire_client`. When creating the client make sure to change both redirect URI's to `*`.
   #### running our app

  1. To create the app in kubernetes run:
   ```bash
   kubectl create -f spring_deployment.yaml
   ```
  2. Run the following to expose the app on port 8080. Once this is done the app can be accessed via localhost:8080
   ```bash
   kubectl port-forward svc/spring 8080:8080
   ```