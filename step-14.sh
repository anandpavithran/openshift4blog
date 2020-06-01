#!/bin/bash
ssh -i sshkey -o StrictHostKeyChecking=no lb.gls.test true
sleep 5
ssh -i sshkey "lb.gls.test" "setsebool -P haproxy_connect_any=1"
ssh -i sshkey "lb.gls.test" "semanage port -a -t http_port_t -p tcp 6443"
ssh -i sshkey "lb.gls.test" "semanage port -a -t http_port_t -p tcp 22623"
ssh -i sshkey "lb.gls.test" "systemctl enable haproxy --now"
ssh -i sshkey "lb.gls.test" "systemctl is-active haproxy"



