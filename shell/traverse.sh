#!/bin/bash
DIR=`find $1`;
for FILE_LIST in $DIR
do 
	if [ $FILE_LIST == '.' ] || [ $FILE_LIST == '..' ]
	then
		continue;
	else
#		sed -i.bak 's/unix:\/var\/run\/php5-fpm\.sock/127\.0\.0\.1:9000/g' $FILE_LIST;
		sed -i.bak 's/\/vagrant\//\/Users\/jackdong\/vagrant-workspace1\//g' $FILE_LIST;
	fi
done

