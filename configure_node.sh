echo "This is worker"
sudo apt-get update
sudo apt-get install -y sshpass
sudo sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.205.10:/etc/kubeadm_join_cmd.sh .
sudo sh ./kubeadm_join_cmd.sh
