SCRIPT_DIR=$( cd $(dirname $0) ; pwd -P )
DASHBOARD_VERSION=v2.0.0-beta8

# Deploy the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/$DASHBOARD_VERSION/aio/deploy/recommended.yaml
# Create a service account and gives cluster admin rol
kubectl apply -f $SCRIPT_DIR/dashboard-admin-user.yaml
kubectl apply -f $SCRIPT_DIR/admin-role-binding.yaml
