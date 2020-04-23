#!/bin/bash

#crontab -l | { cat; echo "* * * * * TODO > /dev/null 2>&1"; } | crontab -

crontab -l | { cat; echo "*/5 * * * * /var/www/backup/script/en-Database-5min.sh > /dev/null 2>&1"; } | crontab - 
crontab -l | { cat; echo "0 */1 * * * /var/www/backup/script/en-Log-API-1hr.sh > /dev/null 2>&1"; } | crontab -
crontab -l | { cat; echo "0 */1 * * * /var/www/backup/script/en-Database-1hr.sh > /dev/null 2>&1"; } | crontab -
