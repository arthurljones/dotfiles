#!/bin/bash

virsh destroy $1
virsh undefine $1
virsh pool-refresh default
virsh vol-delete --pool default $1.qcow2
