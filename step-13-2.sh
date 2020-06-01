#!/bin/bash

virt-customize -a "CentOS-7-x86_64-GenericCloud.qcow2" --uninstall cloud-init --ssh-inject root:file:sshkey.pub --selinux-relabel --install haproxy --install bind-utils --copy-in haproxy.cfg:/etc/haproxy/

sleep 30
virt-install --import --name gls-lb --disk "CentOS-7-x86_64-GenericCloud.qcow2" --memory 2048 --cpu host --vcpus 3 --os-type linux --os-variant rhel7-unknown --network network=default,model=virtio --noreboot --noautoconsole 
virsh start gls-lb
while true
do
  HAIP=$(virsh domifaddr "gls-lb" | grep ipv4 | head -n1 | awk '{print $4}' | cut -d'/' -f1)
  HAMAC=$(virsh domifaddr "gls-lb" | grep ipv4 | head -n1 | awk '{print $2}')
  test "$?" -eq "0" -a -n "$HAIP"  && { echo "$HAIP"; break; }
done

virsh net-update default add-last ip-dhcp-host --xml "<host mac='$HAMAC' ip='$HAIP'/>" --live --config
echo "$HAIP lb.gls.test" "api.gls.test" "api-int.gls.test" >> /etc/hosts

systemctl restart libvirtd
systemctl reload NetworkManager



