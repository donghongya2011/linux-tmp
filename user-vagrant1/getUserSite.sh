#!/bin/bash

sudo -k

basepath=$(cd `dirname $0`; pwd)

. $basepath/const_def.sh

bash $basepath/kill_80_port.sh

echo 'add softs';
bash $basepath/installSoft.sh
echo 'add softs end'
ls -l $glb_path/$ins_bin > /dev/null 2>&1 
test_path=$?;
sudo su root -c "\
echo '-----add $ins_bin bin start-----';

if [ 0 -eq $test_path ];then 
    rm $glb_path/$ins_bin;
fi
ln -s $basepath/usualdo.sh $glb_path/$ins_bin;

echo '-----add $ins_bin bin end-----';"

echo -e "\n\n#######！！！工作目录不要和安装脚本的目录放在一起，并且必须在家目录下！！！#######\n\n"
read -e -p "请输入你的工作目录 : " dirname
dirname=${dirname/$wavesign/$realhome}
if [ ! -d "$dirname" ];then
    echo "目录不存在,正在创建目录"
    mkdir -p $dirname
fi

echo $dirname > $basepath/$wp_fname

bash $basepath/clone_code.sh

sudo su root -c "\
cd $dirname;\
echo '-----vagrant add box $boxname start-----';\
vagrant up;\
echo '-----vagrant add box $boxname end-----';"


