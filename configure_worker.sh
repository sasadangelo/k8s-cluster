MASTER_IP=$1

echo "==== Configure Worker. Master IP: $MASTER_IP"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y sshpass
echo "====== Copy join script from the master"
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@$MASTER_IP:/etc/kubeadm_join_cmd.sh .
echo "====== Join the cluster"
sh ./kubeadm_join_cmd.sh
