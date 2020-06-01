#!/bin/bash
mkdir /home/VMS
qemu-img create -f qcow2 /home/VMS/bootstrap.img 200G
qemu-img create -f qcow2 /home/VMS/master.img 200G
qemu-img create -f qcow2 /home/VMS/worker.img 200G

virt-install --name gls-bootstrap --disk "/home/VMS/bootstrap.img" --ram 16000 --cpu host --vcpus 6 --os-type linux --os-variant rhel7-unknown  --network network=default,model=virtio --noreboot --noautoconsole --location /opt/openshift4/iso/rhcos.iso,kernel=images/vmlinuz,initrd=images/initramfs.img --extra-args "nomodeset rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.inst.image_url=http://192.168.122.1:8080/openshift4/images/rhcos.raw.gz coreos.inst.ignition_url=http://192.168.122.1:8080/openshift4/ignitions/bootstrap.ign" --boot hd,network,menu=on

virt-install --name gls-master --disk "/home/VMS/master.img" --ram 16000 --cpu host --vcpus 6 --os-type linux --os-variant rhel7-unknown  --network network=default,model=virtio --noreboot --noautoconsole --location /opt/openshift4/iso/rhcos.iso,kernel=images/vmlinuz,initrd=images/initramfs.img --extra-args "nomodeset rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.inst.image_url=http://192.168.122.1:8080/openshift4/images/rhcos.raw.gz coreos.inst.ignition_url=http://192.168.122.1:8080/openshift4/ignitions/master.ign" --boot hd,network,menu=on

virt-install --name gls-worker --disk "/home/VMS/worker.img" --ram 16000 --cpu host --vcpus 6 --os-type linux --os-variant rhel7-unknown  --network network=default,model=virtio --noreboot --noautoconsole --location /opt/openshift4/iso/rhcos.iso,kernel=images/vmlinuz,initrd=images/initramfs.img --extra-args "nomodeset rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.inst.image_url=http://192.168.122.1:8080/openshift4/images/rhcos.raw.gz coreos.inst.ignition_url=http://192.168.122.1:8080/openshift4/ignitions/worker.ign" --boot hd,network,menu=on
