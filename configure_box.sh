# install docker latest
# reason for not using docker provision is that it always installs latest
# version of the docker, but kubeadm requires 17.03 or older
echo "==== Configure Box"
echo "====== Install Docker Engine latest"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
apt-get install -y docker.io
# Kubelet uses systemd cfgroup while docker cgroupfs. This disalignment doesn't allow
# to Kubelet to start. This fix the problem.
echo '{"exec-opts": ["native.cgroupdriver=systemd"]}' >> /etc/docker/daemon.json
systemctl restart docker
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
IP_ADDR=`ifconfig enp0s8 | grep inet | awk '{print $2}'| cut -f2 -d:`
# set node-ip
#sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
echo "====== Configure kubelet"
echo "KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" | tee -a /etc/default/kubelet
systemctl restart kubelet
echo "====== Install and configure ntp"
apt-get install -y ntp
sed -i "s/#disable auth/disable auth/g" /etc/ntp.conf
sed -i "s/#broadcastclient/broadcastclient/g" /etc/ntp.conf
service ntp restart
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
locale-gen en_US.UTF-8
/lib/systemd/systemd-sysv-install enable ntp
