#=======================================
#=== destroyDeployment.sh
#===
#=== Destroys a deployment
#===
#=======================================

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required (The deployment identifier), $# provided"

export DEPLOYMENT_IDENTIFIER=$1

echo "#Execute the following commands"
cfn-list-stacks | grep GitEvery4 | awk '{print$3}' | grep \- | grep "$DEPLOYMENT_IDENTIFIER" | sort | xargs -I {} bash -c 'echo cfn-delete-stack {} --force'

