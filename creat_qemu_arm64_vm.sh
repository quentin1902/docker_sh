#install tools
apt update
apt install -y qemu-system-arm qemu-system-arm64 qemu-efi qemu-img
#download img
wget https://cloud-images.ubuntu.com/releases/22.04/release-20240319/ubuntu-22.04-server-cloudimg-arm64.img
#resize img
qemu-img resize ubuntu-22.04-server-cloudimg-arm64.img +6G
#add password for start qemu vm
sudo apt install cloud-image-utils
cat >cloud.txt <<EOF
#cloud-config
password: root
chpasswd: { expire: False }
ssh_pwauth: True
EOF
cloud-localds cloud.img cloud.txt
#creat qemu vm, start qemu vm also this cmd
qemu-system-aarch64 -m 8G -cpu cortex-a57 -smp 4 -M virt \
-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd -nographic \
-drive file=ubuntu-22.04-server-cloudimg-arm64.img,format=qcow2 \
-drive file=cloud.img,format=raw 
#login and password
#login:ubuntu
#password:root
#exit qemu vm
#ctl+a,x
