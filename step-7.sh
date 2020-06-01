#!/bin/bash
mv rhcos*kernel-x86_64 vmlinuz
mv rhcos*initramfs.x86_64.img initramfs.img
mv rhcos*installer.x86_64.iso rhcos.iso
mv rhcos*raw.gz rhcos.raw.gz
