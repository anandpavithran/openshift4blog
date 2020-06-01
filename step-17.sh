#!/bin/bash
systemctl reload NetworkManager
systemctl restart libvirtd
sleep 5
virsh start gls-bootstrap
virsh start gls-master
virsh start gls-worker




