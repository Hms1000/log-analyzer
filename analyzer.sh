#!/bin/bash

# log file
LOG_FILE=/var/log/auth.log

# date and time variable
DATE=$(date +%Y-%m-%d)

# list of the IP addresses that failed login
FAILED_IPs=failed_ips_$DATE.txt

# ip address regex pattern
IP_ADDRESS_REGEX=\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b


# number of failed login attempts by each ip address
login_attempts=$(grep -i "failed password" $LOG_FILE | grep -oE "$IP_ADDRESS_REGEX" | sort | wc -l)


# checking if the number of failed attempts is more than 5 and compressing old reports
if [ $login_attempts -gt 5 ]; then
    echo "Failed IP Addresse(s)"
    
    grep -i "failed password" $LOG_FILE | grep -oE "$IP_ADDRESS_REGEX" | sort > failed_ips.txt

    cat $FAILED_IPs

    tar -czvf $FAILED_IPs.tar.gz $FAILED_IPs
fi

# ensuring that each time we have a new report it is automatically commited to github
git_commit() {
    if [ -f $FAILED_IPs ];then
    git add $FAILED_IPs
    git commit -m "daily failed logins report commit"
else
    echo "$FAILED_IPs does not exist"
    fi
}

git_commit

