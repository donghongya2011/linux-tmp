#!/bin/bash
WORK_DIR=$1
branch_name=$2
cd $WORK_DIR
status=`git status | sed -n '/clean/p'`
if [[ ! $status ]];then
    echo '该工作目录有修改，请先处理。'
    exit
fi
git fetch origin
git fetch origin ${branch_name}:${branch_name}
git checkout ${branch_name}
fileList=`git diff origin/master ${branch_name} --name-only`
for file in $fileList
do
    if [[ -f ${file} ]];then
        #PHP5.3与PHP5.5
        php -l $file
        /usr/local/php-5.5/bin/php -l $file
        if [[ $? -ne 0 ]]; then
            echo ${file}
            echo 'php config must be syntax error.'
            echo 'Bye'
            exit 1
    fi
fi
done
