#!/usr/bin/env bash

## Define variables
MEM_SIZE=2048       # Memory setting in MiB
VCPUS=2             # CPU Cores count
OS_VARIANT="rhel9.1" # List with osinfo-query  os
ISO_FILE="/home/atos/bare-metal.iso" # Path to ISO file

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE


sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --network bridge=virbr0 \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --extra-args="console=ttyS0" \
     --boot=uefi \
     --extra-args="inst.ks=http://192.168.122.78:8090/kickstart.ks console=tty0 console=ttyS0,115200n8"