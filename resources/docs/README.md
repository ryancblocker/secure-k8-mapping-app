# **Keycloak Web Application Running with Minikube**

## **Authors and acknowledgment**

Ryan Blocker, Cassidy Roberts, Carlos Flores, Isabella Settje, Yared Sanbet

## **Description**

This project's current priority is to create a functioning web app using the spring-boot architecture and authenticate users using Keycloak. The final vision of the project is to run the whole system inside of a Minikube cluster including the web-app, postgres server, and keycloak.

## **Installation**

- ### **Prerequisites**

  Everything in this guide assumes you have the following programs installed on your local machine as well as a cloned version of this repository. There may be other dependencies needed for your functionality but this is everything you need to get started:

  - Docker
  - Minikube
  - Java (version 17.0.1 or later)
  - Maven (version 3.9.2 or later)

  <span style="color: orange"> NOTE: </span> If you do not have any of just some of these dependencies here is a quick installation guide for all of the dependencies for Linux users: [Prerequisite Installation Guide](./InstallationGuide.md)

<br>

- ### <span style="color: red"> **Automatic Install**

   Before running your minikube you must configure your comuter resources so that minikube wil have the proper computer power to run the project paste the following commands into your terminal before starting up minikube

   ```bash
   minikube config set cpus 5
   minikube config set memory 10240
   minikube congig set disk-size 10000mb
   ```

   To automatically install the cluster, helm charts, and feed in the json data run the following script inside the main directory of the project after cloning

   ```bash
   ./clusterStart.sh
   ```

   The script will output the Keycloak configuration and Springboot links. At the moment you must configure Keycloak  manually with `realm3.json`.

   The configuration file **DOES NOT** create any users, so you must make one yourself. You must give your user a username and password (do not make it temporary).

   You also need to follow this guide to configure Kibana and Elasticsearch: [Running Kibana and Elasticsearch](./RunProject.md)

   After this is completed you can click on the Springboot link at the bottom of the script output and you will be directed to our client.

- ### **Using Minikube**

  #### **Start and stop your Minikube cluster**

  The minikube command is only used to start and stop minikube clusters. The following commands allow you to start or stop a cluster on your machine.

  ```bash
  minikube start
  ```

  ```bash
  minikube delete
  ```

  <span style="color: orange"> NOTE: </span> For all other terminal based interactions with the cluster, kubectl should be utilized. A lot of commands will take a couple of minutes to finish running

  #### **Creating a MiniKube pod**

  Once your cluster is up and running, you will need to create services, pods, and other items to successfully create what you want to create. To create a pod, run the following command, replacing "MYFILE.yaml" with your own YAML file. Of note, you may also create an item without a .yaml file by passing in specific arguments. Consult kubernetes documentation for me information.

  ```bash
  kubectl create -f <MYFILE.yaml>
  ```

  This command creates a deployment, which will deploy an number of things based on the .yaml file. NOTE: Every pod will need a corresponding service.

  #### **Other useful commands**

  - Show cluster status: `minikube status`
  - Show a list of your current pods: `kubectl get pods`
  - Show cluster status: `kubectl cluster-info`
  - List all Minikube deployments: `kubectl get deployments`
  - Tail the logs from a pod: `kubectl logs -f <POD NAME>`
  - Check if a pod is failing to return to "Running": `kubectl describe pod <POD NAME>`
  - Delete cluster data made by your YAML file: `kubectl delete -f <MYFILE.yaml>`

<br>

- ### **Using Helm**

  #### **Implementing and modifying Charts**

  To implement a chart, simply cd to its location and run the below command, replacing <RELEASE> with whatever you want this release to be called, and <CHART_NAME> with the chart you would like to install.

  ```bash
  helm install <RELEASE> <CHART_NAME>
  ```

  A helm chart will normally be somewhat templated. To change the templated values, got to the charts folder and open the values.yaml file. There you can modify values.

  #### **Other useful commands**

  - Make sure a chart is valid: `helm lint .`
  - Test if values are be substituted correctly and test if the chart will install: `helm install --dry-run <RELEASE> <CHART_NAME>`
  - View all helm charts currently installed: `helm list`
  - If anything in the chart has been changed, this command will update your helm chart: `helm upgrade <RELEASE> <CHART_NAME>`
  - Rolls back release to an older version, leave <REVISION-NUMBER> empty if you just want the last version: `helm rollback <RELEASE> <REVISION-NUMBER>`
  - Uninstall helm chart: `helm uninstall <RELEASE>`

<br>

- ### **Spinning up your postgresql database, keycloak, and our app using Helm**

  #### **Updating Values**

  1. If you would like to change what image our app uses or the number of replicas of any given pod, all of that can be easily accessed within the `values.yaml` file stored within the helm chart. The chart is named saffire_app.

  #### **Installing the Chart**

  AS A NOTE: The keycloak pod will crash and immediatly restart sometimes. This is not a bug, no data is lost when this occurs and all functionality is maintained.
  ANOTHER NOTE: The keycloak authirization page may be slow to spin up initially.

