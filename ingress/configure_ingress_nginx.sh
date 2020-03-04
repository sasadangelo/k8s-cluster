SCRIPT_DIR=$( cd $(dirname $0) ; pwd -P )
NGINX_VERSION=0.30.0

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-$NGINX_VERSION/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-$NGINX_VERSION/deploy/static/provider/baremetal/service-nodeport.yaml
kubectl apply -f $SCRIPT_DIR/ingress-nginx.yaml
