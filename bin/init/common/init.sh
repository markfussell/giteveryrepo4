

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

