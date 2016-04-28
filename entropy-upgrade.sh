#!/bin/bash
 
# Title: entropy-upgrare
# Author: Seth Wahle
# Contact: Seth [at] cyberdonix.com  Twitter: @SethWahle
 
# Run this script as sudo
 
# Installs haveged and modifies settings for greater entropy and sets /random blocking to 1024 to en$
# when entropy is low. This script sets a fairly high minimum entropy level it can be lowered if
# you feel that a lower value is acceptable to your security standards.
 
# Tested and confirm working on Debian 8
 
apt-get update
apt-get install haveged
 
#Appends new entropy settings to the end of /ect/sysctl.conf
echo "Installing new SYSCTL entropy setting"
echo "#keep entropy pool filled" >> /etc/sysctl.conf
echo kernel.random.write_wakeup_threshold = 3584 >> /etc/sysctl.conf
echo "#Lock /random  if it falls below 1024 for security" >> /etc/sysctl.conf
echo kernel.random.read_wakeup_threshold = 1024 >> /etc/sysctl.conf
 
#Appends new setting to the haveged config file
echo "Installing new HAVEGED setting"
 
 
echo "# Configuration file for haveged" > /etc/default/haveged
echo "# Options to pass to haveged:" >> /etc/default/haveged
echo "#   -w sets low entropy watermark (in bits)" >> /etc/default/haveged
echo 'DAEMON_ARGS="-w 3584"' >> /etc/default/haveged
 
#restarts haveged to apply settings
echo "Applying setting and restarting HAVEGED"
/etc/init.d/haveged restart
 
#Appends a "sysctl -p" before exit0 in /etc/rc.local to make the system reapply sysctl.conf settings$
sudo sed -i '/^exit 0/isysctl -p' /etc/rc.local
sysctl -p
echo "============  NOTICE: Please Reboot for changes to take effect  =============="