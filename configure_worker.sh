echo "==== Configure Worker"
apt-get update
apt-get install -y sshpass
echo "====== Copy join script from the master"
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.205.10:/etc/kubeadm_join_cmd.sh .
echo "====== Join the cluster"
sh ./kubeadm_join_cmd.sh
