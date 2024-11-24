#!/bin/bash

mkdir -p ./k8s-users

CERT_DIR="./k8s-users"

minikube ssh "sudo cat /var/lib/minikube/certs/ca.crt" > ${CERT_DIR}/ca.crt
minikube ssh "sudo cat /var/lib/minikube/certs/ca.key" > ${CERT_DIR}/ca.key

create_user() {
  USERNAME=$1
  GROUP=$2

  openssl genrsa -out ${CERT_DIR}/${USERNAME}.key 2048

  openssl req -new -key ${CERT_DIR}/${USERNAME}.key -out ${CERT_DIR}/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${GROUP}"

  openssl x509 -req -in ${CERT_DIR}/${USERNAME}.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/${USERNAME}.crt -days 365 -sha256

  kubectl config set-credentials ${USERNAME} --client-certificate=${CERT_DIR}/${USERNAME}.crt --client-key=${CERT_DIR}/${USERNAME}.key
}

create_user "namespace1-admin-user" "admin-namespace1"
create_user "namespace1-developer-user" "developers-namespace1"

create_user "cluster-admin-user" "devops-admin"
create_user "cluster-edit-user" "devops"
create_user "cluster-view-user" "devops-readonly"

kubectl create namespace namespace1

kubectl apply -f secrets-only-role.yaml
kubectl apply -f namespace-admin-role.yaml
kubectl apply -f admin-cluster-role.yaml
kubectl apply -f edit-cluster-role.yaml
kubectl apply -f view-cluster-role.yaml

kubectl apply -f secrets-only-rolebinding.yaml
kubectl apply -f namespace-admin-rolebinding.yaml
kubectl apply -f admin-cluster-rolebinding.yaml
kubectl apply -f edit-cluster-rolebinding.yaml
kubectl apply -f view-cluster-rolebinding.yaml

# Создаём контексты для админа неймспейса
kubectl config set-context namespace1-admin-context --cluster=minikube --namespace=namespace1 --user=namespace1-admin-user

# Создаём контексты для разработчика неймспейса
kubectl config set-context namespace1-developer-context --cluster=minikube --namespace=namespace1 --user=namespace1-developer-user

# Создаём контексты для админа кластера
kubectl config set-context cluster-admin-context --cluster=minikube --user=cluster-admin-user

# Создаём контексты для редактора кластера
kubectl config set-context cluster-edit-context --cluster=minikube --user=cluster-edit-user

# Создаём контексты для просмотра кластера
kubectl config set-context cluster-view-context --cluster=minikube --user=cluster-view-user
