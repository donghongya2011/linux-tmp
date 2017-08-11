#!/bin/bash

vbox=`ps -ef |grep -i vbox|grep -v "grep" |awk '{print $2}'`
echo "-----kill vbox process-----"
if [ ! -n "$vbox" ];then
    echo "-----no vbox process run-----"
else
    echo "-----kill vbox process : -----"
    echo $vbox
    sudo kill -9 $vbox
fi

