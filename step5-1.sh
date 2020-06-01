#!/bin/bash
cp -rvf /root/openshift4blog/{default,haproxy.cfg,install-config.yaml,step*,tmpws.service} /root/project/
cd /root/project
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.4/openshift-client-linux-4.4.4.tar.gz 
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.4/openshift-install-linux-4.4.4.tar.gz 
wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-installer.x86_64.iso 
wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-installer-kernel-x86_64 
wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-installer-initramfs.x86_64.img 
wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-metal.x86_64.raw.gz 
wget https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
du -sh *
mv rhcos-4.4.3-x86_64-installer-kernel-x86_64 vmlinuz
mv rhcos-4.4.3-x86_64-installer-initramfs.x86_64.img initramfs.img
mv rhcos-4.4.3-x86_64-installer.x86_64.iso rhcos.iso
mv  rhcos-4.4.3-x86_64-metal.x86_64.raw.gz rhcos.raw.gz

