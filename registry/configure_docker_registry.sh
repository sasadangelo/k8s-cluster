DOCKER_REGISTRY_SECRET_NAME="docker-registry-secret"
DOCKER_REGISTRY_SERVER=""
DOCKER_REGISTRY_USER=""
DOCKER_REGISTRY_USER_PASSWORD=""
DOCKER_REGISTRY_USER_EMAIL=""

###################################################################
# usage
# Input Parameters:
#     none
# Description:
#     This function prints the usage
# Return:
#     None
###################################################################
usage() {
cat - <<-EOM
Usage:
./configure_docker_registry -h
./configure_docker_registry -s SERVER -u USER -p PASSWORD -e EMAIL

Where:
    SERVER the docker registry server (i.e public docker hub is https://index.docker.io/v2/);
    USER the docker registry user;
    PASSWORD the docker registry password;
    EMAIL the user email address;

OPTIONS:
    -h,  --help	get this usage text
EOM
}

###################################################################
# parse_parms
# Input Parameters:
#     none
# Description:
#     This function validates the input parameters.
# Return:
#     None
###################################################################
parse_parms() {
    local CPARM

    while [ $# -gt 0 ]; do
        CPARM=$1;
        shift
        case ${CPARM} in
        -h | --help)
            usage
            exit 0
        ;;
        -s)
            DOCKER_REGISTRY_SERVER=$1; shift
        ;;
        -u)
            DOCKER_REGISTRY_USER=$1; shift
        ;;
        -p)
            DOCKER_REGISTRY_USER_PASSWORD=$1; shift
        ;;
        -e)
            DOCKER_REGISTRY_USER_EMAIL=$1; shift
        ;;
        *)
            echo "ERROR: Invalid argument $CPARM"
            usage
            exit 1
        ;;
        esac
    done
    [ -z "${DOCKER_REGISTRY_SERVER}" ] && { echo "ERROR: docker registry server MUST be specified!"; usage; exit 1; }
    [ -z "${DOCKER_REGISTRY_USER}" ] && { echo "ERROR: docker registry user MUST be specified!"; usage; exit 1; }
    [ -z "${DOCKER_REGISTRY_USER_PASSWORD}" ] && { echo "ERROR: docker registry user password MUST be specified!"; usage; exit 1; }
    [ -z "${DOCKER_REGISTRY_USER_EMAIL}" ] && { echo "ERROR: docker registry user email address MUST be specified!"; usage; exit 1; }
}

###################################################################
# Main block
###################################################################
parse_parms "$@"
kubectl create secret docker-registry $DOCKER_REGISTRY_SECRET_NAME --docker-server=$DOCKER_REGISTRY_SERVER --docker-username=$DOCKER_REGISTRY_USER --docker-password=$DOCKER_REGISTRY_USER_PASSWORD --docker-email=$DOCKER_REGISTRY_USER_EMAIL
