echo "==== Configure Dashboard"
SCRIPT_DIR=$( cd $(dirname $0) ; pwd -P )
DASHBOARD_VERSION=v2.0.0-beta8

# Deploy the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/$DASHBOARD_VERSION/aio/deploy/recommended.yaml
# Create a service account and gives cluster admin rol
kubectl apply -f https://raw.githubusercontent.com/sasadangelo/k8s-cluster/master/dashboard/dashboard-admin-user.yaml
kubectl apply -f https://raw.githubusercontent.com/sasadangelo/k8s-cluster/master/dashboard/admin-role-binding.yaml
