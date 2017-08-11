#!/bin/bash

sudo -k

# . ./const_def.sh

basepath=$(cd `dirname $0`; pwd)
exec_name=`basename $0`
# echo $basepath/$exec_name;
file_type=`ls -l $basepath/$exec_name |awk -F' ' '{print substr($1,1,1)}'`
# echo $file_type;
if [ $file_type = "l" ];then
	basepath=`readlink $basepath/$exec_name|awk -F'/' '{res="";for(i=1;i<NF;i++){res=res$i;if(i<NF-1){res=res"/";}}print res;}'`;
fi
# echo $basepath;
# exit;

. $basepath/const_def.sh

#echo $dirname
#exit

action=reload

helper="\n
usage :\n\n
vguser [ reload | halt | destroy | up ]\n\n
reload : 关机重启后需要启动vagrant\n\n
halt : 停止运行vagrant\n\n
destroy : 清理已经安装的vagrant，一般在安装过程中报错的时候运行\n\n
up : 重新安装vagrant，一般在destroy之后运行\n\n
pull : 不定时的会解决环境当中的各种hotfix，用来更新安装版本\n\n
install : 在未安装成功的情况下，可以反复使用\n\n
--------------------------------------\n\n
Q&A\n\n
Q1. 安装过程中有报错怎么办？\n\n
1. vguser destroy\n\n
2. vguser up\n\n
Q2. 环境有更新怎么办？如何解决安装更新？\n\n
1. vguser pull\n\n
2. vguser destroy\n\n
3. vguser up\n\n
Q3. 遇到需要更新vagrant nginx配置\n\n
1. vguser pull\n\n
2. vguser push nginx\n\n
"

if [ ! -n "$1" ];then
    echo -e $helper
    exit
else
    if [ -f $basepath/$wp_fname ];then
        dirname=`cat $basepath/$wp_fname`
    else
        read -p "enter your workspace path : " dirname
        if [ -d "$dirname" ];then
            echo $dirname > $basepath/WORKPATH
        else
            echo "目录不存在,正在创建目录"
            mkdir -p $dirname 
        fi
    fi

# 仅仅更新nginx配置
    if [ $1 = "push" ] && [ -n "$2" ];then
        if [ $2 = "nginx" ];then
            echo `cat ~/.ssh/id_rsa.pub` > ~/.ssh/authorized_keys
	    expect $basepath/key.exp
            ansible-playbook -vv -i $basepath/provisioning/hosts $basepath/provisioning/deploy-ng.yml
            exit
        fi
    fi

    if [ $1 = "reload" ];then
        bash $basepath/kill_80_port.sh
        info=`uname`
        if [[ $info == "Linux" ]];then
        bash $basepath/installSoft.sh
        fi
        cd $dirname
        action=reload
    elif [ $1 = "halt" ];then
        action=halt
    elif [ $1 = "destroy" ];then
        action=destroy
        bash $basepath/kill_80_port.sh
        bash $basepath/kill_vb_port.sh
    elif [ $1 = "up" ];then
        rm -rf $dirname/Vagrantfile
        rm -rf $dirname/provisioning
        cp $basepath/Vagrantfile $dirname/Vagrantfile
        cp -r $basepath/provisioning $dirname/provisioning
        dirname1=${dirname//\//\\/} 
        info=`uname`
	if [[ $info == "Linux" ]];then
        sed -i "s/replace_work/${dirname1}/g" `grep 'replace_work' -rl ${dirname}/Vagrantfile`
        bash $basepath/installSoft.sh
        else
        sed -i '' "s/replace_work/${dirname1}/g" ${dirname}/Vagrantfile
	fi
        if [ ! -d "${dirname}/logs/nginx" ];then
            mkdir -p ${dirname}/logs/nginx 
        fi
        action=up
    elif [ $1 = "uninstall" ];then
        action=destroy
    elif [ $1 = "pull" ];then
        cd $basepath
        git pull --rebase origin master
        exit
    elif [ $1 = "install" ];then
        bash $basepath/getUserSite.sh
        exit
    elif [ $1 = "ssh" ];then
	sudo -S su root -c "cd $dirname;vagrant ssh;"
        exit;
    else
        echo -e $helper
        exit
    fi
fi

sudo su root -c "\
cd $dirname;\
echo '-----$action user vagrant start-----';\
vagrant $action;\
echo '-----$action user vagrant end-----';"
if [ $1 = "reload" ];then
    expect $basepath/startService.exp
elif [ $1 = "destroy" ];then
    if [ -d "${dirname}/logs/nginx" ];then
        rm -rf ${dirname}/logs/nginx/*
    if [ -d "${dirname}/jockjs" ];then
        rm -rf ${dirname}/jockjs
    fi
    if [ ! -d "${dirname}/jockjs" ];then
        mkdir ${dirname}/jockjs
    fi
    fi
fi
if [ $1 = "uninstall" ];then
	sudo su root -c "\
		echo '-----remove vagrant workspace start-----';\
		cd $dirname;\
		vagrant box remove user-vagrant;\
		rm -rf ./* ./.[^.]*;\
		cd ~;\
		rm -rf .vagrant.d;\
		rm -rf VirtualBox\ VMs;\
                rm -rf $basepath/$wp_fname;\
		echo '-----remove vagrant workspace end-----';"
fi

who=`whoami`
sudo chown -R ${who} ${dirname}
