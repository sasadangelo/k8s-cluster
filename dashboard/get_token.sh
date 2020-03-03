kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep "token:" | cut -f 2 -d ":" | awk '{$1=$1;print}'
