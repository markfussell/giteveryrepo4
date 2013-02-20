#=================================================
#=== Detect whether the last action version
#=== is the same as the current pulled version.
#=== Return the LOCAL_VERSION if different
#=================================================

export LOCAL_VERSION=`git rev-parse HEAD`

if [[ -e ./temp/nodeinfo/lastaction.txt ]]; then
    export LAST_ACTION=`cat ./temp/nodeinfo/lastaction.txt`
    if [ "${LAST_ACTION}" = "${LOCAL_VERSION}" ]; then
        : #Don't do anything
    else
        echo ${LOCAL_VERSION}
    fi
else
    echo ${LOCAL_VERSION}
fi
