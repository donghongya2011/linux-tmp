#!/bin/bash
n=`sudo netstat -ntpl|grep nginx`
if [[ $n == "" ]];then
sudo service nginx start
fi
if [[ ! -d '/home/vagrant/.node_libraries/' ]];then
        mkdir /home/vagrant/.node_libraries/
    if [[ ! -f '/home/vagrant/.node_libraries/uglify-js.js' ]];then
        ln -s /usr/local/lib/node_modules/UglifyJS/uglify-js.js /home/vagrant/.node_libraries/
    fi
fi

cd /home/vagrant/jockjs-config
sudo pkill node
./jockjs start user
./jockjs start touch
./jockjs start pad
