# Entropy Upgrade

 Installs haveged, modifies settings for greater entropy generation, and sets /random blocking to 1024 to ensure cryptographic function are not run when entropy is low. This script sets a fairly high minimum entropy level it can be lowered if you feel that a lower value is acceptable to your security standards.

## Installation
     git clone https://github.com/osteth/entropy-upgrade.git
     cd entropy-upgrarde
     chmod +x entropy-upgrade.sh
     ./entropy-upgrade.sh
## Notes
To check your systems current entropy level use the command: 
    
    cat /proc/sys/kernel/random/entropy_avail 

If entropy upgrade installed successfully your entropy level should be ~3000+.  If your entropy level did not raise after running entropy upgrade run the following command:
    
    sysctl -p
    
This command should be launched upon reboot because the script adds the command to /etc/rc.local  I have noticed that this does not work on all systems.  If anyone knows a better way to lauch the sysctl -p command for better dependability please let me know!

This will not work on hypervisors that do not have hardware passthrough such as openVZ but has been tested and confirmed working on KVM instances.