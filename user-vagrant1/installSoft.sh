#!/bin/bash
cd 
softpath=`pwd`
echo 'will to install soft: expect ansible VirtualBox vagrant nfs..'
softs='expect ansible VirtualBox vagrant nfs'
for soft in $softs
do
    if_install=`whereis $soft |grep '/'`
    if_ok=`whereis $soft|grep man`
    if [[ $if_install ==  "" ]] && [[ $soft == "ansible" ]];then
      echo $soft is installing;
      wget http://soft.dev.aifang.com/ansible-1.4.4.tar.gz
      tar zxvf ansible-1.4.4.tar.gz
      cd ansible-1.4.4
      sudo python setup.py install
      sleep 5
      sudo apt-get install python-jinja2
      sleep 5
      sudo apt-get install python-yaml
      sleep 5
      cd ..
    elif [[ $if_install ==  "" ]] && [[ $soft == "expect" ]];then
         echo $soft is installing;
         sudo apt-get install $soft
    elif [[ $if_install ==  "" ]] && [[ $soft == "VirtualBox" ]];then
      echo $soft is installing;
      wget http://soft.dev.aifang.com/virtualbox-4.3_4.3.6-91406~Ubuntu~precise_amd64.deb
      sudo dpkg -i virtualbox-4.3_4.3.6-91406~Ubuntu~precise_amd64.deb
      sleep 5
    elif [[ $if_ok ==  "" ]] && [[ $soft == "nfs" ]];then
      echo $soft is installing;
      sudo apt-get install nfs-common
      sleep 10
      sudo apt-get install nfs-kernel-server
      sleep 5
    elif [[ $if_install ==  "" ]];then
      echo $soft is installing;
      wget http://soft.dev.aifang.com/vagrant_1.4.3_x86_64.deb
      sudo dpkg -i vagrant_1.4.3_x86_64.deb
      sleep 5
    else
      echo $soft is installed
    fi
done
