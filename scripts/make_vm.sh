if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Usage: $0 <vm_name> <image_url>"
    exit 1
fi

# Some installers:
# debian8 (jessie): http://ftp.nl.debian.org/debian/dists/jessie/main/installer-amd64/
# ubuntu 16.04 (xenial): http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/

vm_name=$1
installer_url=$2

disk_location=$HOME/vm/$vm_name.qcow2 

qemu-img create -f qcow2 "$disk_location" 20G
virt-install \
  --name "$vm_name" \
  --ram 2048 \
  --disk path=$disk_location \
  --vcpus 1 \
  --os-type linux \
  --os-variant generic \
  --network bridge=virbr0 \
  --graphics none \
  --console pty,target_type=serial \
  --location "$installer_url" \
  --extra-args 'console=ttyS0'

# Run `systemctl enable getty@ttyS0` inside the guest to make the console permanent
