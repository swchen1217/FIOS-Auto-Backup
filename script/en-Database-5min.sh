#!/bin/bash

cd /var/www/backup

TIME=$(date +"%Y-%m-%d-%H-%M-%S")

#rm ./data-tmp/Database-5min/*
mysqldump \
	-u laravel -pc8octwQfNDMVT2QU -n -t \
	fios balances orders money_logs \
	> ./up-tmp/Database-5min/Database-5min.sql
openssl rand -base64 64 \
	> ./up-tmp/Database-5min/key.bin
openssl enc -aes-256-cbc -salt \
	-in ./up-tmp/Database-5min/Database-5min.sql \
	-out ./up-tmp/Database-5min/Database-5min.sql.enc \
	-pass file:./up-tmp/Database-5min/key.bin
openssl rsautl -encrypt \
	-inkey ./key/public_key.pem -pubin \
	-in ./up-tmp/Database-5min/key.bin \
	-out ./up-tmp/Database-5min/key.bin.enc
rm ./up-tmp/Database-5min/Database-5min.sql
rm ./up-tmp/Database-5min/key.bin
tar -cvf "./up-tmp/"$TIME"-Database-5min.tar" \
	-C ./up-tmp \
	./Database-5min/
rm ./up-tmp/Database-5min/*
cp "./up-tmp/"$TIME"-Database-5min.tar" /mnt/FIOS_Backup/Database/5min/
rm "./up-tmp/"$TIME"-Database-5min.tar"
