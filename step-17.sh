#!/bin/bash
systemctl reload NetworkManager
systemctl restart libvirtd
ssh -i sshkey "lb.gls.test" "systemctl enable haproxy --now"
ssh -i sshkey "lb.gls.test" "systemctl is-active haproxy"
sleep 5
virsh start gls-bootstrap
virsh start gls-master
virsh start gls-worker




