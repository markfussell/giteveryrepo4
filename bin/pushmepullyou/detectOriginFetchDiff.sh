#=================================================
#=== Detect whether the version of the origin
#=== is the same as the local version.
#=== Return the ORIGIN_VERSION if different
#=================================================

git fetch

export ORIGIN_VERSION=`git rev-parse origin/master`
export LOCAL_VERSION=`git rev-parse HEAD`

if [ "${ORIGIN_VERSION}" = "${LOCAL_VERSION}" ]; then
    : #Don't do anything
else
    echo ${ORIGIN_VERSION}
fi
