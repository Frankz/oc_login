function oc-login () {
  #echo "# Test line to delete"
  #echo 
  # @Param $1 = OCP_HOST OCP server api hostname
  # @Param $2 = OCP_PORT OCP server api port 
  # @Param $3 = OCP_USER OCP client username
  # @Param $4 = OCP_PASS OCP client password
  echo "OCP_HOST $OCP_HOST"
  OCP_HOST=${1:-localhost}
  OCP_PORT=${2:-8443}
  OCP_USER=${3:-myuser}
  OCP_PASS=${4:-mypass}
  #echo ${OC_HOST}
  echo oc login ${OCP_HOST}:${OCP_PORT} --username=${OCP_USER} --password=${OCP_PASS}
  
}

## detect if being sourced and
## export if so else execute
## main function with args
if [[ /usr/local/bin/bpkg-template != /usr/local/bin/bpkg-template ]]; then
  export -f oc-login $@
else
  oc-login "$@"
fi
