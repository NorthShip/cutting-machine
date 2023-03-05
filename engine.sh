#!/bin/bash

# 检查参数是否正确
if [ $# -ne 3 ]
then
    echo "用法：$0 <文件路径> <切割份数> <目标目录>"
    exit 1
fi

# 获取参数
file_path=$1
split_count=$2
target_dir=$3

# 检查文件是否存在
if [ ! -f $file_path ]
then
    echo "文件不存在：$file_path"
    exit 1
fi

# 检查目标目录是否存在，如果不存在则创建它
if [ ! -d $target_dir ]
then
    mkdir -p $target_dir
fi

# 计算每个部分的大小
file_size=$(stat -c %s $file_path)
split_size=$((($file_size + $split_count - 1) / $split_count))

# 切割文件并保存到目标目录中
cd $target_dir
split -b ${split_size}k $file_path ${file_path}_part
