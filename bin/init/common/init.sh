#================================
#=== Setup CFN credentials
#================================

mkdir -p ~/.aws/
echo -e "AWSAccessKeyId=`cat /root/nodeinfo/access_key.txt`\nAWSSecretKey=`cat /root/nodeinfo/secret_key.txt`\n" > ~/.aws/awscfn_config.txt
chmod 600 ~/.aws/awscfn_config.txt

#================================
#=== Get latest tools
#================================

pushd /opt
wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
wget https://s3.amazonaws.com/cloudformation-cli/AWSCloudFormation-cli.zip
Ê
unzip ec2-api-tools.zip
unzip AWSCloudFormation-cli.zip
Ê
ln -sf /opt/ec2-api-tools-* /opt/ec2-api-tools
ln -sf /opt/AWSCloudFormation-1* /opt/AWSCloudFormation

popd

#================================
#=== Setup link to new tools
#================================

cp ./bin/init/common/.bashrc /root/.bashrc
source /root/.bashrc

#================================
#=== Have a preference that crons
#=== all go through a single file
#================================

mkdir -p /root/bin
cp ./bin/init/common/cron_1m.sh /root/bin/cron_1m.sh
chmod +x /root/bin/cron_1m.sh

cat <<EOS > /var/spool/cron/root
MAILTO=""

* * * * *  /root/bin/cron_1m.sh
EOS


#=======================================
#=== Do more specific initialization
#=======================================

include () { if [[ -f "$1" ]]; then source "$1"; else echo "Skipped missing: $1"; fi }

include bin/init/part/`cat /root/nodeinfo/nodepart.txt`/init.sh
include bin/init/stacktype/`cat /root/nodeinfo/stacktype.txt`/init.sh
include bin/init/stacktype/`cat /root/nodeinfo/stacktype.txt`/part/`cat /root/nodeinfo/nodepart.txt`/init.sh


