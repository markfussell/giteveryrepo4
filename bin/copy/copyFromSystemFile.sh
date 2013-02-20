#=======================================
#=== copyFromSystemFile.sh
#===
#=== Copy files or directories from a
#=== system location to this repository
#===
#=== The parameter/s should be the system location
#===
#=======================================


export REPO_ROOT_DIR=`git rev-parse --show-toplevel`/
export COMP_PATH=${REPO_ROOT_DIR}it/comp/

export HOST_KEY=`hostname | tr '[:upper:]' '[:lower:]'`
export HOST_DIR=${COMP_PATH}${HOST_KEY}/

for FILE_PATH in "$@"; do
    export FILE_DIR_PATH=`dirname ${FILE_PATH}`
    export FILE_NAME=`basename ${FILE_PATH}`

    echo "Copying from '${FILE_PATH}' to '${HOST_DIR}${FILE_PATH}'"

    mkdir -p "${HOST_DIR}${FILE_DIR_PATH}"
    cp -r ${FILE_PATH} ${HOST_DIR}${FILE_PATH}
done

