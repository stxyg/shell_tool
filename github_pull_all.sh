#!/bin/bash


pull(){
	for  i in $1; do
		if [ -d $i ]; then
			cd $i
			# 判断是不是git项目
	        if contains; then
				echo "切换目录到:【`pwd`】,拉取代码..."
				git pull 
				# $@	
			fi
		else
			echo "目录【$i】不存在"
		
		fi
			echo -e '\n'
	done
}

contains(){
	for file_name in `ls -a`; do
		if [ -f ${file_name} ]; then
			break
		fi
    	if test ${file_name} = ".git/";then
    		return 0
    	elif [ ${file_name} != "./" -a  ${file_name} != "../" ]; then
    		cd $file_name
    		son_file_names=`ls -a`
    		pull $son_file_names
    		cd ..
    	fi
        continue	
    done
    # 不是git项目
    return 1

}

# 定义目录（多个目录） 
dirs=('/e' '/d')
cur_dir=`pwd`

# 执行
pull "${dirs[*]}"
# 跳转回原目录
cd $cur_dir

echo  "返回原目录【${cur_dir}】,成功！"





