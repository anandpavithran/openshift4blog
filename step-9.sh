#!/bin/bash
cp tmpws.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable tmpws.service --now
systemctl status tmpws.service
mkdir /opt/openshift4/{ignitions,images,iso}
mv rhcos.iso /opt/openshift4/iso
mv rhcos.raw.gz  /opt/openshift4/images/
firewall-cmd --zone=libvirt --add-port=8080/tcp --permanent
firewall-cmd --reload
