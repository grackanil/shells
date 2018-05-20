#!/bin/bash
echo -e "Enter password:"
# 选项-echo禁止将输出发送到终端，而选项echo则允许发送输出。
stty -echo
read password
stty echo
echo
echo $password
