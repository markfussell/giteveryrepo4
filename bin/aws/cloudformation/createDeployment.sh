#=======================================
#=== createDeployment.sh
#===
#=== Creates a new deployment
#===
#=======================================

export TSS=`date +%Y%m%d-%H%M%S`
export KEYNAME=`cat /root/nodeinfo/keyname.txt`
export TEMPLATE_PATH=it/aws/cloudformation

#=======================
#=== Security Groups
#=======================


#===================
#=== testdeployment
#===================

ec2-create-group testdeployment -d  testdeployment
export OWNER=`ec2-describe-group | grep GROUP | head -n 1 | cut -f 3`

#Enable SSH In
ec2-authorize testdeployment -p 22 -s 0.0.0.0/0

#Enable deployment to talk to itself
ec2-authorize testdeployment -o testdeployment -u ${OWNER}

#===================
#=== applbnode
#===================

ec2-create-group applbnode      -d  applbnode
ec2-authorize applbnode -p 80 -s 0.0.0.0/0

#===================
#=== appnode
#===================

ec2-create-group appnode        -d  appnode

#===================
#=== presencenode
#===================

ec2-create-group presencenode   -d  presencenode

#===================
#=== riaknode
#===================

ec2-create-group riaknode       -d  riaknode


#=====================
#=== Stacks
#=====================

export CAPABILITIES='--capabilities CAPABILITY_IAM'
export PARAMETERS="--parameters \"KeyName=${KEYNAME}\""

#for TEMPLATE_NAME in GitEvery4AppServer GitEvery4LbServer GitEvery4RiakServer
for TEMPLATE_NAME in GitEvery4LbServer ; do
    export TEMPLATE_FILE=${TEMPLATE_PATH}/${TEMPLATE_NAME}.template
    export STACK_NAME=${TEMPLATE_NAME}-${TSS}

    cfn-create-stack ${STACK_NAME} --template-file ${TEMPLATE_FILE} ${CAPABILITIES} ${PARAMETERS}
done


