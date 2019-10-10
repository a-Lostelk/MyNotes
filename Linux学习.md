---
typora-root-url: Linux
---

# Linux学习



[Linux命令搜索引擎](<https://wangchujiang.com/linux-command/>)



**所有的Linux发行版都是使用的相同的Linux内核，Redhat分支，Debian分支**

CentOS参照红旗Linux的完全免费版，是国内最流行最广泛的Linux发型

### Linux是天生优秀的网络操作系统



### 格式化

高级格式化（逻辑格式化），根据用户选定的文件系统（FAT16,FAT32，NTFS等），在磁盘的特定区域划出一片用于存放文件分配表、目录表等用来文件管理

低级格式化是硬盘的操作



### 硬件设备文件

*所有的硬件设备都是文件*，相较于win系统（分区——格式化——分配盘符——直接使用），Linux在格式化和分配盘符间多了一个步骤：建立硬件设备文件名


**分区设备文件名**

[硬盘](https://blog.csdn.net/tianlesoftware/article/details/6009110)要有文件名，分区也要有文件名，分区的设备文件名就是在硬盘文件名后的数字

![](/搜狗截图20190714180001.png)

**挂载（类似于win中的分配盘符C盘，D盘）**

分配好后称之为挂载点

在Linux中是以一个空目录（不指定名字）为挂载点

***必须分区***：

- / （根分区）
- swap分区（交换分区，可以理解为虚拟内存，当内存不够用的时候，可以使用虚拟分区，不超过2GB）

***推荐分区***

- /boot分区（启动分区，200MB，专门用来保存系统启动时所需要的数据）



### 文件系统结构

/根分区是单独分配一个磁盘空间，可以为根分区下的某个子目录（例如/home）分配另一个硬盘空间，如果往根目录下未指定单独硬盘空间的文件夹写入数据，实际上写入根分区所在的硬盘空间，如果往/home中写入数据，实际上写入的是另一个硬盘空间（也就是为/home所分配的硬盘空间）

![](/搜狗截图20190714183346.png)



### Linux在安装的时候至少要创建三个分区

/boot分区：当系统启动时一些默认的文件和必要的文件就放在这个文件夹下，引导分区

swap分区：虚拟内存，在系统空间不足的时候暂时用啦代替系统空间 ，交换分区

/根分区：

##### 自定义选择组件

![](/搜狗截图20190715091900.png)

#####  Kdump

![](/搜狗截图20190715103842.png)

123456我的密码



查看缓冲区及内存使用情况

***free -m***命令

```
[root@localhost ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:            993          81         664           6         247         765
Swap:           819           0         819
```



****



### **Linux yum**

##### 简介

- ***yum***（ Yellow dog Updater, Modified）是一个在Fedora和RedHat以及SUSE中的***Shell前端软件包管理器***
- 基於***RPM***包管理，*能够从指定的服务器自动下载RPM包并且安装*，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。

**语法**

*yum [options] [command] [package ...]*

- **options：**可选，选项包括-h（帮助），-y（当安装过程提示选择全部为"yes"），-q（不显示安装的过程）等等。
- **command：**要进行的操作。
- **package**操作的对象。

##### yum常用命令

- 1.列出所有可更新的软件清单命令：***yum check-update***
- 2.更新所有软件命令：***yum update***
- 3.仅安装指定的软件命令：***yum install <package_name>***
- 4.仅更新指定的软件命令：***yum update <package_name>***
- 5.列出所有可安裝的软件清单命令：***yum list***
- 6.删除软件包命令：***yum remove <package_name>***
- 7.查找软件包 命令：***yum search <keyword>***
- 8.清除缓存命令:
  - ***yum clean packages***: 清除缓存目录下的软件包
  - ***yum clean headers***: 清除缓存目录下的 headers
  - ***yum clean oldheaders***: 清除缓存目录下旧的 headers
  - ***yum clean, yum clean all*** (= yum clean packages; yum clean oldheaders) :清除缓存目录下的软件包及旧的headers



*****



### Linux系统文件结构

在Linux世界里，一切都是文件

Linux的文件系统是采用层级的树状目录结构，根目录最上层的是 "/"

![](/搜狗截图20190730093645.png)

即使是硬件设备，在Linux会映射到系统的一个文件，cpu，disk等映射在/dev下，

***/bin***存放的常用的指令文件，cp cat find

***/sbin***系统管理员的系统管理程序

***/home***存放普通用户的主目录，每一个用户都有自己的目录，以用户账号命名

***/root***系统管理员（登录者）的主目录

***/dev***计算机的硬件设备映射文件

***/opt***需要安装的软件存放的目录

***/usr/loacl***真正安装后的软件

***/var***存放的是不断改变扩充的东西，习惯将经常被改变的文件放在这个文件夹

***/selinux***是一种安全种子，用来守护系统安全

**在Linux系统中有一个SSHD服务，专门用来监听22端口，22端口用来等待外部远程连接**（端口开的越多，安全性越弱）



*****



**vim**的三种模式

正常模式：使用快捷键	

插入模式：输入内容

命令行模式： :wq保存退出



### 为CentOS分配静态IP地址

<https://blog.csdn.net/Heimerdinger_Feng/article/details/71171231>

dbcpip地址会随机改变，cd到/etc/sysconfig/network-scripts，修改默认的etho网卡地址，首先将BOOTPROTO改为static静态方式，分配IPADDR地址（不能和本机冲突，和本机的ip地址前三位一致，保持在同一局域网内，最后一位在1~255之间），添加GATEWAY网关地址（和本机默认网关地址一直），ONBOOT="yes"使服务开机启动



### 使用Xftp5上传和下载

##### 进行远程连接

![](/QQ截图20190811214752.png)

##### 解决乱码问题

![](/QQ截图20190811215222.png)



### Linux常用命令集合

***reboot***：重启虚拟机，连接客户端会关闭

***touch fileName***：创建一个文件

***find ./ -inum 784137 -print -exec rm {} -rf \;***删除乱码非空文件夹（inum是ls-li 查询出来的文件id）



*******

### Linux的用户管理

- ***在Linux是多用户多任务的操作系统***，root是最高权限级别的管理者，在系统中有会多个不同权限的用户，/home目录下，在Linux系统中的用户都有自己对应的home目录，任何需要使用到系统资源的用户，等需要先向root管理员申请一个账号，有了账号才可以进行对系统资源的访问
- 一个用户至少会有一个自己的组（可以认为是权限的集合）

/home/xiaoming 	/home/xiaohong

**语法**：

- 创建用户useradd [选项]

  ***useradd -d /home/user/ xh***： -d是指定文件夹  xh是用户名

- 在创建好对应的用户名和密码后：***passwd xh*** 外部就可以通过用户名访问系统资源了


- 删除用户：***userdel xh***（删除用户保留home目录）

  ​					***userdel -r xq***（删除用户及家目录）

- 查询用户：***id [用户名]***
- 切换用户：***su  -  切换用户名*** （切换的普通用户需要切换到root管理用户时，exit退出）

用户组

- 创建用户组：***groupadd groud1***（组名）
- ***passwd tom***（用户名）
- 删除用户组; ***groupdel groud1***
- 创建用户并指定用户组：***useradd -g 用户组 用户名***
- 修改用户到指定的用户组：***usermod -g 用户组 用户名***



#### 文件目录类

***cd ..***跳转到上一级目录

***pwd***显示工作目录的决定路径

***ls -a***显示所有的文件夹和隐藏文件夹

***touch*** 创建一个空的文件，一个一次性创建多个文件

***cp*** 拷贝文件到指定目录 ：cp xxx.txt test/ 加上-f就是递归复制整个文件夹 

***cp -r  test/  test2***:将test1中的所有的文件递归拷贝到test2文件夹中（要拷贝哪个文件夹，就要在该文件夹的目录进行操作） \cp 强制覆盖不提示

***rm*** 移除文件或目录 -r递归删除整个文件夹，-f强制删除不提示  : rm -rf test/	删除test整个文件夹

***mv***移动文件或是重命名 mv test.txt test2.txt将test文件重命名为test1.txt mv , mv test.txt /root/移动到root命令下

***cat*** 查看文件内容（只读不能修改），vi或vim可以进行修改， -n会显示行号 ， ***cat -n /etc/profile | more***分页显示并显示行号	|就是管道命令

***more*** more 文件名是基于vi编辑器的命令，以全屏的方式按页的方式显示文件 ，快捷键如下

![](/QQ截图20190725164500.png)



***less***指令用来分屏查看文件内容，功能和more差不多，并不是一次加载后显示，而是变加载变执行，根据需要显示，对大型文件less指令更有效。快捷键如下

![](/QQ截图20190725165138.png)

***> 和 >>***:输出重定向和追加，前者会将原来的内容覆盖，后者会将内容添加到内容的地步

ls -l > test.txt:	将ls-l显示的内容覆盖写入到test.txt，文件如果不存在则会创建和文件中如果有内容就会覆盖 

ls -l >> test.txt：追加不覆盖到test.txt文件中

***cal***显示当前日历信息

***echo***输出内容到控制台（路径或是文本内容），echo $PATH输出当前机器的环境变量路径，

***head***显示文件的开头部分，默认查看前十行的内容， -n 8就是显示8行的内容

***tail***用于输出文件尾部的内容，默认的显示后十条的内容 ，-n5显示后5行的内容，

***tail -f***实时监控文件的更新的内容。使用较为频繁，多用于日志监控，被监控的文件发生改变的时候，能够立马的到实时数据结果

***ln***软链接，类似于Windows的桌面快捷方式，主要存放了连接其他文件的路径，实际上指向的是源文件

***ln -s /root linkToRoo***（先写源文件，在写软链接）t创建一个指向root目录的软链接，cd访问软链接的目录不变，但实际访问的还是root目录的内容，虽然访问root目录内容，pwd打印的仍是当前目录，删除软链接的时候不能带上/，带了/相当于删除软链接所指向源文件下的内容，应当直接删除软链接文件夹的文件名，就是值删除当前文件，软链接中是没有任何数据，保存的是指向源文件的路径

***history***查看已经执行过的历史指令，也可以执行历史指令，history > history.txt可以将使用过的命令保存到一个文件中，！10就是执行历史记录为10的指令

#### 事件日期类

***date***显示当前日志，date "+%Y-%m-%d" 2019-07-25 +号不能少

![](/QQ截图20190725185256.png)

***date***设置时间，date -s 字符串时间

***cal***显示当前的日历时间 cal 2019显示一整年的日历



#### 搜索查找类

***find***指令从指定目录向下递归遍历子文件夹查找指定文件

选项： -name（文件名）	-user（用户名）	-size（文件大小）

find /home -name hello.txt	查找 /范围 -name 文件名

 find / -size +20M 查找指定size大小的文件，查找大文件清理空间 +n大于， -n小于，n等于 

find /home -name *.txt 支持通配符查找

**ls -lh** 会查出指定文件的存储大小

***locate***快速定位文件路径，事先建立的locate数据库中，存放了所有的文件名称和路径，可以快速定位到文件的位置而无需访问文件的内容，因此查询速度快准确度高，管理员必须定时更新locate数据库时刻，首先要创建一个locate数据库（updatedb）

***grep***过滤查找

| 管道符 将前一个命令的处理结果传递给后面的命令处理

cat github.java  | grep -ni github查找关键字为github的并显示他们的行号,不区分大小写

#### 压缩和解压缩

***gzip***:压缩文件

***gunzip***解压

***tar***：打包指令，根据不同的参数打包解压等，打包后的是tar.gz文件 
		-c 打包文件	-v显示详细信息	-f指定文件名	-z打包同时压缩	-x解压

***tar -zcvf my.tar.gz （打包后的文件名） hello.txt hello1.txt（需要打包的文件）***

***tar -zxvf my.tar.gz***解压文件  	-C是指定解压的文件夹



#### 组管理和权限管理

在Linux中每一个用户都有一个组，不能独立于组之外，每个用户的信息会存放在一个配置文件中，Linux中每个文件夹和所在组，所有者，其他组

#### 文件目录的所有者

一般是文件的创建者，谁创建了文件，就是文件的所有者

查看文件的`所有者`： ***ls -ahl***  (all human list)	-rw-r--r--. 1 **tom*(所有者)  **ploice（所在组 ） 0 7月  29 23:09 ok.txt

修改文件的`所有者`	 ***chown*** 用户名 文件名

文件的所在组不一定是所有者的所在组

修改文件的所在组 	***chgrp*** 

修改用户`所在组` ***useradd -g bandit(修改用户组) tom(用户名)***

`组相当于角色，角色可以分配权限，了解组的的关系才能进行权限的分配`



### 硬链接与软链接的联系与区别

文件都有文件名与数据，在 Linux 上被分成两个部分：用户数据 (user data) 与元数据 (metadata)

***用户数据***，即文件数据块 (data block)，数据块是记录文件真实内容的地方；而***元数据***则是文件的附加属性，如文件大小、创建时间、所有者等信息。

在 Linux 中，元数据中的 inode 号（inode 是文件元数据的一部分但其并不包含文件名，inode 号即索引节点号）才是文件的`唯一标识`而非文件名

文件名仅是为了方便人们的记忆和使用，系统或程序通过 inode 号寻找正确的文件数据块。为解决文件的共享使用，Linux 系统引入了两种链接：`硬链接 (hard link) 与软链接（又称符号链接，即 soft link 或 symbolic link）`

- 一个文件有几个文件名(用ln命令实现多个文件名)，我们就说该文件的链接数为几。由定义可知，此链接数可以是1, 这表明该文件只有一个文件名。

  总之，硬链接就是让多个不在或者同在一个目录下的文件名，同时能够修改同一个文件，其中一个修改后，所有与其有硬链接的文件都一起修改了。

- 链接文件甚至可以链接不存在的文件，这就产生一般称之为”断链”的现象，链接文件甚至可以循环链接自己。类似于编程语言中的递归。

  软链接文件只是其源文件的一个标记，当删除了源文件后，链接文件不能独立存在，虽然仍保留文件名，但却不能查看软链接文件的内容了。



### 权限管理

文件和目录的权限

![](/搜狗截图20190730092205.png)

文件的类型：d 文件夹（目录），- 普通文件 	l  软链接	c：字符设备（硬盘鼠标等）

文件的权限：rw文件所有者的权限（read write 读写权限）- 没有权限

​						r - - 文件所在组的权限，只有读的权限

硬链接或是子目录个数：4	如果是文件，表示硬链接的数，如果是软链接，表示子目录的个数

用户名组：tom是用户名，ploice是用户所在组

文件目录区分：4096 是文件夹目录，如果是文件就是文件大小

文件时间：7月是创建时间	29 23:14 是最后访问的时间

文件（目录）名：tom

#### 权限的基本介绍

![](/搜狗截图20190730103147.png)

#### rwx权限

作用到文件：r 表示可读（**read**），可以读取，查看	w可写（**write**）：可以修改，但是不代表可以删除文件，删除文件的前提是必须对该文件有写的权限，才能删除文件	x代表可执行（**excute**）：可以被执行

作用到目录：r 表示可读（read）可以ls查看内容	w可写（write）创建删除和重命名文件	x代表可执行（excute）可以进入该目录

rwx也可以用数字来表示：即 r=4，w=2，x=1 	规定 数字 4 、2 和 1表示读、写、执行权限

如：

rwx = 4 + 2 + 1 = 7

rw = 4 + 2 = 6

rx = 4 +1 = 5

每个文件夹下都有两个隐藏目录  . 和 .. ，.代表的是当前目录，..代表是上一级目录（ls -la 查看包括隐藏文件）



#### 修改权限管理

***chmod***修改文件或是目录权限

***chmod u=rwx（用户所有者）,g=rx（用户组）,o=rw（其他分组） a.txt*** 

![](/搜狗截图20190730134105.png)

***chmod u-x,g+w a.txt***增加或删除权限

***chmod a+r a***bc:给abc目录下所有的文件都加上读的权限，a（all）



#### 修改文件所有者

***chown newowner file***修改文件的所有者

***chown -R tom fox/***将fox下所有的子目录的所有者改变为tom



#### 修改文件所在组

***chgrp newgroup file***修改文件的所在组

***chgrp -R tom fox/***



#### 定时任务调度

crontab进行定时任务的调度，系统在某个时段执行的特定的命令或程序

 -e	编辑定时任务	-l	查询定时任务	-r删除定时任务

例如病毒扫描，文件备份等重复定时的任务

*/1 * * * * ls -l/etc>>/tmp/to.txt *号代表每小时每分钟，执行输出etc列表的内容到to.txt文件中

![](/搜狗截图20190731205702.png)

![](/搜狗截图20190731205914.png)

![](/搜狗截图20190731210423.png)



### Linux的磁盘分区和挂载

#### 分区方式

*mbr分区和gtp分区*

![](/搜狗截图20190801112230.png)

Windows下的磁盘分区，分为一个主分区，多个逻辑分区（拓展分区）

#### Linux的分区介绍

Linux无论有几个分区，分给哪个目录使用，但是最终还是只有一个根目录，Linux中每一个分区都是组成整个文件系统的一部分，

Linux采用一种叫”载入的技术“，

挂载：将分区对应到系统中的某一目录或是文件，

![](/搜狗截图20190801113450.png)

#### 硬盘说明

目前主要是使用的SCSI硬盘

![](/搜狗截图20190801113631.png)

***lsblk -f查看详细分区信息 lsblk可以查看磁盘分区的大小***

![](/搜狗截图20190801114935.png)



##### 增加一块硬盘（挂载）

- 添加硬盘	VMware设置中添加新的SICI硬盘	

- 分区

  ​		***fdisk /dev/sdb*进行分区操作**

  ![](/QQ拼音截图20190804112101.png)

  ​		**选择作为主分区**

  ​			![](/QQ拼音截图20190804112624.png)

  ​		**讲硬盘分区表信息写入到硬盘中**

  ![](/QQ拼音截图20190804113026.png)

  完成上述步骤后执行磁盘查询信息命令就可以找到新增的磁盘sdb1

- 格式化  ***mkfs -t ext4/dev/sdb1***将分区格式化为ext4的文件格式

- 挂载（将文件目录和分区形成一个链接关系）  将新增磁盘挂载到指定的文件夹，挂载

  ![](/QQ拼音截图20190804115514.png)

- 设置为自动挂载

  上述步骤是临时挂载，重启后挂载关系后消失，

  *（vim编辑器小技巧，y + y + p复制一行）*

  /etc/fstab	记录了分区目录UUID等信息

  ![](/QQ拼音截图20190805101131.png)

- 卸载硬盘分区  ***umount 硬盘分区名  / 硬盘安装目录***



##### 磁盘情况查询

查看磁盘占用情况和使用情况

***df -l	df -lh***	查看所有磁盘的分区情况

***du -h / 目录***	查询指定磁盘的情况

- -s	 指定目录占用大小汇总
- -h    带计量单位
- -a     含文件
- --max-depth=1    子目录深度
- -c    列出明细的同时增加汇总值

![](/QQ拼音截图20190805111633.png)

***ll /etc | grep "^-" | wc -l***	统计某个文件夹下的文件个数（过滤查找）

![](/QQ拼音截图20190805142828.png)

***ll /etc | grep "^d" | wc -l***	统计文件夹的个数

***ls -lR /etc | grep "^-" | wc -l***	统计文件个数和子文件下的文件格式（R递归查找）

***tree***是文件目录以树状结构分析



### 网络配置原理

**Bridged（桥接模式）**、**NAT（网络地址转换模式）**、**Host-Only（仅主机模式）**

***vi /etc/sysconfig/network-scripts/ifcfg-eth0***编辑网卡配置文件

> **桥接模式**，
>
> 就是将主机网卡与虚拟机虚拟的网卡利用虚拟网桥进行通信。在桥接的作用下，类似于把物理主机虚拟为一个交换机，所有桥接设置的虚拟机连接到这个交换机的一个接口上，物理主机也同样插在这个交换机当中，所以所有桥接下的网卡与网卡都是交换模式的，相互可以访问而不干扰
>
> 在桥接模式下，虚拟机ip地址需要与主机在同一个网段，如果需要联网，则网关与DNS需要与主机网卡一致

![](/20160408183817187.png)

> **NAT模式**借助虚拟NAT设备和虚拟DHCP服务器，使得虚拟机可以联网
>
> 主机网卡直接与虚拟NAT设备相连，然后虚拟NAT设备与虚拟DHCP服务器一起连接在虚拟交换机

![](/QQ拼音截图20190806213634.png)

> **Host-Only模式**，就是NAT模式去除了虚拟NAT设备，然后使用VMware Network Adapter VMnet1虚拟网卡连接VMnet1虚拟交换机来与虚拟机通信的，Host-Only模式将虚拟机与外网隔开，使得虚拟机成为一个独立的系统，只与主机相互通讯

![](/QQ拼音截图20190806214040.png)

本机IP地址和虚拟网卡地址（目前是无线网卡），虚拟网卡和真实网卡与外部网络通过各种网关和外界进行通信，Linux通过虚拟网卡代理服务，再有真实网卡与外界进行通信																																																																						

![](/QQ拼音截图20190806215009.png)



### 进程管理（重点）

1. 在Linux中，每个执行的程序都是一个进程，每个进程都会分配一个ID号
2. 每个进程都对应一个父进程，父进程可以复制多个子进程
3. 进程可能以两种方式存在，前台进厂是屏幕上可以被操作的，后台进程是在运行但是前台看不到的方式执行（例如终端是前台进程，命令行执行的是后台命令）
4. 一般系统的服务都是在后台以后台进程的方式存在，常驻在系统内存中，直到关机才会结束

##### 执行

ps指令，查看系统中执行的进程	

-a显示当前终端所有的远程信息	

-u用户的格式显示进程信息	

-x显示后台进程运行的参数

PID进程识别号	TTY终端机号，	TIME进程所消耗的CPU时间	CMD正在执行的命令或进程名   

![](/搜狗截图20190801114935.png)
=======



ps -aux查看后台进程和详细情况

![](/QQ拼音截图20190810220047.png)

ps -aux | grep xxx	指定进程名的详细信息

##### ps详解

1)指令:ps- aux I grep xxx
System V展示风格
USER:用户名称
PID:进程号
%CPuU:进程占用pPU的百分比
%MEM:进程占用物理内存的百分比
VSZ:进程占用的虚拟内存大小(单位:kB)
8s:进程占用的物理内存大小(单位:KB)
TTY:终端名称缩写
STAT:进程状态,其中5睡眠,y表示该进程是会话的先导进程,N表示进程拥有比通优先更低的优先级,R正在运行,D短期等待,2僵死进程,千被跟踪或者被停止等等
STARTED:进程的启动时间
TIME： CPU时间,即进程使用Cpu的总时间
COMMAND：启动进程所用的命令和数,如果过长会被截断显示

***ps -ef | more***查看父进程



### 终止进程kill和killall

##### kill 

kill [选项号]进程号 		-9强制杀死一个进程，kill不带参数的时候某些时候无法杀死一些进程，例子：可以踢出一个正在登录的用户

##### killall	

killall	进程名，终止多个进程，通过进程名杀死与之相关的所有子进程，当一个夫进程启动了很多子进程的时候，使用该killall终止多个

/bin/bash 表示是一个终端

![](/QQ拼音截图20190811000201.png)



pstree -p查看进程树 	-u显示进程的所属用户



### 服务管理（service）

本质是进程，但是是运行在后台的，如MySQL、SSHD防火墙等，通常会监听某个端口 等待其他程序的请求，我们称之为守护进程，在Linux中非常重要

##### **service管理指令**

service服务名 start|stop|restart|reload|status	(在7.0后的版本使用systemctl 代替service指令)

##### **查看当前防火墙重启关闭等操作**

***service iptables status***查看防火墙状态，根据start stop等操作可以对防火墙进行修改

在主机中可以使用telnet检查Linux中的某个端口是否在监听，并且可以访问	***telnet 192.168.1.111 22*** 查看虚拟机的端口是否启动中

##### **查看服务名**

***ll /etc/init.d/***查看服务名

Linux7中运行级别：**常用的级别是3和5**

***0***：系统停机状态，默认运行级别不能设置为0，否则不能正常开机

***1***：单用户工作状态，root权限登录操作，多用于系统维护，此时无法远程登录

***2***：多用户状态不支持网络

***3***：完全的多用户状态，登录进入控制台命令模式，

***4***：系统未使用，保留

***5***：图形GUI模式

***6***：系统正常关闭并重启，不能设置为默认级别，否则不能政策启动

***vi /etc/inittab***

![](/QQ拼音截图20190811094605.png)

##### ***Linux的开机流程***

![](/QQ拼音截图20190811094349.png)

***chkconfig***可以给每个服务的各个运行级别设置自启动/关闭

显示当前系统的所有服务的各个运行级别的运行状态

![](/QQ拼音截图20190811095828.png)

***chkconfig --list | grep sshd***	***chkconfig  sshd --list***通过过滤查找指定的服务状态

**chkconfig --level 5 sshd off***设置服务指定级别的自启动



### 进程监控

动态监控进程

top和ps命令很相似，他们都用来显示正在执行的进程，top的不同之处在于可以更新正在显示的进程（类似windows中的任务管理器）

-d 秒数	指定每隔几秒更新，默认是三秒

-i 		不显示任何闲置或是僵死进程

-p		指定进程ID来监控某个进程的状态

##### **交互操作**

P以CPU的使用率排序，默认排序 ；M内存的使用率排序；N按照PID排序； q退出，k tokill杀死某个进程

![](/QQ拼音截图20190811105215.png)

##### **查看系统网络状况**

-an	按一定的顺序排列输出

-p	显示哪个进程在调用

netstat -anp | more 查看所有的网络服务



### rpm包和yum包

##### RPM

***RPM***是一种互联网下载并打包的安装工具，包含在某些Linux的发行版中，拓展名是.RPM，全称（***RedHat Package Manager***）RedHat软件包管理工具，类似windows中的exe文件，是公认的行业标准，最早是应用于Redhat系统

###### **简单查询指令**:

***rpm -qa|grep xxx***	查询已安装的列表（q查询，a所有）

![](/QQ拼音截图20190811141853.png)

##### 其他指令

![](/QQ拼音截图20190811142103.png)

***rpm -qi firefox***软件包信息

***rpm -ql firefox***安装位置

***rpm -qf /etc/passwd***文件所属软件包

##### rpm卸载

***rpm -e xxx***删除软件包 

***rpm -e --nodeps xxx***强制删除（当有软件文件依赖于这个软件包的时候上述指令无法删除，但是不推荐这么做，因为依赖于该软件的程序可能无法运行）

##### rpm安装

参数说明：	i（install安装）v（verbose提示） h（hash进度条）

需要先找到需要安装的软件包，linux 的镜像文件在/media媒体文件夹下，其中的Package包下有所有系统的RPM软件包，用户自定义安装的软件一般在/opt目录下

![](/QQ拼音截图20190811150810.png)



##### yum

yum是一个Shell前端软件安装器，基于RPM包管理，能够从指定的服务器上下载RPM包，自动处理依赖关系，并且可以一次安装所有的依赖包，yum服务器存有大量的RPM包，公网连接 

yum list | grep xxx软件列表

yum install xxx指定软件，例如：yum install firefox 安装火狐浏览器





### 搭建Java EE开发环境

![](/QQ截图20190811210546.png)

##### 安装jdk

解压到opt目录下（一般用户安装软件是放在opt目录下的）

配置环境变量：vim etc/profile	profile中就是环境变量的配置文件，相当于windows中的环境变量（vim操作小技巧，在非编辑模式中输入G就能快速到文件的末尾）

![](/QQ截图20190811225320.png)

需要注销用户，环境变量才能生效 ***logout***

这时候，jdk安装成功并可以使用了



##### 安装Tomcat

tar -zxvf解压，cd到目标的bin目录执行 ./startup.sh 开启Tomcat服务9999

外部需要访问Linux中的Tomcat，需要将防火墙 放行Tomcat的端口，

vi /etc/sysconfig/iptables 编辑放行8080端口供外网访问，编辑完成后需要service iptables restart重启防火墙，这时候防火墙状态中就会多一个供外部使用的8080端口

![](/QQ截图20190812091554.png)

##### 安装eclipse

执行tar -zxvf解压，直接进入到eclipse目录，./eclipse就能启动eclipse了

eclipse运行文件时会提示端口已被占用， 需要在bin目录下停止Tomcat服务器，由eclipse启动服务器开启Tomcat服务器并使用其端口，这时候，外网就可以访问Linux运行的java程序

![](/QQ截图20190812095316.png)

##### MySQL安装

首先要删除原有的MySQL版本，若MySQL和某些文件有依赖关系，***rpm -e --nodeps mysql-libs***强制删除MySQL及其依赖文件，

***yum -y install make gcc-c++ cmake bison-devel ncurses-devel***

源码编译指令

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql
-DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/etc
-DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1
-DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1
-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock -DMYSQL_TCP_PORT=3306
-DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENHINE=1
-DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8
-DDEFAULT_COLLATION=utf8_general_cl

MySQL在Linux中有专门的用户组，如果没有的话需要创建

***groupadd mysql	useradd -g mysql mysql***

创建MySQL用户组后改变mysql用户组的所有者root为  /usr/local/mysql	***chown mysql:mysql /usr/local/mysql/***

***scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql***初始化mysql的脚本

###### 启动mysql注意事项

![](/QQ截图20190812121654.png)



######  

需要进入到 /usr/local/mysql/bin目录下，该目录存放mysql等启动器

![](/QQ截图20190812122553.png)

这时候就可以进入到mysql数据库中了

![](/QQ截图20190812123121.png)

###### 修改数据库密码

默认的密码是空，需要设置密码

set password = password('root')

quit退出后就需要输入密码了



##### 配置环境变量

这样可以不再当前环境就能使用数据库登录命令

![](/QQ截图20190812152834.png)



### Shell编程

在Linux运维工程师系统管理，Javaee程序员需要编写Shell脚本，或者服务器的维护，大数据程序员对服务集群管理

Shell是一个命令行解释器，为用户提供了一个向Linux内核发送请求一遍运行程序的界面系统级程序	，可以用Shell启动，挂起，停止甚至编写一些程序

#### shell的分类

Shell的两种主要语法类型有Bourne和C，这两种语法彼此不兼容。Bourne家族主要包括sh、ksh、 Bash、 psh、 zsh; C家族主
要包括: csh、tcsh，B Shell和C Shell的语法结构是完全不相同的

一般Linux中的Shell是Bash

**vi /etc/shells**可以查询当前Linux系统支持的Shell

![](/QQ截图20190812154431.png)



##### shell脚本的执行方式

脚本以 **#!/bin/bash** 开头

![](/QQ截图20190812155328.png)



echo输出命令，是相当强大的Shell输出语法，在Linux中，所有的系统命令都可以直接被脚本调用

-e支持反斜线控制的字符转换

比如改变输出字体的颜色

30m=黑色，31=红色，32m=绿色等 

![](/QQ截图20191003212757.png)



##### 执行方式

编写完Shell脚本还不能立马执行，有两种执行方式

1. 输入脚本的绝对路径和相对路径，首先分配文件权限，增加可执行权限 x

   相对路径要进入到对应的文件目录./myShell.sh，绝对路径是/root/shell/myShell.sh运行

   ![](/QQ截图20190812162904.png)

2. 明确指定用Shell执行（不推荐）

   sh ./myShell.sh 或者bash ./myShell.sh

3. 使用第一种方式执行的实现要赋予文件可执行权限

   

   

##### Shell的变量

![](/QQ截图20190812170422.png)

##### 实例

**系统变量**

path=/opt/jdk1.7.0_79/bin:/usr/lib64/qt3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
user=root

![](/QQ截图20190812171101.png)

**自定义变量**

![](/QQ截图20190812175242.png)

**静态变量（不能撤销）**

readonly a=100

**全局环境变量**



##### 定义变量的规则

![](/QQ截图20190812175644.png)

使用``号将命令赋值

![](/QQ截图20190812181006.png)



##### 环境变量

基本语法：

export 变量名=变量值	（将shell变量设置为环境变量）

source /etc/profile	（修改后的环境变量立即生效）

echo $变量名	（查询环境变量）

定义的环境变量可以被其他shell脚本使用

![](/1565700794821.png)

##### 位置参数变量

![](/QQ拼音截图20190813214130.png)

例子

![](/QQ拼音截图20190813215344.png)



##### 预定义变量

![](/QQ拼音截图20190813222817.png)

小案例

![](/QQ拼音截图20190813223626.png)

##### 运算符

![](/QQ拼音截图20190813224125.png)

***vim yunsuanfu.sh 100 200***执行结果

![](/QQ拼音截图20190813232659.png)

##### 判断语句

shell是控制Linux系统内核的，必然会对文件系统产生一定的作用

小技巧：**-lt = less than 	-le = less equal 	-eq = eqlual	-gt = greater than 	-ge = greater than 	-ne = not equal**

![](/QQ拼音截图20190814202319.png)

案例

```shell
#!/bin/bash

#判断字符串是否相等,如果成立，执行then后面的结果，不成立返回false	
 if [ "ok" = "ok" ]
then
        echo "equal"
fi

#判断数字是否相等
if [ 23 -gt 21 ]
then
        echo "大于" 
fi

#判断文件是否存在 -e           
if [ -e /root/shell/hello.txt ]
then
        echo "文件存在"
fi
```



##### if流程控制

基本语法：

```shell
if [ 条件判断 ]； then
	程序
fi
或者if [ 条件判断 ]
	then 
			程序
elif [ 条件判断 ]
then
	程序
fi（所有的shelll脚本都不能忘了fi结尾）
```

案例：

```shell
 1	#!/bin/bash
 2	
 3	#案例，参数大于60输入及格了，没有大于60，输入不及格
 4	
 5	
 6	if [ $1 -ge 60 ] 
 7	then
 8		echo "及格了" 
 9	
10	elif [ $1 -lt 60 ] 
11	then
12		echo "不及格"
13	fi 

```

##### case控制语句

```shell
case $变量名 in
"值1"）
	变量值等于值1，执行程序

"值2"）
	变量值等于值2，执行程序
“*”）
esac
```

**案例：**

```shell
1	#!/bin/bash
2	
3	#是1输出周一，是2输出周二，时是其他输出other
4	
5	
6	case $1 in 
7	"1")
8		echo "星期一"
9	;;
10	"2")
11		echo "星期二"
12	;;
13	*)
14		echo "other"
15	;;
16	esac
```



##### for循环

**基本语法**

```shell
for 变量in 值1 值2 值3
do
	程序
done
```

**案例**

![](/QQ截图20190819211814.png)

**基本语法2**

```shell
1	#!/bin/bash
2	
3	#从1加到100的输出
4	 
5	for((i=1;i<=100;i++))
6	do
7		SUM=$[$SUM+$Si]
8	done
9	echo $SUM

```

##### while循环

```shell
while [条件判断]
do
	程序
done
```

```shell
#/bin/bash
#计算从1加到n的值
SUM=0
i=0
while [ $i -le $1 ] 	#$1代表控制台输入的数字（n）
do
        SUM=$[$SUM+$i]	#SUM自增
        i=$[$i+1]		#相当于i++
done        
echo "$SUM" 
           
```



![](/QQ截图20190819221952.png)



##### read读取控制台输入

read

：vim使用小技巧，yy复制一整行，p粘贴（需要在浏览模式下）

案例

```shell
#/bin/bash
#读取控制台输入的一个num值，在10秒内输入
read -p "请输入一个num值:" NUM
echo "您输入的值是:" $NUM

#读取控制台输入的一个num值，在5秒内输入
read -t 5 -p "请输入一个num值:" NUM2
echo "您输入的值是:" $NUM2               

结果：
[root@hadoop1 shell]# ./testRead.sh 
请输入一个num值:12
您输入的值是: 12
请输入一个num值:您输入的值是:		#5秒过后会自动跳出程序执行
```



##### 函数

分为系统函数和自定义函数

basename基本基本语法

功能:返回完整路径最后/的部分，常用于获取文件名
***basename [pathname] [suffix]***
***basename [string] [suffix]***
(功能描述: basename命令会删掉所有的前缀包括最后一个(“P' )
字符，然后将字符串显示出来。
选项:
suffix为后缀,如果suffx被指定了，basename会将pathname或string中的suffix去掉。

案例

```shell
[root@hadoop1 shell]# clear
[root@hadoop1 shell]# basename /root/shell/a.txt	#获取文件名带后缀的
a.txt
[root@hadoop1 shell]# basename /root/shell/a.txt .txt	#获取文件名不带后缀的
a
```

dirname基本语法
功能:返回完整路径最后/的前面的部分，常用于返回路径部分
**dirname**文件绝对路径
(功能描述:从给定的包含绝对路径的文件名中去除文件名(非目录的部分) ,
然后返回剩下的路径(目录的部分) )

案例

```shell
[root@hadoop1 shell]# dirname /root/shell/a.txt
/root/shell
```

##### 自定义函数

基本语法
[ function ] funname[()]
{
		Action;
		[return int;]

}	调用直接写函数名: funname

案例

```shell
#/bin/bash

#计算两个参数的和（read），getSum
function getSum(){
        SUM=$[$n1+$n2]
        echo "和是多少：$SUM"
}
read -p "请输入第一个数：" n1
read -p "请输入第二个数：" n2

#调用函数
getSum $n1 $n2		#将形参传入函数内部执行                      
```

##### 综合案例

```shell
#/bin/bash
#完成数据库的定时备份

#备份路径
BACKUP=/data/backup/db

#当前的时间作为文件名(格式化日期)
DATETIME=$(date +%Y_%m_%d_%H%M%S)

echo "===开始备份===="
echo "===备份的路径是 $BACKUP/$DATATIME.tar.gz"

#主机
HOST=localhost
#用户名
DB_USER=root
#密码
DB_PWD=root
#备份数据库的名称
DATABASE=test
#创建备份的路径，如果备份的文件夹存在就直接使用，否则就创建一个
[ ! -d "$BACKUP/$DATETIME.tar.gz" ] && mkdir -p "$BACKUP/$DATETIME"

#执行备份数据库的指令（备份到/data/backup/文件夹下）
mysqldump -u${DB_USER} -p${DB_PWD} --host=$HOST $DATABASE | gzip > $BACKUP/$DATETIME/$DATETIME.sql.gz

#打包备份文件
cd $BACKUP
tar -zvcf $DATETIME.tar.gz $DATETIME

#删除临时文件(已经拿到了解压后的文件就不需要压缩包了)
rm -rf $BACKUP/$DATETIME

#删除10天前的备份为见（find and rm）
find $BACKUP -mtime +10 -name "*.tar.gz" -exec rm -rf {} \;
echo "====备份文件成功===="

```



### Shell小脚本

##### 模拟Linux登录

```shell
#!/bin/bash
#模拟登录
echo -n "please input your username:  "
read username
echo -n "please input your password:  " 
read password
if [ $username == "root" -a $password == "root" ]
then
        echo "login suceesfuly" 
else
        if [ $username != "root" ]
        then
                echo "unknown username"
        else [ $password != "root" ]
                echo "wrong password" 
        fi
        echo "login error"
fi
exit 0

#结果
==>
[root@hadoop1 classic_ShellScript]# ./testlogin.sh 
please input your username:  root
please input your password:  q
wrong password
login error
```

