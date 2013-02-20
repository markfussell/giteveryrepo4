#! /bin/bash
#================================
#=== Simple worker example
#================================

export ME=`basename $0`
export LOG=/root/log/${ME}_log.txt
export ERROR=/root/log/${ME}_error.txt
export START_TSS="`date +%Y%m%d-%H%M%S`"

export CURRENTACTION_FILE=./.temp/nodeinfo/currentaction.txt

bash_ifexist () { [[ -f "$1" ]] && bash "$1"; }

mkdir -p /root/log/

exec 1>> ${LOG}
exec 2>> ${ERROR}

echo "${ME}: Start  ${START_TSS}" >> ${LOG}

export REPOS=`find /root/gitrepo/ -maxdepth 1 -mindepth 1 `
for REPO in ${REPOS}; do
    pushd ${REPO}
        if [[ -e ${CURRENTACTION_FILE} ]]; then
            : #Don't do anything until the current action completes
        else
            git pull

            bash_ifexist bin/work/common/work.sh
            bash_ifexist bin/work/part/`cat /root/nodeinfo/nodepart.txt`/work.sh
            bash_ifexist bin/work/stack/`cat /root/nodeinfo/stackkey.txt`/work.sh
            bash_ifexist bin/work/stack/`cat /root/nodeinfo/stackkey.txt`/part/`cat /root/nodeinfo/nodepart.txt`/work.sh
        fi
    popd
done


export FINISH_TSS="`date +%Y%m%d-%H%M%S`"
echo "${ME}: Finish ${FINISH_TSS}" >> ${LOG}

