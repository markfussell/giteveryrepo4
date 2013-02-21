# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

PS1="[\u@\h `cat /root/nodeinfo/nodepart.txt`] [\w]\$ "

#================================
#=== Link to new tools
#================================

export EC2_BASE=/opt/ec2-api-tools
#export AWS_CLOUDFORMATION_HOME=/opt/AWSCloudFormation
Ê
export EC2_HOME=$EC2_BASE/
#export PATH=$PATH:$EC2_HOME/bin:$AWS_CLOUDFORMATION_HOME/bin
export PATH=$PATH:$EC2_HOME/bin
Ê
export EC2_URL=https://ec2.amazonaws.com
Ê
#### INSERT YOU KEYS ####
export AWS_ACCESS_KEY=`cat /root/nodeinfo/access_key.txt`
export AWS_SECRET_KEY=`cat /root/nodeinfo/secret_key.txt`
Ê

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
