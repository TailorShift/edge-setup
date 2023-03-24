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
    --disk path=”  “, ,format=qcow2 \
    --ram 3072 \
    --memory 4096 \
    --vcpus 2 \
    --network network=integration,mac=mac_address \
    --os-type linux \
    --os-variant=${OS_VARIANT} \
    --cdrom ${ISO_FILE} \
    --boot uefi,loader_ro=yes,loader_type=pflash,nvram_template=/usr/share/edk2/ovmf/OVMF_VARS.fd,loader_secure=no \
    --virt-type kvm \
    --graphics none \
    --wait=-1 \
    --noreboot