#!/bin/bash

sudo virt-install \
  --virt-type kvm \
  --hvm \
  --name krawls \
  --vcpus=1 \
  --memory 512 \
  --cdrom /iso/debian-8.3.0-amd64-netinst.iso \
  --os-variant debian8 \
  --disk size=20 \
  --graphics vnc,password=password  \
  --noautoconsole \
  --network=network:default
