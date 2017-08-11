#!/bin/bash
work_dir=$1;
branch_name=$2;
cd $work_dir;
git fetch origin;
git rebase origin/$branch_name;
git checkout $branch_name;
file_list=`git diff origin/master $branch --name-only`;
PHP=`whereis php`;
for i in $file_list
do
	if [[ -f $i ]];then
		$PHP -l $i>/dev/null;
		if [[ $? -ne 0 ]];then
			echo ${i};
		fi
	fi
done
