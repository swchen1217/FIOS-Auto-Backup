#!/bin/bash

cd /var/www/backup

TIME=$(date +"%Y-%m-%d-%H-%M-%S")
DATE=$(date +"%Y-%m-%d")

mkdir ./up-tmp/Log-API-1hr/logs

if [ -f "/var/www/fsshLunchSystem/storage/logs/laravel/laravel-"$DATE".log" ]; then
   cp "/var/www/fsshLunchSystem/storage/logs/laravel/laravel-"$DATE".log" ./up-tmp/Log-API-1hr/logs/ 
fi
if [ -f "/var/www/fsshLunchSystem/storage/logs/login/login-"$DATE".log" ]; then
   cp "/var/www/fsshLunchSystem/storage/logs/login/login-"$DATE".log" ./up-tmp/Log-API-1hr/logs/
fi
if [ -f "/var/www/fsshLunchSystem/storage/logs/money/money-"$DATE".log" ]; then
   cp "/var/www/fsshLunchSystem/storage/logs/money/money-"$DATE".log" ./up-tmp/Log-API-1hr/logs/
fi
if [ -f "/var/www/fsshLunchSystem/storage/logs/order/order-"$DATE".log" ]; then
   cp "/var/www/fsshLunchSystem/storage/logs/order/order-"$DATE".log" ./up-tmp/Log-API-1hr/logs/
fi
if [ -f "/var/www/fsshLunchSystem/storage/logs/pswd/pswd-"$DATE".log" ]; then
   cp "/var/www/fsshLunchSystem/storage/logs/pswd/pswd-"$DATE".log" ./up-tmp/Log-API-1hr/logs/
fi

tar -cvf ./up-tmp/Log-API-1hr/logs.tar \
	-C ./up-tmp/Log-API-1hr \
	./logs/

openssl rand -base64 64 \
    > ./up-tmp/Log-API-1hr/key.bin
openssl enc -aes-256-cbc -salt \
    -in ./up-tmp/Log-API-1hr/logs.tar \
    -out ./up-tmp/Log-API-1hr/logs.tar.enc \
    -pass file:./up-tmp/Log-API-1hr/key.bin
openssl rsautl -encrypt \
    -inkey ./key/public_key.pem -pubin \
    -in ./up-tmp/Log-API-1hr/key.bin \
    -out ./up-tmp/Log-API-1hr/key.bin.enc

rm ./up-tmp/Log-API-1hr/key.bin
rm ./up-tmp/Log-API-1hr/logs.tar
rm -r ./up-tmp/Log-API-1hr/logs

tar -cvf "./up-tmp/"$TIME"-Log-API-1hr.tar" \
    -C ./up-tmp \
    ./Log-API-1hr/

rm ./up-tmp/Log-API-1hr/*
cp "./up-tmp/"$TIME"-Log-API-1hr.tar" /mnt/FIOS_Backup/Log-API/1hr/
rm "./up-tmp/"$TIME"-Log-API-1hr.tar" 

