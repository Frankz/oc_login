function oc-login () {
  #echo "# Test line to delete"
  #echo 
  # @Param $1 = OCP_HOST OCP server api hostname
  # @Param $2 = OCP_PORT OCP server api port 
  # @Param $3 = OCP_USER OCP client username
  # @Param $4 = OCP_PASS OCP client password
  if [[ -z $1 ]]; then
    echo "Must include a param with a file to read"
    echo "Search in $HOME/.list.csv"
    if [[ -e $HOME/.list.csv ]]; then
      FILE_TO_READ=$HOME/.list.csv
      echo "Using $FILE_TO_READ"
    else
      echo "There isn't file to read. EXIT"
      return 1
      exit 
    fi
  else
    if [[ -e $1 ]]; then
      :
    else
      echo "The param isn't a file"
      return 1
      exit 
    fi
  fi

  FILE_TO_READ="${1:-$FILE_TO_READ}"
  fileContent=$(_readFile $FILE_TO_READ)
  echo -e $fileContent
  OCP_HOST=$(_hostMenu $fileContent)
  echo "You has been selected \"$OCP_HOST\""

  echo "OCP_HOST $OCP_HOST"
 # OCP_HOST=${1:-localhost}
  OCP_PORT=${2:-443}
  #OCP_USER=${3:-myuser}
  read -p "Insert username: " OCP_USER
  #OCP_PASS=${4:-mypass}
  read -s -p "Insert password:" OCP_PASS
  #echo ${OC_HOST}
  oc login ${OCP_HOST}:${OCP_PORT} --username=${OCP_USER} --password=${OCP_PASS}
  
}

function _hostMenu () {
  read -p "Choose an option: " OPTION
  OPTION=$(echo -e $fileContent | grep ^$OPTION | cut -d"," -f1 | cut -d" " -f3)
  echo $OPTION
}

function _readFile() {
  # @Param $1 filename with path location
  #items_list="$(cat $1)"
  #echo -e $items_list
  FILENAME=$1
  declare -i I=1

  FILENAME=$(_sanitizeFile $FILENAME)
  declare -i LAST_LINE=$(echo "$(cat $FILENAME | wc -l) + 1" | bc)

  if [[ "$@" == "--details" ]]; then
    for LINE in $(cat ${FILENAME})
    do
      TEXT+="$((I++)) | ${LINE}\n"
    done
  else
    for LINE in $(cat ${FILENAME})
    do
      #if [[ $LAST_LINE -eq ]]\
      TEXT+="$((I++))  - ${LINE}\n"
    done
  fi
  echo ${TEXT}
}

function _sanitizeFile() {
  # This functions remove windows carraige return and normalize all for *unix
  # @Param $1 File with path
  echo -e $1  | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g'
}


## detect if being sourced and
## export if so else execute
## main function with args
if [[ /usr/local/bin/bpkg-template != /usr/local/bin/bpkg-template ]]; then
  export -f oc-login $@
else
  oc-login "$@"
fi
