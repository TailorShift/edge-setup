#!/bin/bash

# Script for port-forwarding from host to guest vm.
# See https://wiki.libvirt.org/Networking.html#Forwarding_Incoming_Connections
# Please this script under /etc/libvirt/hooks/qemu
# In order to create rules to other VMs, just duplicate the below block and configure
# it accordingly.
if [ "${1}" = "edge" ]; then

   # Update the following variables to fit your setup
   GUEST_IP=192.168.122.102
   GUEST_PORT=8080
   HOST_PORT=8080

   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; then
    /sbin/iptables -D FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
    /sbin/iptables -t nat -D PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
    /sbin/iptables -I FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
    /sbin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
   fi
fi