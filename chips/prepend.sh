#!/bin/bash

# 添加环境变量
# prepend PATH /opt/mine/bin
prepend() {
    echo $1;echo $2
    [ -d "$2" ] && eval $1=\"$2':'\$$1\" && export $1; 
}
prepend $1 $2