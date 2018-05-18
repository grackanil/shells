# 零散的知识，散到没脾气哈
## 0x00 一句话知识
* #!/bin/bash : shebang, shebang这个词其实是两个字符名称的组合。在Unix的行话里，用sharp或hash(有时候是mesh)来称呼字符“#”， 用bang来称呼惊叹号“!”
* `$ bash script.sh` 不用脚本中的shebang
* `$ chmod a+x script.sh ; ./script.sh` 需要shebang
* `$ cmd1 ; cmd2` 等价于 `$ cmd1 换行 $ cmd2`
* `#` 为注释
## 0x01 打印
* `$ echo Hello world !`
* `$ echo 'Hello world !'`
* `$ echo "Hello world \!"`
* `$ printf "Hello world"`
* 格式化输出，`printf  "%-5s %-10s %-4s\n" No Name  Mark`，%-5s指明了一个格式为左对齐且宽度为5的字符串替换(-表示左对齐)。如果不用-指定对 齐方式，字符串就采用右对齐形式。宽度指定了保留给某个变量的字符数。对Name而言，保留 宽度是10。因此，任何Name字段的内容都会被显示在10字符宽的保留区域内，如果内容不足10 个字符，余下的则以空格符填充。
* echo –e "包含转义序列的字符串"，如`echo -e "1\t2\t3"`，输出1    2    3
* 彩色输出，转义序列实现
* 【彩色文本】每种颜色都有对应的颜色码。比如:重置=0，黑色=30，红色=31，绿色=32，黄色=33，蓝 色=34，洋红=35，青色=36，白色=37。示例：`echo -e "\e[1;31m This is red text \e[0m"`
* 【彩色背景】彩色背景，经常使用的颜色码是:重置=0，黑色=40，红色=41，绿色=42，黄色=43，蓝色=44，洋红=45，青色=46，白色=47。 `echo -e "\e[1;42m Green Background \e[0m"`
## 0x02 变量和环境变量
* 注意，var = value不同于var=value。把var=value写成var = value是一个常见的错误
    ```
    $ var="value" 
    $ echo $var 或 echo ${var}
    ```
* 环境变量
    * 打印和添加
        ```
        $ echo $PATH # 打印当前环境变量
        $ export PATH="$PATH:/home/user/bin" # 添加环境新变量
        ```
    * 常用 HOME、PWD、USER、UID、SHELL
* 获取字符串长度
    ```
    $ var=12345678901234567890$
    $ echo ${#var}
    ```
* 获取当前所使用的shell
    ```
    $ echo $SHELL
    或
    $ echo $0
    ```
* 是否是超级用户，root用户的UID是0
    ```
    if [ $UID -ne 0 ]; then
        echo Non root user. Please run as root.
    else
        echo Root user
    fi
    ```
* shell 参数扩展形式
    ```
    ${parameter:+expression} 如果parameter有值且不为空，则使用expression的值。
    如，
    prepend() { 
        [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1 ; 
    }
    ```
## 0x03 数学计算




