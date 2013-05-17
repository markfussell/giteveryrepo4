#!/bin/bash
#============================================================
#=== NTP
#============================================================

yes | yum install ntp

echo 1 > /proc/sys/xen/independent_wallclock

cat >> /etc/sysctl.conf <<EOS
# Set independent wall clock time for reboots
xen.independent_wallclock=1
EOS

ntpdate pool.ntp.org

chkconfig ntpd on
/etc/init.d/ntpd start
