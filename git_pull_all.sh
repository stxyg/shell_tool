#!/bin/bash


pull(){
	for  i in $1; do
		if [ -d $i ]; then
			getAllGitDirs $i
		else
			echo "目录【$i】不存在"
		
		fi
	done
	# pull操作
	for  i in ${gitdirs[*]}; do
		cd $i
		echo "切换目录到:【`pwd`】,拉取代码..."
		git pull
		echo -e '\n'
	done
}

getAllGitDirs(){
	# 打开目录
	cd  $1
	if [ `(ls -a | grep '\.git' | wc -l )` -gt 0 ]; then
		# 存储git目录
		gitdirs[${#gitdirs[*]}]=`pwd`
		# 返回上级目录
		cd ..
		return 0
	fi 	
	
	for file_name in `ls -a`; do
		if [ -f ${file_name} -o  ${file_name} = "./" -o  ${file_name} = "../" ]; then
			continue
		fi
		#echo "当前目录：`pwd`,  文件目录： ${file_name}"
		getAllGitDirs "${file_name}"
	done
	
    # 不是git项目
    return 1

}

# 定义目录
#  
dirs=('/f/xxx' '/f/xx2')
cur_dir=`pwd`
#git目录
gitdirs=()

# 执行
pull "${dirs[*]}"

# 跳转回原目录
cd $cur_dir

echo  "返回原目录【${cur_dir}】,成功！"