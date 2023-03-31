## Define variables
MEM_SIZE=2048       # Memory setting in MiB
VCPUS=1             # CPU Cores count
OS_VARIANT="rhel9.1" # List with osinfo-query  os
ISO_FILE="/home/atos/edge/edge-img.iso" # Path to ISO file

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE

virt-install \
    --name ${VM_NAME} \
    --disk size=${DISK_SIZE},format=qcow2 \
    --ram 2048 \
    --vcpus 2 \
    --network=network=default,model=virtio \
    --os-variant=${OS_VARIANT} \
    --boot uefi \
    --graphics none