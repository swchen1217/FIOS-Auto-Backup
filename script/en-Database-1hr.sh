#!/bin/bash

cd /var/www/backup

TIME=$(date +"%Y-%m-%d-%H-%M-%S")

#rm ./data-tmp/Database-5min/*
mysqldump \
	-u {{USERNAME}} -p{{PASSWORD}} -n -t \
	fios \
	> ./up-tmp/Database-1hr/Database-1hr.sql
openssl rand -base64 64 \
	> ./up-tmp/Database-1hr/key.bin
openssl enc -aes-256-cbc -salt \
	-in ./up-tmp/Database-1hr/Database-1hr.sql \
	-out ./up-tmp/Database-1hr/Database-1hr.sql.enc \
	-pass file:./up-tmp/Database-1hr/key.bin
openssl rsautl -encrypt \
	-inkey ./key/public_key.pem -pubin \
	-in ./up-tmp/Database-1hr/key.bin \
	-out ./up-tmp/Database-1hr/key.bin.enc
rm ./up-tmp/Database-1hr/Database-1hr.sql
rm ./up-tmp/Database-1hr/key.bin
tar -cvf "./up-tmp/"$TIME"-Database-1hr.tar" \
	-C ./up-tmp \
	./Database-1hr/
rm ./up-tmp/Database-1hr/*
cp "./up-tmp/"$TIME"-Database-1hr.tar" /mnt/FIOS_Backup/Database/1hr/
rm "./up-tmp/"$TIME"-Database-1hr.tar"
