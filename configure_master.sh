MASTER_NODE_NAME=$1
MASTER_NODE_SCHEDULABLE=$2
KUBERNETES_VERSION="1.25.4"
CALICO_VERSION="v3.24.5"

echo "==== Configure Master: MASTER_NODE_NAME=$MASTER_NODE_NAME MASTER_NODE_SCHEDULABLE=$MASTER_NODE_SCHEDULABLE"
# ip of this box
IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
# install k8s master
HOST_NAME=$(hostname -s)
echo "====== Initialize the K8s Cluster"
kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=172.16.0.0/16 --kubernetes-version=$KUBERNETES_VERSION
# copying credentials to regular user - vagrant
sudo --user=vagrant mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
# copying credentials to root user
mkdir -p ~/.kube
cp -i /etc/kubernetes/admin.conf ~/.kube/config
echo "====== Install Calico"
# install Calico pod network addon
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/custom-resources.yaml
echo "====== Generate join script"
kubeadm token create --print-join-command 2>/dev/null | tee -a /etc/kubeadm_join_cmd.sh
chmod +x /etc/kubeadm_join_cmd.sh
# required for setting up password less ssh between guest VMs
echo "====== Configure SSH"
sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
service sshd restart
echo "====== Make master node schedulable"
if [ "$MASTER_NODE_SCHEDULABLE" == "true" ]
then
    kubectl taint nodes $MASTER_NODE_NAME node-role.kubernetes.io/control-plane-
fi
