#!/bin/bash

if [ -z "${PROJECT}" ]; then
  echo please set PROJECT env
fi

GCE_PD_SA_NAME=gce-pd-csi-sa

# Install CSI Common Component
git clone https://github.com/kubernetes-csi/external-snapshotter -b v2.1.1
kubectl apply -f external-snapshotter/config/crd
kubectl apply -f external-snapshotter/deploy/kubernetes/ -R

# Install GCE PersistentDisk CSI Driver
git clone https://github.com/kubernetes-sigs/gcp-compute-persistent-disk-csi-driver
git checkout ac1f8c -C gcp-compute-persistent-disk-csi-driver/
kubectl create namespace gce-pd-csi-driver
kubectl apply -k ./gcp-compute-persistent-disk-csi-driver/deploy/kubernetes/overlays/stable



IAM_NAME=${GCE_PD_SA_NAME}@${PROJECT}.iam.gserviceaccount.com

gcloud iam service-accounts create ${GCE_PD_SA_NAME} --project ${PROJECT}

gcloud iam roles create gcp_compute_persistent_disk_csi_driver_custom_role --quiet \
  --project ${PROJECT} --file ./gcp-compute-persistent-disk-csi-driver/deploy/gcp-compute-persistent-disk-csi-driver-custom-role.yaml

gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${IAM_NAME} --role roles/compute.storageAdmin
gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${IAM_NAME} --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${IAM_NAME} --role projects/${PROJECT}/roles/gcp_compute_persistent_disk_csi_driver_custom_role

gcloud iam service-accounts keys create ./cloud-sa.json --iam-account ${IAM_NAME} --project ${PROJECT}

kubectl create namespace gce-pd-csi-driver
kubectl -n gce-pd-csi-driver create secret generic cloud-sa --from-file=./cloud-sa.json

rm -f ./cloud-sa.json
rm -rf ./external-snapshotter ./gcp-compute-persistent-disk-csi-driver
