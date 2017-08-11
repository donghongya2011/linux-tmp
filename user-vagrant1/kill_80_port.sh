#!/bin/bash

pid=`sudo lsof -i :80 |grep -i 'listen'|awk '{print $2}'`
echo "-----kill 80 port process-----"
if [ ! -n "$pid" ];then
    echo "-----no 80 port process run-----"
else
    echo "-----current 80 port pid(s) : -----"
    echo $pid
    sudo kill -9 $pid
fi

