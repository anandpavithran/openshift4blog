#!/bin/bash
sleep 5
HAIP=$(virsh domifaddr "gls-lb" | grep ipv4 | head -n1 | awk '{print $4}' | cut -d'/' -f1)
HAMAC=$(virsh domifaddr "gls-lb" | grep ipv4 | head -n1 | awk '{print $2}')
echo "local=/gls.test/" > /etc/NetworkManager/dnsmasq.d/gls.conf
echo "srv-host=_etcd-server-ssl._tcp.gls.test,etcd-0.gls.test,2380,0,10" >>/etc/NetworkManager/dnsmasq.d/gls.conf
echo "address=/apps.gls.test/$HAIP" >> /etc/NetworkManager/dnsmasq.d/gls.conf

BIP=$(virsh domifaddr "gls-bootstrap" | grep ipv4 | head -n1 | awk '{print $4}' | cut -d'/' -f1)
BMAC=$(virsh domifaddr "gls-bootstrap" | grep ipv4 | head -n1 | awk '{print $2}')
virsh net-update default add-last ip-dhcp-host --xml "<host mac='$BMAC' ip='$BIP'/>" --live --config
echo "$BIP bootstrap.gls.test" >> /etc/hosts

M1IP=$(virsh domifaddr "gls-master" | grep ipv4 | head -n1 | awk '{print $4}' | cut -d'/' -f1)
M1MAC=$(virsh domifaddr "gls-master" | grep ipv4 | head -n1 | awk '{print $2}')
virsh net-update default add-last ip-dhcp-host --xml "<host mac='$M1MAC' ip='$M1IP'/>" --live --config
echo "$M1IP master-1.gls.test" "etcd-0.gls.test" >> /etc/hosts

W1IP=$(virsh domifaddr "gls-worker" | grep ipv4 | head -n1 | awk '{print $4}' | cut -d'/' -f1)
W1MAC=$(virsh domifaddr "gls-worker" | grep ipv4 | head -n1 | awk '{print $2}')
virsh net-update default add-last ip-dhcp-host --xml "<host mac='$W1MAC' ip='$W1IP'/>" --live --config
echo "$W1IP worker-1.gls.test" >> /etc/hosts


