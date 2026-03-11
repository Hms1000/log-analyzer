#!/bin/bash

login_attempts=$(grep -i "failed password" /var/log/auth.log | grep -oE "[0-9].[0-9].[0-9].[0-9]" | wc -l)

if [ $login_attempts -gt 5 ]; then
    echo "Failed IP Addresse(s)"
    awk "[0-9].[0-9].[0-9].[0-9]"
    
    tar -czvf old_log.tar.gz auth.log
fi

git_commit() {
    git add /var/log/auth.log
    git commit -m "daily report commit"
}

git_commit