1. Once you have your minikube cluster started, enable ingress using the following:
     ```bash
     minikube addons enable ingress
     ```
  2. Then run the following command to install the helm chart. `test` is the name of this release, and can be changed to anything.
     ```bash
     helm install test saffire_app
     ```
  3. Run the following to gain the link to keycloak and the springboot app.
     ```bash
     KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io &&
     echo "" &&
     echo "Keycloak:                 $KEYCLOAK_URL" &&
     echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
     echo "Springboot App:           http://$(minikube ip):30001" &&
     echo ""
     ```
  4. To setup the realm within keycloak, use the `realm3.json`. This will initialize all the correct realm settings, however it DOES NOT create any users, so you must make one yourself. When giving your user a password do not make it temporary.
   
  <!-- 5. After you set your password go to **Role Mapping** and select **Assign Role**. Then navigate to the filter toggle and select **Filter by clients** then search for "saffire" in the search bar and select **SAFFIRE-ADMIN** and hit **Assign**. Keycloak is now configured properly. -->
      
  1. Then run the following command to post the dataset to elasticsearch:
      ```bash
      curl -XPOST -H 'Content-Type: application/json' 'http://192.168.49.2:30002/test/_bulk?pretty' --data-binary @initial/src/main/resources/static/bulk.json
      ```

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

- ### **Installing and Building Spring-Boot Web-Application**

  #### **What was added to the Spring Boot Application**

  - Helpful documentation on what a controller is. These relate to the HelloController.java file [https://education.launchcode.org/java-web-development/chapters/spring-controllers-and-routes/controllers-simple.html]
  - Similar to our previous project before we needed a src2 folder that holds the logout page in order for it to be referenced uniquely\
  - Springboot by default looks for html pages referenced in a resources/static folder within main, so in order for the login page to load it must be placed specifically in this path src/main/resources/static/login.html

  #### **Build the Spring-Boot Application**

  1. Go into the directory where you cloned the repository and then build the application using maven, this may take a couple of minutes due to dependencies the first time

     ```bash
     ./mvnw install
     ```

  2. If the build was successful, you should see a JAR file similar to the following

     ```sh
     ls -l target/*.jar
     -rw-r--r-- 1 root root 19463334 Nov 15 11:54 target/spring-boot-initial-0.0.1-SNAPSHOT.jar
     ```

  3. The jar is now an executable and the application can be launched with the following command:

     ```sh
     java -jar target/*.jar
     ```

  #### **Containerizing the Application**

  1. Since we have a Spring Boot jar file, you can call the plug in directly

     ```bash
     ./mvnw spring-boot:build-image
     ```

  2. You can run this container locally

     ```bash
     docker run -p 8080:8080 spring-boot-initial:0.0.1-SNAPSHOT
     ```
- ### **Using Docker Hub**

  When creating a deployment in the cluster, you will pass in an image for the deployment to use to make pods.

  <span style="color: red"> WARNING: </span> Kubernetes will **NOT USE IMAGES ON YOUR LOCAL MACHINE**. While you can force it to, it is much easier to upload your image to Docker Hub. Then call that image in your .yaml files.

  #### **Uploading Images to Docker**

  1. Create a Docker Hub account (if not done so already)
  2. Login to docker using `docker login`
  3. Create a repository and tag your local image with the Docker Hub repository name, replacing `<local_image>` with the name of your local Docker image.
  4. Run `docker images` to see your list of local Docker images and replace `<repository-name>` with the name of your Docker Hub repository, and `<tag>` with the tag of your image (EX: `latest`).

     ```bash
     docker tag <local-image> <docker-hub-username>/<repository-name>:<tag>
     ```

  5. Push your tagged image to Docker Hub:

     ```bash
     docker push <docker-hub-username>/<repository-name>:<tag>
     ```

     <br>
- ### **Deploying the Application to Kubernetes**

  1. Kubectl can generate a yaml file to make kubernetes run. Pay close attention to the --image name because it needs to match the image in the repo of dockerhub. Kubernetes cannot pull images locally off your machine, but can pull this image from the repo. Run these commands in order if you don't have a yaml file. If a yaml file is already created then you can skip to the last command:

     ```bash
     $ kubectl create deployment spring --image=carflo1/kube-spring-keycloak-app:latest --dry-run -o=yaml > spring_deployment.yaml
     $ echo --- >> spring_deployment.yaml
     $ kubectl create service clusterip spring --tcp=8080:8080 --dry-run -o=yaml >> spring_deployment.yaml
     ```

  2. You can now edit this yaml file or apply it as is

     ```bash
     $ kubectl apply -f deployment.yaml
     deployment.apps/spring created
     service/spring created
     ```

  3. Check that the application is running, run the `kubectl get all` command until status is running. She output should look like this:

     ```sh
     $ kubectl get all
     NAME                             READY     STATUS      RESTARTS   AGE
     pod/demo-658b7f4997-qfw9l        1/1       Running     0          146m

     NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
     service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP    2d18h
     service/spring         ClusterIP   10.43.138.213   <none>        8080/TCP   21h

     NAME                   READY     UP-TO-DATE   AVAILABLE   AGE
     deployment.apps/spring   1/1       1            1           21h

     NAME                              DESIRED   CURRENT   READY     AGE
     replicaset.apps/spring-658b7f4997   1         1         1         21h
     ```

  4. Lastly you can connect your application after you exposed it as a Service to Kubernetes. This can be done through an SSH tunnel

     ```sh
     kubectl port-forward svc/demo 8080:8080
     ```

- ### **Important Note**
  As the application is running, you must also have http-server running in a seperate terminal as well to see the logout page
