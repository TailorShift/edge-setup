#!/bin/bash

# Script for port-forwarding from host to guest vm.
# See https://wiki.libvirt.org/Networking.html#Forwarding_Incoming_Connections
# Please this script under /etc/libvirt/hooks/qemu
# In order to create rules to other VMs, just duplicate the below block and configure
# it accordingly.
if [ "${1}" = "edge" ]; then

   # Update the following variables to fit your setup
   GUEST_IP=192.168.122.102

   # UI Ports
   GUEST_PORT_1=8080
   HOST_PORT_1=8080

   # Backend (edge proxy) ports
   GUEST_PORT_2=9090
   HOST_PORT_2=9090

   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; 
    # UI
    /sbin/iptables -D FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT_1 -j ACCEPT
    /sbin/iptables -t nat -D PREROUTING -p tcp --dport $HOST_PORT_1 -j DNAT --to $GUEST_IP:$GUEST_PORT_1

    # Backend
    /sbin/iptables -D FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT_2 -j ACCEPT
    /sbin/iptables -t nat -D PREROUTING -p tcp --dport $HOST_PORT_2 -j DNAT --to $GUEST_IP:$GUEST_PORT_2
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
    # UI
    /sbin/iptables -I FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT_1 -j ACCEPT
    /sbin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT_1 -j DNAT --to $GUEST_IP:$GUEST_PORT_1

    # Backend
    /sbin/iptables -I FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT_2 -j ACCEPT
    /sbin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT_2 -j DNAT --to $GUEST_IP:$GUEST_PORT_2
   fi
fi