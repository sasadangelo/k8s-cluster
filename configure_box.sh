# install docker v17.03
# reason for not using docker provision is that it always installs latest 
# version of the docker, but kubeadm requires 17.03 or older
echo "==== Configure Box"
echo "====== Install Docker Engine 17.03"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
# run docker commands as vagrant user (sudo not required)
usermod -aG docker vagrant
# install kubeadm
echo "====== Install kubeadm, kubelet, kubectl"
apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat >> /etc/apt/sources.list.d/kubernetes.list << EOL
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOL
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
# kubelet requires swap off
swapoff -a
# keep swap off after reboot
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# ip of this box
IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
# set node-ip
#sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
echo "====== Configure kubelet"
echo "KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" | tee -a /etc/default/kubelet
systemctl restart kubelet
