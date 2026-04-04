#!/bin/bash

LOG_FILE=/var/log/auth.log

REPO_DIR=/opt/log-analyzer

DATE=$(date +%Y-%m-%d)

# list of the IP addresses that failed login
FAILED_IPs=$REPO_DIR/reports/failed_ips_$DATE.txt

MALICIOUS_IPs=$REPO_DIR/reports/malicious_ips_${DATE}.txt

# ip address regex pattern
IP_ADDRESS_REGEX=\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b


# list of failed ip addresses
IP_ADDRESSES=$(grep -i "failed password" $LOG_FILE | grep -oE "$IP_ADDRESS_REGEX" | sort)

# write the list to a file
echo "$IP_ADDRESSES" > $FAILED_IPs

echo "DATE - IP - OCCURENCE" > $MALICIOUS_IPs

for IP in $(sort -u $FAILED_IPs);
do COUNT=$(grep -ci "$IP" $FAILED_IPs)
    if [ $COUNT -ge 5 ];then

        echo "Warning!!! Malicious IP Address: ${IP}: ${COUNT} occurence"

        echo "${DATE} - ${IP} - ${COUNT}" >> $MALICIOUS_IPs
    fi
    
done


# ensuring that each time we have a new report it is automatically commited to github
git_commit() {
    if [ -s $MALICIOUS_IPs ];then
        
        tar -czvf $MALICIOUS_IPs.tar.gz $MALICIOUS_IPs
        git add $MALICIOUS_IPs
        git commit -m "daily malicious logins report commit"
    else
        echo "System login attempts are less than 5"
    fi
    
}

git_commit

