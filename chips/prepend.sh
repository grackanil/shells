#!/bin/bash

# 添加环境变量
# prepend PATH /opt/mine/bin
prepend() {
    echo $1;echo $2
    # [ -d "$2" ] 判断路径是否存在
    # 如果一下变量为空会末尾有个冒号
    # [ -d "$2" ] && eval $1=\"$2':'\$$1\" && export $1; 
    # 优化后
    [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1 ;
}
prepend $1 $2