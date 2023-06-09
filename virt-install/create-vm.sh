#!/usr/bin/env bash

## Define variables
MEM_SIZE=2048       # Memory setting in MiB
VCPUS=2             # CPU Cores count
OS_VARIANT="rhel9.1" # List with osinfo-query  os
ISO_FILE="/home/atos/edge/edge-img-fdo.iso" # Path to ISO file

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE

virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --cdrom ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --network default \
     --os-variant=${OS_VARIANT} \
     --boot=uefi  --graphics vnc,listen=0.0.0.0