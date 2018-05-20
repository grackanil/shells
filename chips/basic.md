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
* 使用 let、(( ))和[]执行基本的算术操作。高级操作时， 使用 expr和bc。
* let，变量之前不需要再添加$
    ```
    # 1
    $ no1=4
    $ no2=5
    $ let result=no1+no2
    $ echo $result

    # 2
    $ let no1++
    $ let no1--

    # 2
    $ let no+=6
    ```
* [] 方法，和 let 类似
    ```
    $ result=$[ no1 + no2 ]
    $ result=$[ $no1 + 5 ]
    ```
* (())，但使用(())时，变量名之前需要加上$
    ```
    $ result=$(( no1 + 50 ))
    ```
* expr同样可以用于基本算术
    ```
    $ result=`expr 3 + 4`
    $ result=$(expr $no1 + 5)
    ```
* bc是一个用于数学运算的高级工具.
    ```
    # 浮点运算
    $ echo "4 * 0.56" | bc
 
    $ no=54;
    $ result=`echo "$no * 1.5" | bc`
    $ echo $result

    # 精度
    $ echo "scale=2;3/8" | bc

    # 进制转换
    $ no=100
    $ echo "obase=2;$no" | bc

    $ no=1100100
    $ echo "obase=10;ibase=2;$no" | bc

    # 平方和开方
    $ echo "sqrt(100)" | bc
    $ echo "10^10" | bc

    ```
## 0x04 文件描述和重定向
* 文件描述符是与某个打开的文件或数据流相关联的整数。文件描述符0、1以及2是系统预留的。
* 0 -> stdin(标准输入)。 1 -> stdout(标准输出)。 2 -> stderr(标准错误)。
* 将输出文本重定向或保存到一个文件
    ```
    # 清空，写入
    $ echo "This is a sample text 1" > temp.txt
    # 追加
    $ echo "This is sample text 2" >> temp.txt
    ```
* 当一个命令发生错误并退回时，它会返回一个非0的退出状态; 而当命令成功完成后，它会返回数字0。退出状态可以从特殊变量$? 中获得(在命令执行之后立刻运行echo $?，就可以打印出退出状态)
* 
    ```
    $ ls +
    ls: +: No such file or directory

    $ ls + > out.txt
    ls: +: No such file or directory

    # 将stderr重定向到out.txt
    $ ls + 2> out.txt

    $ cmd 2>stderr.txt 1>stdout.txt

    # 将stderr转换成stdout，使得stderr和stdout 都被重定向到同一个文件中:
    $ cmd 2>&1 output.txt
    或
    $ cmd &> output.txt

    ```
* 不想让终端 中充斥着有关stderr的繁枝末节，那么你可以将stderr的输出重定向到 /dev/null
    ```
    $ cmd 2>/dev/null
    ```
* tee 命令
    ```
    $ echo a1 > a1
    $ cp a1 a2 ; cp a2 a3;
    $ chmod 000 a1
    $ cat a*
    $ cat a* 2> err.txt
    $ cat a* | tee out.txt | cat -n
    $ cat a* | tee -a out.txt | cat –n
    ```
* 文件重定向到命令
    ```
    $ cmd < file
    ```
* 自定义文件描述符
* 将脚本内部的文本块进行重定向

## 0x05 数组和关联数组
* 数组，直接上例子
    ```
    # 创建
    $ array_var=(1 2 3 4 5 6)
    或
    $ array_var[0]="test1"
    $ array_var[1]="test2"
    $ array_var[2]="test3"
    
    # 获取
    $ echo ${array_var[0]}
    $ index=5
    $ echo ${array_var[$index]}

    # 获取全部
    $ echo ${array_var[*]}
    或
    $ echo ${array_var[@]}

    # 获取数组长度
    $ echo ${#array_var[*]}
    ```
* 关联数组，可以用任意的文本作为数组索引
    ```
    # 声明
    $ declare -A ass_array

    # 创建
    $ ass_array=([index1]=val1 [index2]=val2)
    或
    $ ass_array[index1]=val1
    $ ass_array'index2]=val2

    # 例子
    $ declare -A fruits_value
    $ fruits_value=([apple]='100dollars' [orange]='150 dollars')
    $ echo "Apple costs ${fruits_value[apple]}"

    # 列出索引
    $ echo ${!array_var[*]}
    或
    $ echo ${!array_var[@]

    # 例子，对于普通数组，这个方法同样可行
    $ echo ${!fruits_value[*]}
    ```

## 0x06 别名
* 创建别名时，如果已经有同名的别名存在，那么原有的别名设置将被新的设 置取代。
    ```
    $ alias new_command='command sequence'
    $ alias install='sudo apt-get install'
    ```
* alias命令的作用只是暂时的。为了使别名设置一直保持作用，可以将它放入~/.bashrc文件中。
    ```
    $ echo 'alias cmd="command seq"' >> ~/.bashrc
    ```
* 如果需要删除别名，只用将其对应的语句(如果有的话)从 ~/.bashrc中删除， 或者使用unalias命令。或者使用alias example=，这会取消名为example 的别名。
* 安全问题，alias命令能够为任何重要的命令创建别名，不过你未必总是希望用别名来执行这个命令。 我们可以将希望使用的命令进行转义，从而忽略当前定义的别名。
    ```
    $ \command  # 安全的方式，因为攻击者可能已经将一些别有用心的命令利用别名伪装成了特权命令，借此来盗取用户 输入的重要信息。
    ```

## 0x07 获取终端信息
* tput和stty是两款终端处理工具
* stty 应用于密码输入，不显示输入内容

## 0x08 获取、设置、延时日期
* 在类Unix系统中，日期被存储 成一个整数，其大小为自世界标准时间(UTC)11970年1月1日0时0分0秒2起所流逝的秒数。这 种计时方式称为纪元时或Unix时间。
* 可以使用不同的格式来读取、设置日期
    ```
    # 打印日期
    $ date

    # 纪元时
    $ date +%s

    # 20 May 2010
    $ date "+%d %B %Y"
    ```
* 日期格式
    * 星期 %a(例如:Sat) %A(例如:Saturday)
    * 月 %b(例如:Nov) %B(例如:November)
    * 日 %d(例如:31)
    * 固定格式日期(mm/dd/yy) %D(例如:10/18/10)
    * 年 %y(例如:10) %Y(例如:2010)
    * 小时 %I或%H(例如:08)
    * 分钟 %M(例如:33)
    * 秒 %S(例如:10)
    * 纳秒 %N(例如:695208515) 
    * Unix纪元时(以秒为单位) %s(例如:1290049486)

## 0x09 调试脚本
* `$ bash -x script.sh`。使用选项–x，启用shell脚本的跟踪调试功能:运行带有-x标志的脚本可以打印出所执行的每一行命令以及当前状态。注意，你也 可以使用sh -x script。
* 使用set -x和set +x对脚本进行部分调试。










