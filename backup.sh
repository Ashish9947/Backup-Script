#!/bin/bash

BACKUP_DIR=$1
COMP_ALG=$2
FILENAME=$3

touch errors.log

if [ $COMP_ALG = "gzip" ];
then
	tar -czf $FILENAME.tar $BACKUP_DIR 2> errors.log
elif [ $COMP_ALG = "bzip" ];
then
	tar -cjf $FILENAME.tar $BACKUP_DIR 2> errors.log
else
	tar -cf $FILENAME $BACKUP_DIR 2> errors.log
fi

openssl enc -aes-256-cbc -salt -pbkdf2 -in $FILENAME.tar -out $FILENAME -pass file:"password.txt"

rm -r $FILENAME.tar
