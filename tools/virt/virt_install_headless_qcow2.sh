#!/bin/bash

sudo virt-install \
  --virt-type kvm \
  --hvm \
  --name learn-chef \
  --vcpus=1 \
  --memory 512 \
  --disk "/var/lib/images/trusty-server-cloudimg-amd64-disk1.img",device=disk,bus=virtio \
  --os-variant "ubuntu14.04" \
  --graphics vnc,password=password  \
  --noautoconsole \
  --network bridge=br0,model=virtio \
  --import
