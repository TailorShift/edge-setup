# Edge device onboarding prerequisites

## Install edgedevice vm

The scripts for the RHEL edge installation via libvirt are located in the virt-instll folder. Run it on the host system in order to create a new guest vm.

## Setup device

Enable the systemd services to run the applicatoin containers via podman on startup. For an automated setup run the `init.sh` in the init folder.

## Port forwarding

In order to route traffic from the host to the guest machine, enable the port forwarding. Attention: Run the port forwarding on the host machine, not on the guest. 