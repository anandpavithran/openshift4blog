#!/bin/bash
yum install tftp-server syslinux -y
firewall-cmd --list-all
firewall-cmd --add-service=tftp --permanent
firewall-cmd --reload
mkdir /var/lib/tftpboot/pxelinux.cfg
mkdir -p /var/lib/tftpboot/openshift4
mv vmlinuz initramfs.img /var/lib/tftpboot/openshift4/
cp -rvf /usr/share/syslinux/*  /var/lib/tftpboot
restorecon -RFv /var/lib/tftpboot/*
systemctl enable tftp
systemctl enable tftp --now
