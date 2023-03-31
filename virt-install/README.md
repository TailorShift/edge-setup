# Create RHEL for Edge guest vm

The virt-install folder contains several scripts to create a guest vm on the Azure host VM, representing the edge device (aka the Fitlet2) deployed in the shop.

Prerequisite is an existing boot image, which is an asset produced by the image-builder. The image-builder is hosted in another guest vm (see https://github.com/TailorShift/image-builder)

Different approaches were taken in order to boot a RHEL for Edge image. The process described in the official Red Hat docs didn't work out initially due to the problems reported in the Slack channel. But in the end we managed to follow the proposed process.

## 1st approach

> create-vm-http-boot.sh

After booting the edge image just produced a black output with random gibberish, we tried to boot the image via HTTP boot (https://www.redhat.com/sysadmin/uefi-http-boot-libvirt). However, this approach failed as well due to connectivity problems between the boot manager and the boot server. Some changes were applied to the libvirt network interfaces, but that didn't solve the problem

## 2nd approach

> create-vm-ks-boot.sh

Now the idea was to boot the edge image with a bare metal image and inject a kickstart file during installation for RHEL for Edge setup. The kickstart file (`kickstart.ks`) was provided by the image builder via a http file server, which was accessible from outside the guest vm. This approach worked and produced a RHEL for Edge installation, however this was not the desired outcome. In order to fully mock the end-to-end process, the goal was to provide a standalone offline image (incl. FDO setup) which can be installed on any edge device seamlessly. 

## 3rd approach

> create-vm.sh

Finally the desired RHEL for Edge installation incl. FDO succeeded with this installation script. Unattended installation isn't possible, but connecting a VNC viewer, the installation is running smoothly. The edge image will contact the manufacturing server during setup, which will create a voucher on the manufacturing server. Once the voucher is distributed to the rendezvous and the owner server, the device can start the onboarding process. 