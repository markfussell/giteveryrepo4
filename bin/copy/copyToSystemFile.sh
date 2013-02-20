#=======================================
#=== copyToSystemFile.sh
#===
#=== Copy files or directories from
#=== this repository to a system location
#===
#=== The parameter/s should be the system location
#===
#=======================================


export REPO_ROOT_DIR=`git rev-parse --show-toplevel`/
export COMP_PATH=${REPO_ROOT_DIR}it/comp/

export HOST_KEY=`hostname | tr '[:upper:]' '[:lower:]'`
export HOST_DIR=${COMP_PATH}${HOST_KEY}/

export DATE=`date +%Y%m%d-%H%M%S`


for FILEORDIR_PATH in "$@"; do

    export SOURCE=${HOST_DIR}${FILEORDIR_PATH}

    #File or directory... currently just files

    for SOURCE_FILE_PATH in $(find ${SOURCE}); do
        DEST_FILE_PATH=${SOURCE_FILE_PATH#$HOST_DIR}
        DEST_DIR_PATH=`dirname ${DEST_FILE_PATH}`
        DEST_BACKUP=${DEST_FILE_PATH}.${DATE}

        echo "${SOURCE_FILE_PATH} -> ${DEST_FILE_PATH}"

        if [[ -e ${DEST_FILE_PATH} ]]; then
            echo "Destination exists"
        else
            mkdir -p "${DEST_DIR_PATH}"
            touch ${DEST_FILE_PATH}
        fi

        DIFF=`diff ${SOURCE_FILE_PATH} ${DEST_FILE_PATH}`
        if [ "$DIFF" != "" ]; then
            echo "Copying from '${SOURCE_FILE_PATH}' to '${DEST_FILE_PATH}'"


            mkdir -p "${DEST_DIR_PATH}"
            cp ${DEST_FILE_PATH} ${DEST_BACKUP}
            cp ${SOURCE_FILE_PATH} ${DEST_FILE_PATH}
        fi

    done

done

