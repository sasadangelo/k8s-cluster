echo "==== Configure Worker"
sudo apt-get update
sudo apt-get install -y sshpass
echo "====== Copy join script from the master"
sudo sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.205.10:/etc/kubeadm_join_cmd.sh .
echo "====== Join the cluster"
sudo sh ./kubeadm_join_cmd.sh
