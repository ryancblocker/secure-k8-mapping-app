#!/bin/bash

# Start minikube
    echo -e "\n------------------------ START MINIKUBE ------------------------\n"
    # Delete existing minikube cluster and start again
    minikube delete
    minikube start

# Enable ingress addon
    echo -e "\n------------------------ ENABLE INGRESS ------------------------\n"
    minikube addons enable ingress

# Install helm chart
    echo -e "\n------------------------ INSTALL HELM --------------------------\n"
    # Uninstall existing helm release if it exists
    if helm list | grep -q '^test'; then
        helm uninstall test
    fi
    # Wait for the Ingress controller to be ready before installing your chart
    echo "Waiting for Ingress controller to be ready..."
    kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=120s
    # Install helm chart
    echo "Installing helm chart..."
    sleep 5
    helm install test FinalChart

## Wait for all pods to be running
    echo -e "\n------------------ SPINNING UP CLUSTER PODS -----------------\n"
    while true; do
        RUNNING_PODS=$(kubectl get pods -n default --no-headers | grep Running | wc -l)
        TOTAL_PODS=$(kubectl get pods -n default --no-headers | wc -l)

        if [[ $RUNNING_PODS -eq $TOTAL_PODS ]]; then
            break
        else
            echo "Waiting for pods to be running..."
            sleep 5
        fi
    done
    # Get the keycloak pod name
    KEYCLOAK_POD=$(kubectl get pod -l app=keycloak -n default -o jsonpath="{.items[0].metadata.name}")
    # Wait for keycloak to be fully started
    while true; do
        LAST_LOG=$(kubectl logs $KEYCLOAK_POD -n default | tail -1)
        if [[ $LAST_LOG == *"Running the server in development mode"* ]]; then
            break
        else
            echo "Waiting for Keycloak to start..."
            sleep 5
        fi
    done

# Display URLs
    echo -e "\n------------ KEYCLOAK AND SPRINGBOOT EXTERNAL LINKS ------------\n"
    KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io
    echo ""
    echo "Keycloak:                 $KEYCLOAK_URL"
    echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin"
    echo "Springboot App:           http://$(minikube ip):30001"
    echo ""

    echo -e "Above are the Keycloak configuration and our client links at the moment you must configure Keycloak with realm3.json\n"