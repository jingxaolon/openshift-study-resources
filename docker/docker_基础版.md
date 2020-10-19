# Docker笔记



> 学前准备

1、Linux（必要）

cd、mkdir

2、springboot



docker？

devops



> docker学习

- Docker概述
- docker安装
- docker命令
  - 镜像命令
  - 容器命令
  - 操作命令
  - ……

- docker镜像
- docker数据卷
- dockerfile
- docker网络原理
- idea整合docker
- 集群 docker compose
- docker swarm
- ci/cd jenkins



# Docker概述

## docker为什么出现？

一款产品：开发--上线  两套环境！ 应用环境，应用配置

开发、运维人员。问题：我在我的电脑上可以运行！版本更新导致服务不可用！对于运维来说，考验就十分大。

开发及运维



环境配置是十分麻烦的，每一个机器都要部署环境（集群redis、es、Hadoop....容易部署错）！费时费力

发布一个项目， jar（需要redis mysql es jdk）、本来运行一个jar只要1分钟的事情，可是部署环境1天可能也部署不好，war，

能直接带着环境进行发布多好？项目能不能带上环境安装打包？



之前在服务器上配置一个应用的环境， 配置redis、msyql、jdk、es、Hadoop，配置超麻烦了，不能够跨平台。

window上，发布到linux上，环境不一样。

传统：jar，其他运维来做

现在：开发打包部署上线，一套流程做完，一个人就可以做完。





java ---写apk---发布（应用商店）--- 张三使用apk----安装既可以用

java--jar（环境）---打包项目带上环境（镜像）好比windows安装好后带有一些软件--- docker仓库：商店----下载我们发布的镜像---直接运行即可！



docker给以上的问题，提出了解决方案！

![image-20200816172243461](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816172243461.png)



docker的思想就来自于集装箱。

jre --多个应用（端口冲突）--原来都是交叉的

隔离：docker核心思想！打包装箱，每个箱子是互相隔离的。

水果  生化武器

这两个肯定不能放在一个箱子里。

docker通过隔离机制可以将咱们的服务器利用到极致。



本质：所有的技术都是因为出现了一些问题，我们需要去解决，才去学习。



## docker的历史

2010年，几个搞it的年轻人，就在美国成立了一家公司，最开始叫 `dotcloud`

做一些paas的云计算服务。LXC有关容器技术！

![image-20200816173535777](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816173535777.png)

他们将自己的技术 容器化技术， 进行了命名，就是docker

docker刚刚诞生的时候，没有引起行业的注意！ 就活不下去！

`开源`

开放源代码！

2013年，将docker开源！

docker越来越多的人发现了docker的优点！火起来了，docker每个月都会更新一个版本

2014年4.9，docker1.0发布

docker为什么这么火？相对于虚拟机十分轻巧！

在容器技术出来之前，我们都是使用虚拟机技术，

虚拟机：在windows中装一个vmware，通过软件我们可以虚拟出来一台或者多台电脑，特别笨重！

虚拟机也是属于虚拟化技术，docker容器技术，也是一种虚拟化技术！

~~~shell
vm：Linux centos原生镜像（说白了就是一个电脑！） 隔离，需要开启多个虚拟机！	几个G
docker：隔离，镜像（最核心的环境，jdk、mysql。十分的小巧），直接运行镜像就可以了！小巧!		几个m，kb，秒级启动！
~~~



> 聊聊docker

docker是基于go语言开发的！开源项目

官网：https://www.docker.com/

![image-20200816174722489](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816174722489.png)



文档：https://docs.docker.com/develop/ 

docker的文档是超级详细的！

仓库地址：https://hub.docker.com/

push pull



## docker能干嘛

> 之前的虚拟机技术

![image-20200816200114209](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816200114209.png)

虚拟机技术缺点：

1、资源占用十分多

2、冗余步骤多

3、启动很慢



> 容器化技术

容器化技术不是模拟的一个完整的操作系统

![image-20200816200532163](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816200532163.png)

比较docker和虚拟机技术的不同：

- 传统虚拟机，虚拟出一套硬件，运行一个完整的操作系统，然后在这个系统上安装和运行软件
- 容器内的应用直接运行在宿主机的内核，容器时没有自己的内核的，也没有虚拟我们的硬件，所以就轻便了
- 每个容器间是互相隔离的，每个容器内都有一个属于自己的文件系统，互不影响。



> devops （开发、运维）

**更快速的交付和部署**

传统：一堆帮助文档，安装程序

docker：打包镜像发布测试，一键运行

**更便捷的升级和扩缩容**

使用了docker之后，我们部署应用就和搭积木一样！

springboot 1.5  redis  5    tomcat 8

升级的话，每一个都得升级


项目打包为一个镜像，扩展 服务器A，直接在服务器B运行一个应用

**更简单的系统运维**

在容器化之后，我们的开发，测试环境都是高度一致的。

**更高效的计算资源利用：**

1核 2g的服务器

docker是内核级别的虚拟化，可以在一个物理机上可以运行很多的容器实例。

服务器的性能可以被压榨到极致。



# docker安装

## docker的基本组成

![img](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597590328752&di=84208e426f8b4c718de36b5e1bab934f&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F07%2F04%2F146760293629296553.PNG)

**镜像（image）：**

docker镜像就好比是一个模板，可以通过这个模板来创建容器服务，tomcat镜像---》run --> tomcat01 容器（提供服务），通过这个镜像可以创建多个容器，最终服务运行或者项目运行就是在容器中的。

**容器（container）：**

docker利用容器技术，独立运行一个或者一组应用，通过镜像来创建的。

启动、停止、删除，等基本命令

目前就可以把这个容器理解为就是一个简易的Linux系统，项目就在这个特别微型的系统上面运行。

**仓库（repository）：**

仓库就是存放镜像的地方。

仓库分为共有仓库和私有仓库。

docker hub（默认是国外的）

阿里云、网易云……都有容器服务（配置镜像加速）



## 安装docker

> 环境准备

1、需要会一点点的Linux基础

2、centos 7 

3、使用远程连接软件（xshell等）

> 环境查看

~~~shell
# 系统内核是 3.10 以上的
[root@promote ~]# uname -r
3.10.0-957.el7.x86_64
~~~

~~~shell
# 系统版本
[root@promote ~]# cat /etc/os-release
NAME="Red Hat Enterprise Linux Server"
VERSION="7.6 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.6"
PRETTY_NAME="Red Hat Enterprise Linux Server 7.6 (Maipo)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.6:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.6
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.6"
~~~

> 安装

帮助文档：https://docs.docker.com/engine/install/centos/

~~~shell
# 1、卸载旧的版本
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
                  
# 2、安装需要的依赖包
yum install -y yum-utils

# 3、设置镜像的仓库
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#默认是国外的，十分慢
    
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#推荐使用阿里云的，十分的快
    
# 更新yum软件包
yum makecache fast

# 4、安装docker相关的内容  docker-ce 社区版  ee 企业版
yum install -y docker-ce docker-ce-cli containerd.io

# 5、启动docker
systemctl start docker
systemctl enable docker

# 6、使用docker version 查看是否安装成功！
~~~

![image-20200816204243444](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816204243444.png)

~~~shell
# 7、hello-world
docker run hello-world
~~~

![image-20200816204647138](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816204647138.png)

~~~shell
# 8、查看一下 下载的这个 hello-world镜像
[root@promote ~]# docker images
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
hello-world                    latest              bf756fb1ae65        7 months ago        13.3kB
~~~

了解：卸载docker

~~~shell
# 1、卸载依赖 
yum remove docker-ce docker-ce-cli containerd.io

# 2、删除资源
rm -rf /var/lib/docker

# /var/lib/docker 	docker的默认工作路径
~~~



## 阿里云镜像加速

1、登录阿里云找到容器服务

![image-20200822111213612](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200822111213612.png)

2、找到镜像加速地址

![image-20200822111236494](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200822111236494.png)

3、配置使用



## 回顾hello word流程

![image-20200816211803505](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816211803505.png)



## 底层原理

**docker到底是怎么工作的**

docker是一个client-server结构，docker的守护进程运行在主机上，通过socket从客户端访问。

docker server 接收到docker-client的指令，就会执行换个命令。

![image-20200816212406461](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816212406461.png)

**docker为什么比VM快**？

1、docker有着比虚拟机更少的抽象层

![image-20200816212553745](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816212553745.png)

2、docker利用的是宿主机的内核，vm需要的是guest os

所以说，新建一个容器的时候，docker不需要像虚拟机一样重新加载一个操作系统内核，避免引导。虚拟机是加载guest os，分钟级别的，而docker是利用宿主机的操作系统，省略了这个复杂的过程，秒级的启动。

![image-20200816213113305](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816213113305.png)

![image-20200816213213432](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200816213213432.png)



# docker的常用命令

## 帮助命令

~~~shell
docker version		# 显示docker的版本信息
docker info			# 显示docker的系统信息，包括镜像和容器的数量
docker 命令 --help		# 帮助命令
~~~

帮助文档的地址：https://docs.docker.com/reference/



## 镜像命令

**docker images** 查看本地主机上的所有镜像

~~~shell
[root@promote ~]# docker images
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
hello-world                    latest              bf756fb1ae65        7 months ago        13.3kB

# 解释
REPOSITORY	镜像的仓库源
TAG			镜像的标签
IMAGE ID	镜像的ID
CREATED		镜像的创建时间
SIZE		镜像的大小

# 可选项
  -a, --all             Show all images (default hides intermediate images)
      --digests         Show digests
  -f, --filter filter   Filter output based on conditions provided
      --format string   Pretty-print images using a Go template
      --help            Print usage
      --no-trunc        Don't truncate output
  -q, --quiet           Only show numeric IDs
~~~

**docker search  搜索镜像**

~~~shell
[root@promote ~]# docker search mysql
NAME                              DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
mysql                             MySQL is a widely used, open-source relati...   9844                [OK]
mariadb                           MariaDB is a community-developed fork of M...   3595                [OK]

# 可选项，通过收藏来过滤
  -f, --filter filter   Filter output based on conditions provided
      --format string   Pretty-print search using a Go template
      --help            Print usage
      --limit int       Max number of search results (default 25)
      --no-trunc        Don't truncate output

--filter=STARS=3000		# 搜索出来的镜像就是STARS大于3000的
[root@promote ~]# docker search mysql --filter=STARS=3000
[root@promote ~]# docker search mysql --filter STARS=3000
NAME                DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
mysql               MySQL is a widely used, open-source relati...   9844                [OK]
mariadb             MariaDB is a community-developed fork of M...   3595                [OK]

[root@promote ~]# docker search mysql --filter STARS=5000
NAME                DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
mysql               MySQL is a widely used, open-source relati...   9844                [OK]
~~~

**docker pull 下载镜像**

~~~shell
# 下载镜像 docker pull  镜像名[:tag]
[root@promote ~]# docker pull mysql
Using default tag: latest		# 如果不写tag，默认就是latest
latest: Pulling from library/mysql
bf5952930446: Pull complete		# 分层下载，docker image的核心   联合文件系统
8254623a9871: Pull complete
938e3e06dac4: Pull complete
ea28ebf28884: Pull complete
f3cef38785c2: Pull complete
894f9792565a: Pull complete
1d8a57523420: Pull complete
6c676912929f: Pull complete
ff39fdb566b4: Pull complete
fff872988aba: Pull complete
4d34e365ae68: Pull complete
7886ee20621e: Pull complete
Digest: sha256:c358e72e100ab493a0304bda35e6f239db2ec8c9bb836d8a427ac34307d074ed		#签名
Status: Downloaded newer image for mysql:latest

# 指定版本下载
[root@promote ~]# docker pull mysql:5.7
5.7: Pulling from library/mysql
bf5952930446: Already exists
8254623a9871: Already exists
938e3e06dac4: Already exists
ea28ebf28884: Already exists
f3cef38785c2: Already exists
894f9792565a: Already exists
1d8a57523420: Already exists
5f09bf1d31c1: Pull complete
1b6ff254abe7: Pull complete
74310a0bf42d: Pull complete
d398726627fd: Pull complete
Digest: sha256:da58f943b94721d46e87d5de208dc07302a8b13e638cd1d24285d222376d6d84
Status: Downloaded newer image for mysql:5.7
~~~

**docker rmi 删除镜像**

~~~shell
[root@promote ~]# docker rmi -f 718a6da099d8		# 删除指定的容器
[root@promote ~]# docker rmi -f 718a6da099d8 镜像id 镜像id 镜像id		# 删除多个容器
[root@promote ~]# docker rmi -f $(docker images -aq)	# 删除全部的容器
~~~



## 容器命令

**说明：我们有了镜像才可以创建容器，来下载一个centos镜像来测试学习**

~~~shell
docker pull centos
~~~

**新建容器并启动**

~~~shell
docker run [可选参数] image

# 参数说明
--name="name"		容器名字 tomcat01 tomcat02，用来区分容器
-d					后台方式运行
-it					交互式运行，进入容器
-p					指定容器的端口  -p 8080:8080
	-p ip:主机端口:容器端口
	-p 主机端口:容器端口 （常用）
	-p 容器端口
	容器端口
#-p, --publish list                   Publish a container's port(s) to the host

-P					随机指定端口
#-P, --publish-all                    Publish all exposed ports to random ports


# 测试，启动并进入容器
[root@promote ~]# docker run -it centos /bin/bash
[root@fa6f8aec1011 /]# ls		# 查看容器内的centos；基础版本，很多命令都是不完善的！
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

#从容器中退回主机
[root@fa6f8aec1011 /]# exit
exit
[root@promote ~]# ls
anaconda-ks.cfg  ca-key.pem  ca.pem  ca.srl  cert.pem  client-extfile.cnf  client-key.pem  dir1  Dockerfile  extfile.cnf  server-cert.pem  server-key.pem
~~~

**列出所有运行的容器**

~~~shell
# docker ps 命令
	# 列出当前正在运行的容器
-a #列出当前正在运行的容器+历史运行过的容器
-n=?  # 显示最近创建的容器
-q  # 只显示容器的编号

[root@promote ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@promote ~]# docker ps  -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
fa6f8aec1011        centos              "/bin/bash"         2 minutes ago       Exited (0) About a minute ago                       hardcore_varahamihira
f73855917a9c        hello-world         "/hello"            24 hours ago        Exited (0) 24 hours ago                             admiring_heisenberg
[root@promote ~]#
~~~

**退出容器**

~~~shell
exit  # 直接停止容器并退出
Ctrl+p+q   #容器不停止退出
~~~

**删除容器**

~~~shell
docker rm 容器id					# 删除指定的容器，不能删除正在运行的容器，如果要强制删除，rm -f
docker rm -f $(docker ps -qa)	# 删除所有的容器

docker ps -qa | xargs docker rm # 删除所有的容器
~~~

**启动和停止容器的操作**

~~~shell
docker start 容器id		# 启动容器
docker restart 容器id		# 重启容器
docker stop 容器id		# 停止当前正在运行的容器
docker kill 容器id 		# 强制停止当前容器
~~~



## 常用其他命令

**后台启动容器**

~~~shell
# 命令 docker run -d 镜像名
[root@promote ~]# docker run -d centos

# 问题：docker ps 发现centos停止了

# 常见的坑，docker 使用后台运行，就必须要有一个前台进程，docker发现没有应用，就会自动停止
#比如nginx，容器启动发现没有提供服务，就会立刻停止，就好比没有程序运行了
~~~

**查看日志**

~~~shell
docker logs -f -t --tail 容器，没有日志

# 自己编写一段shell脚本
"while ture; do echo test;sleep 1 ;done"
[root@promote ~]# docker run -d centos /bin/bash -c "while true;do echo test;sleep 1 ;done"

[root@promote ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
6e4481ea205d        centos              "/bin/bash -c 'whi..."   4 seconds ago       Up 3 seconds                            amazing_joliot
79dc07c3a2b8        centos              "/bin/bash"              2 minutes ago       Up 2 minutes                            elated_cray

# 显示日志
-tf				# 显示日志
--tail number  # 要显示的日志条数
[root@promote ~]# docker logs -f -t --tail 10  6e4481ea205d
~~~

**查看容器中的进程信息**

~~~shell
# 命令 docker top 容器id
[root@promote ~]# docker top 6e4481ea205d
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                14511               14498               0                   08:45               ?                   00:00:00            /bin/bash -c while true;do echo test;sleep 1 ;done
root                14830               14511               0                   08:49               ?                   00:00:00            /usr/bin/coreutils --coreutils-prog-shebang=sleep /usr/bin/sleep 1

~~~

**查看镜像的元数据**

~~~shell
# 命令
docker inspect 容器id
 
# 测试
[root@promote ~]# docker inspect 6e4481ea205d
[
    {
        "Id": "6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160",
        "Created": "2020-08-17T12:45:49.438234126Z",
        "Path": "/bin/bash",
        "Args": [
            "-c",
            "while true;do echo test;sleep 1 ;done"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 14511,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2020-08-17T12:45:49.656601216Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:0d120b6ccaa8c5e149176798b3501d4dd1885f961922497cd0abef155c869566",
        "ResolvConfPath": "/var/lib/docker/containers/6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160/hostname",
        "HostsPath": "/var/lib/docker/containers/6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160/hosts",
        "LogPath": "/var/lib/docker/containers/6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160/6e4481ea205d9fc415d91be2652f5ec4b6a0de00015d46589deea461c6a56160-json.log",
        "Name": "/amazing_joliot",
        "RestartCount": 0,
        "Driver": "overlay",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "shareable",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay/1ce0507b0e2c0be497ac421dc14d1d2c0c7850c70ec36ed4073ef8e1f8e575f0/root",
                "MergedDir": "/var/lib/docker/overlay/681c0940da2c33ed23f284afbbaf7a10cf1ab2e6e43915c6eaab0463160a82ad/merged",
                "UpperDir": "/var/lib/docker/overlay/681c0940da2c33ed23f284afbbaf7a10cf1ab2e6e43915c6eaab0463160a82ad/upper",
                "WorkDir": "/var/lib/docker/overlay/681c0940da2c33ed23f284afbbaf7a10cf1ab2e6e43915c6eaab0463160a82ad/work"
            },
            "Name": "overlay"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "6e4481ea205d",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/bash",
                "-c",
                "while true;do echo test;sleep 1 ;done"
            ],
            "Image": "centos",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "org.label-schema.build-date": "20200809",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS"
            }
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "ffc2728166bbb8ae33a315da270ff31092fb77ec576597afe8945d8d7e311cec",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {},
            "SandboxKey": "/var/run/docker/netns/ffc2728166bb",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "66ff9ba221db982b5c9db21a94b7ea82f37dda81d167b7e98a0cf94c6d824913",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.3",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:03",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "030a7c8e2b46ff2bc9bbc6941151daa7da547e7579223856aed15a752d253b1c",
                    "EndpointID": "66ff9ba221db982b5c9db21a94b7ea82f37dda81d167b7e98a0cf94c6d824913",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:03",
                    "DriverOpts": null
                }
            }
        }
    }
]
~~~

**进入当前正在运行的容器**

~~~shell
# 我们通常容器都是使用后台方式运行的，我们需要进入容器，修改一些配置

# 命令
docker exec -it 容器id bashshell

# 测试
[root@promote ~]# docker exec -it 6e4481ea205d /bin/bash
[root@6e4481ea205d /]# ls
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@6e4481ea205d /]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 12:45 ?        00:00:00 /bin/bash -c while true;do echo test;sleep 1 ;done
root       789     0  0 12:58 pts/0    00:00:00 /bin/bash
root       807     1  0 12:59 ?        00:00:00 /usr/bin/coreutils --coreutils-prog-shebang=sleep /usr/bin/sleep 1
root       808   789  0 12:59 pts/0    00:00:00 ps -ef

# 方式二
docker attach 容器id

# 测试
[root@promote ~]# docker attach 6e4481ea205d
正在执行当前的代码


# docker exec  	# 进入容器后开启一个新的终端，可以在里面操作（常用）
# docker attach	# 进入容器正在执行的终端，不会启动新的进程
~~~

**从容器内拷贝文件到主机上**

~~~shell
docker cp 容器id:容器内路径 目的地主机路径

# 查看当前主机目录下
[root@iZuf6adj81pqvzkqiqfettZ ~]# cd /home/
[root@iZuf6adj81pqvzkqiqfettZ home]# ll
total 0

# 进入docker容器内部
[root@iZuf6adj81pqvzkqiqfettZ home]# docker run -it centos /bin/bash
[root@1a3599bba4b7 /]# cd /home/
[root@1a3599bba4b7 home]# ls
# 在容器内新建一个文件
[root@1a3599bba4b7 home]# touch test.java
[root@1a3599bba4b7 home]# ls
test.java
[root@1a3599bba4b7 home]# exit
exit
[root@iZuf6adj81pqvzkqiqfettZ home]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
1a3599bba4b7        centos              "/bin/bash"         56 seconds ago      Exited (0) 4 seconds ago                       recursing_elgamal

# 将这文件拷贝出来到主机上
[root@iZuf6adj81pqvzkqiqfettZ home]# docker cp 1a3599bba4b7:/home/test.java /home
[root@iZuf6adj81pqvzkqiqfettZ home]# ls
test.java

# 拷贝是一个手动过程，未来我们使用 -v 容器卷的技术，可以实现，自动同步。
~~~



## 小结

![image-20200817211315782](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200817211315782.png)

~~~shell
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes
~~~

docker的命令是十分多的，上面都是一些最常用的容器和镜像的命令，之后还会学习很多命令。



> 接下来就是一堆的练习

## 作业练习

> docker安装nginx

~~~shell
# 1、搜索镜像 search 建议去docker hub上搜索，能看到很多帮助文档信息。
# 2、下载镜像 pull 
# 3、运行测试
[root@promote home]# docker images
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
nginx                          latest              4bb46517cac3        3 days ago          133MB
centos                         latest              0d120b6ccaa8        6 days ago          215MB

# -d 后台运行
# --name 给容器命名
# -p 宿主机端口:容器内部端口
[root@promote home]# docker run -d --name nginx01 -p 3344:80 nginx
132c4286d3281cb025d1fbce532ad39a9f55b91e5e7bd8dbb45744a05cd75e3c
[root@promote home]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
132c4286d328        nginx               "/docker-entrypoin..."   5 seconds ago       Up 4 seconds        0.0.0.0:3344->80/tcp   nginx01
87718fa4621b        centos              "/bin/bash"              17 minutes ago      Up 17 minutes                              kind_chandrasekhar
[root@promote home]# curl localhost:3344
# 在浏览器中也可以输入ip:端口来访问nginx，访问阿里云服务器的服务需要确认映射的本地端口是否开放（阿里云安全组）

# 进入容器
[root@promote home]# docker exec -it nginx01 /bin/bash
root@132c4286d328:/# whereis nginx
nginx: /usr/sbin/nginx /usr/lib/nginx /etc/nginx /usr/share/nginx
root@132c4286d328:/# cd /etc/nginx
root@132c4286d328:/etc/nginx# ls
conf.d  fastcgi_params  koi-utf  koi-win  mime.types  modules  nginx.conf  scgi_params  uwsgi_params  win-utf
root@132c4286d328:/etc/nginx#

~~~

端口暴露的概念

![image-20200817212829906](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200817212829906.png)

思考问题：我们每次改动nginx配置文件，都需要进入容器内部，十分的麻烦，我要是可以在容器外部提供一个映射路径，达到在容器外部修改文件，容器内部就可以自动修改？ 

-v 数据卷技术



> 作业：docker来装一个tomcat

~~~shell
# 官方的使用
docker run -it --rm tomcat:9.0

# 我们之前的启动都是后台，停止了容器之后，容器还是可以查到   docker run -it --rm  ，一般用来测试，用完就删除

# 下载再启动
docker pull tomcat:9.0

# 启动运行
docker run -d -p 3355:8080 --name tomcat01 tomcat

# 测试访问没有问题
没有webapps   镜像的原因，默认是最小的镜像，所有不必要的都剔除掉。

# 进入容器
[root@promote home]# docker run -d -p 3355:8080 --name tomcat01 tomcat
114e278447bf20d5342f92abe2f2356fe83d45836f3219c7e0f7f415785bcf50
[root@promote home]# docker exec -it 114e278447bf /bin/bash
root@5d1de15bfe15:/usr/local/tomcat# ls
BUILDING.txt  CONTRIBUTING.md  LICENSE  NOTICE  README.md  RELEASE-NOTES  RUNNING.txt  bin  conf  lib  logs  native-jni-lib  temp  webapps  webapps.dist  work
root@5d1de15bfe15:/usr/local/tomcat# ls webapps
root@5d1de15bfe15:/usr/local/tomcat# ls webapps.dist/
ROOT  docs  examples  host-manager  manager
root@5d1de15bfe15:/usr/local/tomcat# cp -r webapps.dist/* webapps
root@5d1de15bfe15:/usr/local/tomcat# ls webapps
ROOT  docs  examples  host-manager  manager

# 发现问题，1、Linux命令少了，2、没有webapps   镜像的原因，默认是最小的镜像，所有不必要的都剔除掉。
# 保证最小可运行环境
~~~

思考问题：我们以后要部署项目，如果每次都要进入容器是不是十分麻烦？我要是可以在容器外部提供一个映射路径，webapps，我们在外部放置项目就自动同步到内部就好了。



docker容器  tomcat + 网站  docker mysql



> 作业：部署es+kibana

~~~shell
# es 暴露的端口很多
# es 十分的耗内存
# es 的数据一般需要放置到安全目录。挂载

# 启动 elasticsearch
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.8.1

# 发现：如果内存不够，则无法启动成功
[root@iZuf6adj81pqvzkqiqfettZ ~]# docker logs 9271c3c9b7eb
Exception in thread "main" java.lang.RuntimeException: starting java failed with [1]
output:
#
# There is insufficient memory for the Java Runtime Environment to continue.
# Native memory allocation (mmap) failed to map 1073741824 bytes for committing reserved memory.
# An error report file with more information is saved as:
# logs/hs_err_pid132.log
error:
OpenJDK 64-Bit Server VM warning: INFO: os::commit_memory(0x00000000c0000000, 1073741824, 0) failed; error='Not enough space' (errno=12)
        at org.elasticsearch.tools.launchers.JvmErgonomics.flagsFinal(JvmErgonomics.java:126)
        at org.elasticsearch.tools.launchers.JvmErgonomics.finalJvmOptions(JvmErgonomics.java:88)
        at org.elasticsearch.tools.launchers.JvmErgonomics.choose(JvmErgonomics.java:59)
        at org.elasticsearch.tools.launchers.JvmOptionsParser.jvmOptions(JvmOptionsParser.java:137)
        at org.elasticsearch.tools.launchers.JvmOptionsParser.main(JvmOptionsParser.java:95)


# 启动了 Linux服务器就卡了   docker stats 查看CPU的状态

# 测试一下 es是否运行成功
[root@promote home]# curl localhost:9200
{
  "name" : "9e5a376c9da2",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "NV2_Y2RQTJ2fwnptEM7uYQ",
  "version" : {
    "number" : "7.8.1",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "b5ca9c58fb664ca8bf9e4057fc229b3396bf3a89",
    "build_date" : "2020-07-21T16:40:44.668009Z",
    "build_snapshot" : false,
    "lucene_version" : "8.5.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}

# es 是十分耗内存的，1.xG   

# 查看 docker stats
CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
9e5a376c9da2        0.63%               1.228GiB / 1.795GiB   68.42%              1.18kB / 942B       699MB / 1.78MB      49
~~~

~~~shell
# 增加内存限制， 修改配置文件，  -e 环境配置修改
docker run -d --name elasticsearch02 -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms64m -Xmx512m" elasticsearch:7.8.1

# 查看 docker stats
CONTAINER           CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
5a298a19b3f5        97.51%              155MiB / 1.795GiB   8.43%               656B / 0B           189MB / 0B          23
~~~

~~~shell
[root@promote home]# curl localhost:9200
{
  "name" : "5a298a19b3f5",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "myWfK1UdSPi7_9Q4uRqBiw",
  "version" : {
    "number" : "7.8.1",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "b5ca9c58fb664ca8bf9e4057fc229b3396bf3a89",
    "build_date" : "2020-07-21T16:40:44.668009Z",
    "build_snapshot" : false,
    "lucene_version" : "8.5.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
~~~

作业:使用kibana连接es？思考网络如何才能连接过去

![image-20200817224936134](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200817224936134.png)



## 可视化

- portainer（）
~~~shell
docker run -d -p 8088:9000 \
--restart=always -v /var/run/docker.sock:/var/run/docker.sock --privileged=true portainer/portainer
~~~
- Rancher（CI/CD再来用）



**什么是portainer？**

Docker图形化界面管理工具。提供一个后台面板供我们操作

~~~shell
docker run -d -p 8088:9000 \
--restart=always -v /var/run/docker.sock:/var/run/docker.sock --privileged=true portainer/portainer
~~~

访问测试：外网:8088   http://ip:8088

![image-20200818203404512](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818203404512.png)

选择本地的

![image-20200818203443730](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818203443730.png)

进入之后的面板：

![image-20200818203550353](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818203550353.png)

![image-20200818203707462](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818203707462.png)

可视化面板我们平时不会使用，自己测试玩玩即可。



# docker镜像讲解

## 镜像是什么

镜像是一种轻量级、可执行的独立软件包，用来打包软件运行环境和基于运行环境开发的软件，它包含运行某个软件所需的所有内容，包括代码、运行时、库、环境变量和配置文件。



所有的应用直接打包docker镜像，就可以直接跑起来。

如何得到镜像：

- 从远程仓库下载

- 别人拷贝给你

- 自己制作一个镜像Dockerfile

  

## docker镜像加载原理

> UnionFS（联合文件系统）

我们下载镜像时看到的一层一层的就是这个！

UnionFS（联合文件系统）：Union文件系统（UnionFS）是一种分层、轻量级并且高性能的文件系统，它支持对文件系统的修改作为一次提交来一层层的叠加，同时可以将不同目录挂载到同一个虚拟文件系统下（unite several directories into a single virtual filesystem）。Union文件系统是Docker镜像的基础。镜像可以通过分层来进行继承，基于基础镜像（没有父镜像），可以制作各种具体的应用镜像。

特性：一次同时加载多个文件系统，但从外面看起来，只能看到一个文件系统，联合加载会把各层文件系统叠加起来，这样最终的文件系统会包含所有底层的文件和目录



> Docker镜像加载原理

docker的镜像实际上由一层一层的文件系统组成，这种层级的文件系统UnionFS。

bootfs（boot file system）主要包含bootloader和kernel，bootloader主要是引导加载kernel，Linux刚启动时会加载bootfs文件系统，在Dokcer镜像的最底层是bootfs。这一层与我们典型的Linux/Unix系统是一样的，包含boot加载器和内核。当boot加载完成之后整个内核就都在内存中了，此时内存的使用权已由bootfs转交给内核，此时系统也会卸载bootfs。

rootfs（root file system），在bootfs之上。包含的就是典型Linux系统中的/dev，/proc，/bin，/etc等标准目录和文件。rootfs就是各种不同的操作系统发行版，比如Ubuntu，centos等等。

![image-20200818205342101](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818205342101.png)

平时我们安装虚拟机的centos镜像都是好几个G，为什么docker这里才200M？

![image-20200818205707407](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818205707407.png)

对于精简的OS，rootfs可以很小，只需要包含最基本的命令，工具和程序库就可以了，因为底层直接用host的kernel，自己只需要提供rootfs就可以了。由此可见对于不同的Linux发行版，bootfs基本是一致的，rootfs会有差别，因此不同的发行版可以公用bootfs。



## 分层理解

> 分层的镜像

我们可以去下载一个镜像，注意观察下载的日志输出，可以看到是一层一层的在下载！

![image-20200818210134995](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818210134995.png)

思考：为什么docker镜像要采用这种分层的结构呢？

最大的好处，我觉得莫过于资源共享了，比如有多个镜像都从相同的base镜像构建而来，那么宿主机只需在磁盘上保留一份base镜像，同时内存中也只需要加载一份base镜像，这样就可以为所有的容器服务了，而且镜像的每一层都可以被共享。

查看镜像分层的方式可以通过doker image inspect 。

~~~shell
[root@promote ~]# docker image inspect redis:latest
[
		……
		
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:d0f104dc0a1f9c744b65b23b3fd4d4d3236b4656e67f776fe13f8ad8423b955c",
                "sha256:09b6608896c0a00497d9e9c1b045f0c906203555740dee64473db943244059c2",
                "sha256:ab0653e928a7c1d4b2f1c8e527d735aa0ea8dcb8c50e7cefc7680cf09cf6f985",
                "sha256:57094a432b39be6fc8a3f533567e10c354705eec37e4f7a8b5a7041a4ec63fa2",
                "sha256:1b80269d908f58520f9f3f00d75e65907eafa0f5143d5fe2b6cafcc30b32bc83",
                "sha256:1bd654b55bb49880160a60ad3a75c4b14254656229d535e943d8fb88124f6177"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        }
    }
]
~~~

**理解：**

所有的docker镜像都起始于一个基础镜像层，当进行修改或增加新的内容时，就会在当前镜像层之上，创建新的镜像层。

举一个简单的例子，假如基于Ubuntu Linux 16.04 创建一个新的镜像，这就是新镜像的第一层；如果在该镜像中添加python包，就会在基础镜像层之上创建第二个镜像层；如果继续添加一个安全补丁，就会创建第三个镜像层。

该镜像当前已经包含3个镜像层，如下图所示（这只是一个用于演示的很简单的例子）。

![image-20200818210957203](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818210957203.png)

在添加额外的镜像层的同时，镜像始终保持是当前所有镜像的组合，理解这一点非常重要。下图中举了一个简单的例子，每个镜像层包含3个文件，而镜像包含了来自两个镜像层的6个文件。

![image-20200818211942654](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818211942654.png)

上图中的镜像层跟之前图中的略有区别，主要目的是便于展示文件。

下图中展示了一个稍微复杂的三层镜像，在外部看来整个镜像只有6个文件，这是因为最上层中的文件7是文件5的一个更新版本。

![image-20200818212221713](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818212221713.png)

这种情况下，上层镜像层中的文件覆盖了底层镜像层中的文件。这样就使得文件的更新版本作为一个新镜像层添加到镜像当中。

docker通过存储引擎（新版本采用快照机制）的方式来实现镜像层堆栈，并保证多镜像层对外展示为统一的文件系统。

Linux上可用的存储引擎由AUFS、Overlay2、Device Mapper、Btrfs以及ZFS。顾名思义，每种存储引擎都基于Linux中对应的文件系统或者块设备技术，并且每种存储引擎都有其独有的性能特点。

docker在windows上仅支持windowsfilter一种存储引擎，该引擎基于NTFS文件系统之上实现了分层和Cow。

下图展示了与系统显示相同的三层镜像。所有镜像层堆叠并合并，对外提供统一的视图。

![image-20200818212920720](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818212920720.png)、

> 特点

Docker镜像都是只读的，当容器启动时，一个新的可写层被加载到镜像的顶部。

这一层就是我们通常说的容器层，容器之下的都叫镜像层。



如何提交一个自己的镜像

## commit镜像

~~~shell
docker commit 

# 命令和git类似
docker commit -m "提交的描述信息" -a "作者" 容器id 目标镜像名:tag
~~~

实战测试

~~~shell
# 1、启动一个默认的tomcat

# 2、发现这个默认的tomcat  是没有webapps应用，  是镜像的原因， 官方的镜像默认webapps下面是没有文件的！

# 3、我们自己拷贝进去了基本的文件

# 4、将我们操作过的容器通过commit提交为一个新的镜像，我们以后就使用我们修改过的镜像即可，这就是我们自己的一个修改过的镜像。
~~~

![image-20200818220424429](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818220424429.png)



学习方式说明：理解概念，但是一定要实践，最后实践和理论相结合一次搞定这个知识。

~~~shell
如果你想要保存当前容器的状态，就可以通过commit来提交，将获得一个新镜像。
~~~

到了这里才算是入门docker！



# 容器数据卷

## 什么是容器数据卷

**docker的理念回顾**

将应用和环境打包成一个镜像！

数据？如果数据都在容器中，那么我们容器一删除，数据就会丢失！  ==需求：数据可以持久化==

MySQL，容器删了，就是删库跑路了。==需求：MySQL的数据可以存储在本地==

容器之间可以有一个数据共享的技术。docker容器中产生的数据，同步到本地！

这就是数据卷。 目录的挂载，将容器内的目录，挂载到Linux上面。

![image-20200818221904161](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818221904161.png)

**总结一句话：容器的持久化和同步操作！容器间也是可以数据共享的！**

## 使用数据卷

> 方式一：直接使用命令来挂载  -v

~~~shell

docker run -it -v 主机目录:容器内目录 -p 主机端口:容器内端口

# 测试
[root@promote ~]# docker run -it -v /home/test:/home  centos /bin/bash

# 启动起来之后可以通过 docker inspect 容器id
~~~

![image-20200818222534249](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818222534249.png)

测试文件的同步

![image-20200818222929284](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818222929284.png)

再来测试：

1、停止容器

2、宿主机上修改文件

3、启动容器

4、容器内的数据依旧是同步的

![image-20200818223226593](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200818223226593.png)

好处：我们以后修改只需要在本地修改即可，容器内会自动同步！



## 实战：安装MySQL

思考：MySQL的数据持久化的问题

~~~shell
# 获取镜像
[root@promote ~]# docker  pull mysql:5.7

# 运行容器，需要做数据挂载！  # 安装启动mysql，需要配置密码的，这是要注意的点！
# 官方测试
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

# 启动我们的
-d 后台运行
-p 端口映射
-v 数据卷挂载
-e 环境配置
--name 容器名字
docker run -d -p 3310:3306 -v /home/mysql/conf:/etc/mysql/conf.d -v /home/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql:5.7

# 启动成功之后，在本地使用navicat 来测试连接一下
安装navicat并激活：
https://www.jianshu.com/p/1dc19a8be917

# navicat 连接到服务器的3310 --- 3310和容器内的 3306 映射，这个时候我们就可以连接上了

# 在本地测试创建一个数据库，查看一下我们映射的路径是否ok

~~~

假设我们将容器删除

![image-20200819213512396](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819213512396.png)

发现，我们挂载到本地的数据卷依旧没有丢失，这就实现了容器数据持久化功能！



## 具名和匿名挂载

~~~shell
# 匿名挂载
-v 容器内路
docker run -d -P --name nginx01 -v /etc/nginx nginx

# 查看所有的 volume 的情况
[root@promote ~]# docker volume ls
DRIVER              VOLUME NAME
local               05e03df19867fc3611080f2d6df7ee02da1001dd847c258ff389dc1a205c3543
local               0d0d044d3aa726509deae6fca13c7b28658dafbd8b02bab53515af01e290bded

# 这里发现 这种就是匿名挂载，我们在-v 只写了容器内的路径，没有写容器外的路径。

# 具名挂载
[root@promote ~]# docker run -d -P --name nginx02 -v juming-nginx:/etc/nginx nginx
f6d290cae9209b7f71a6dd2bdaf2d15e89d866bfac66840c17367150b3c63840
[root@promote ~]# docker volume ls
DRIVER              VOLUME NAME
local               juming-nginx


# 通过 -v 卷名:容器内路径
# 查看一下这个卷
~~~

![image-20200819214319599](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819214319599.png)

所有的docker容器内的卷，没有指定目录的情况下都是在`/var/lib/docker/volumes/xxx/_data`

我们通过具名挂载可以方便地找到我们的卷，大多数情况在使用的`具名挂载`

~~~shell
# 如何确定是具名挂在还是匿名挂载，
-v 容器内路径  	# 匿名挂载
-v 卷名:容器内路径   # 具名挂载
-v /宿主机路径:容器内路径  # 指定路径挂载
~~~

拓展：

~~~shell
# 通过-v 容器内路径；ro rw  改变读写权限
ro read only  # 只读
rw read write # 可读可写 
此时，在容器内，读写权限收到控制

#一旦设定了这个容器权限，容器对我们挂载出来的内容就有限定了!
docker run -d -P --name nginx02 -v juming-nginx:/etc/nginx:ro nginx
docker run -d -P --name nginx02 -v juming-nginx:/etc/nginx:rw nginx

# ro 只要看到ro 就说明这个路径只能通过宿主机来操作，容器内部是无法操作的。
~~~



## 初识dockerfile

dockerfile就是用来构建 docker镜像的构建文件！命令脚本

通过这个脚本可以生成镜像，镜像是一层一层的，脚本就是一个一个的命令，每个命令都是一层。



~~~shell
# 创建一个dockerfile文件，名字可以随意，建议DockerFile
# 文件中的内容
FROM centos
VOLUME ["volume01","volume02"]
CMD echo "---end---"
CMD /bin/bash

# 这里的每个命令，就是镜像的一层。
~~~

![image-20200819221840557](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819221840557.png)

~~~shell
# 启动自己写的容器
~~~

![image-20200819222314076](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819222314076.png)

这个卷和外部一定有一个同步的目录！

![image-20200819222401886](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819222401886.png)

~~~shell
# 在volume01中尝试创建一个文件
[root@f2261a8ea05a /]# cd volume01
[root@f2261a8ea05a volume01]# ls
[root@f2261a8ea05a volume01]# touch test
[root@f2261a8ea05a volume01]# exit
exit
~~~

查看一下卷挂载的路径

![image-20200819222550702](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819222550702.png)

测试一下刚才的文件是否同步出去了！

![image-20200819222646525](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200819222646525.png)

这种方式未来使用的十分多，因为我们通常会构建自己的镜像！

假设构建镜像时没有挂载卷，要手动挂载 -v 卷名:容器内路径





## 数据卷容器

两个mysql同步数据

![image-20200821153247306](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821153247306.png)

~~~shell
# 启动3个容器，通过我们刚才自己写的镜像启动
~~~

![image-20200821152519356](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821152519356.png)

~~~shell
# 在docker01内的volume01目录创建一个文件
[root@jingxl home]# docker run -it --name centos01 centostest01
[root@eb7363131114 /]# ls -l
total 56
lrwxrwxrwx  1 root root    7 May 11  2019 bin -> usr/bin
drwxr-xr-x  5 root root  360 Aug 22 10:04 dev
drwxr-xr-x  1 root root 4096 Aug 22 10:04 etc
drwxr-xr-x  2 root root 4096 May 11  2019 home
lrwxrwxrwx  1 root root    7 May 11  2019 lib -> usr/lib
lrwxrwxrwx  1 root root    9 May 11  2019 lib64 -> usr/lib64
drwx------  2 root root 4096 Aug  9 21:40 lost+found
drwxr-xr-x  2 root root 4096 May 11  2019 media
drwxr-xr-x  2 root root 4096 May 11  2019 mnt
drwxr-xr-x  2 root root 4096 May 11  2019 opt
dr-xr-xr-x 90 root root    0 Aug 22 10:04 proc
dr-xr-x---  2 root root 4096 Aug  9 21:40 root
drwxr-xr-x 11 root root 4096 Aug  9 21:40 run
lrwxrwxrwx  1 root root    8 May 11  2019 sbin -> usr/sbin
drwxr-xr-x  2 root root 4096 May 11  2019 srv
dr-xr-xr-x 13 root root    0 Aug 22 10:00 sys
drwxrwxrwt  7 root root 4096 Aug  9 21:40 tmp
drwxr-xr-x 12 root root 4096 Aug  9 21:40 usr
drwxr-xr-x 20 root root 4096 Aug  9 21:40 var
drwxr-xr-x  2 root root 4096 Aug 22 10:04 volume01
drwxr-xr-x  2 root root 4096 Aug 22 10:04 volume02
[root@eb7363131114 /]# cd volume01
[root@eb7363131114 volume01]# ls
[root@eb7363131114 volume01]# touch test
[root@eb7363131114 volume01]# ls
test
~~~

![image-20200821153623493](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821153623493.png)

![image-20200821153748972](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821153748972.png)

![image-20200821153933323](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821153933323.png)

~~~shell
# 测试：可以删除docker01，查看一下docker02和docker03是否还可以访问这些文件
# 依旧可以访问
~~~

![image-20200821154321189](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821154321189.png)

多个mysql实现数据共享

~~~shell
docker run -d -p 3310:3306 -v /etc/mysql/conf.d -v /var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql:5.7

docker run -d -p 3310:3306 -e MYSQL_ROOT_PASSWORD=123456 --name mysql02 --volumes-from mysql01 mysql:5.7

# 这个时候可以实现两个容器间的数据同步
~~~

**结论：**

容器之间配置信息的传递，数据卷容器的生命周期一直持续到没有容器使用为止

但是一旦持久化到了本地，这个时候，本地的数据是不会删除的！



# DockerFile

## dockerfile介绍

dockerfile是用来构建docker镜像的文件！类似命令参数脚本

构建步骤：

1、编写一个dockerfile文件

2、docker build 构建成为一个镜像

3、docker run 运行镜像

4、docker push 发布镜像（docker hub、阿里云镜像仓库）



查看一下官方是怎么做的

![image-20200821155421127](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821155421127.png)

点击tag中的标签，会跳转到github中的dockerfile

![image-20200821155504340](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821155504340.png)

很多官方的镜像都是基础版，很多功能没有，我们通常会自己构建自己的镜像。

官方既然可以制作镜像，那我们也可以！



## dockerfile构建过程

**基础知识：**

1、每个保留关键字（指令）都必须是大写字母

2、执行从上到下顺序执行

3、# 表示注释

4、每一个指令都会创建提交一个新的镜像层，并提交！

![image-20200821160120862](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821160120862.png)

dockerfile是面向开发的，我们以后要发布项目，做镜像，就需要编写dockerfie文件，这个文件十分简单！

dockerfile逐渐成为企业交付的标准，必须要掌握！



dockerfile：构建文件， 定义了所有的步骤

docker image：通过dockerfile构建生成的镜像，最终发布和运行的产品，原来是依靠jar、war

docker容器：容器就是镜像运行起来提供服务的。



## dockerfile的指令

~~~shell
FROM   # 基础镜像，一切从这里开始构建
MAINTAINER		# 镜像是谁写的，姓名+邮箱
RUN 	# docker镜像构建的时候需要的运行的命令
ADD		# 步骤：搭建具有tomcat的镜像，这个tomcat的压缩包就是添加内容
WORKDIR  # 镜像的工作目录
VOLUME	#挂载卷
EXPOSE  #暴露端口
RUN		#运行镜像
CMD 	# 指定这个容器启动的时候要运行的命令。  只有最后一个会生效，可被替代
		#在一个 Dockerfile 文件中只能有一个 CMD 指令，如果有多个 CMD 指令，则只有最后一个会生效。
ENTRYPOINT	# 指定这个容器启动的时候要运行的命令，可以追加命令
ONBUILD # 当构建一个被继承的dockerfile ，这个时候就会运行ONBUILD的指令，触发指令。
COPY	# 类似ADD，将文件拷贝到镜像中
ENV 	# 构建的时候设置环境变量
~~~

![image-20200821162009180](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821162009180.png)



## 实战测试

docker hub中 99%的镜像都是从这个基础镜像过来的，FROM scratch，然后配置需要的软件和配置来进行构建的。

![image-20200821163042324](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821163042324.png)

> 创建一个自己的centos

~~~shell
# 1、编写dockerfile的文件
[root@promote dockerfile]# cat mydockerfile
FROM centos

MAINTAINER jxl<1198285059@qq.com>

ENV MYPATH /usr/local

WORKDIR $MYPATH

RUN yum install -y vim

RUN yum install -y net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "---end---"
CMD /bin/bash

# 2、通过这个文件构建镜像
# 命令docker build -f dockerfile文件路径 -t 镜像名:版本号
Successfully built e79281b1062d
Successfully tagged mycentos:0.1

# 3、测试运行
~~~

对比：之前的原生的centos

![image-20200821210141939](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821210141939.png)

我们增加之后的镜像

![image-20200821210226275](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821210226275.png)

我们可以列出本地镜像的变更历史

![image-20200821210335620](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821210335620.png)

我们平时拿到一个镜像，可以研究一下它是怎么做的。



>CMD 和 ENTRYPOINT  区别

~~~shell
CMD 	# 指定这个容器启动的时候要运行的命令。  只有最后一个会生效，可被替代
ENTRYPOINT	# 指定这个容器启动的时候要运行的命令，可以追加命令
~~~

测试CMD

~~~shell
# 编写 dockerfile 文件
[root@promote dockerfile]# vim dockerfile-cmd
FROM centos
CMD ["ls","-a"]

# 构建镜像
[root@promote dockerfile]# docker build -f dockerfile-cmd -t cmdtest .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM centos
 ---> 0d120b6ccaa8
Step 2/2 : CMD ls -a
 ---> Running in 85172a49b6b1
 ---> dc24f4020f01
Removing intermediate container 85172a49b6b1
Successfully built dc24f4020f01
Successfully tagged cmdtest:latest

# run运行，发现ls -a 命令生效
[root@promote dockerfile]# docker run dc24f4020f01
.
..
.dockerenv
bin
dev
etc
home
lib
lib64
lost+found
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var

# 想追加一个命令
[root@promote dockerfile]# docker run dc24f4020f01 -l
container_linux.go:265: starting container process caused "exec: \"-l\": executable file not found in $PATH"
docker: Error response from daemon: oci runtime error: container_linux.go:265: starting container process caused "exec: \"-l\": executable file not found in $PATH".

# cmd的情况下， -l 替换了CMD ["ls","-a"] 命令， -l 不是命令所以报错
~~~

测试ENTRYPOINT

~~~shell

[root@promote dockerfile]# vim dockerfile-entrypoint
FROM centos
ENTRYPOINT ["ls","-a"]

[root@promote dockerfile]# docker build -f dockerfile-entrypoint -t entrypoint .
Sending build context to Docker daemon  4.096kB
Step 1/2 : FROM centos
 ---> 0d120b6ccaa8
Step 2/2 : ENTRYPOINT ls -a
 ---> Running in add2b808df22
 ---> 169cae292ef4
Removing intermediate container add2b808df22
Successfully built 169cae292ef4
Successfully tagged entrypoint:latest
[root@promote dockerfile]# docker run 169cae292ef4
.
..
.dockerenv
bin
dev
etc
home
lib
lib64
lost+found
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var

# 我们的追究命令，是直接拼接在我们的ENTRYPOINT命令的后面！
[root@promote dockerfile]# docker run 169cae292ef4 -l
total 0
drwxr-xr-x.   1 root root  46 Aug 21 13:15 .
drwxr-xr-x.   1 root root  46 Aug 21 13:15 ..
-rwxr-xr-x.   1 root root   0 Aug 21 13:15 .dockerenv
lrwxrwxrwx.   1 root root   7 May 11  2019 bin -> usr/bin
drwxr-xr-x.   5 root root 340 Aug 21 13:15 dev
drwxr-xr-x.   1 root root  66 Aug 21 13:15 etc
drwxr-xr-x.   2 root root   6 May 11  2019 home
lrwxrwxrwx.   1 root root   7 May 11  2019 lib -> usr/lib
lrwxrwxrwx.   1 root root   9 May 11  2019 lib64 -> usr/lib64
drwx------.   2 root root   6 Aug  9 21:40 lost+found
drwxr-xr-x.   2 root root   6 May 11  2019 media
drwxr-xr-x.   2 root root   6 May 11  2019 mnt
drwxr-xr-x.   2 root root   6 May 11  2019 opt
dr-xr-xr-x. 128 root root   0 Aug 21 13:15 proc
dr-xr-x---.   2 root root 162 Aug  9 21:40 root
drwxr-xr-x.  11 root root 163 Aug  9 21:40 run
lrwxrwxrwx.   1 root root   8 May 11  2019 sbin -> usr/sbin
drwxr-xr-x.   2 root root   6 May 11  2019 srv
dr-xr-xr-x.  13 root root   0 Aug 21 12:52 sys
drwxrwxrwt.   7 root root 145 Aug  9 21:40 tmp
drwxr-xr-x.  12 root root 144 Aug  9 21:40 usr
drwxr-xr-x.  20 root root 262 Aug  9 21:40 var

~~~

dockerfile中很多命令都十分的相似，我们需要了解他们的区别，我们最好的学习就是对比他们，然后测试效果。



> CMD和ENTRYPOINT 总结、区分

**CMD总结**

~~~shell
# CMD 总结区分：
# 1、多个CMD存在的话，只有最后一个CMD生效
[root@jingxl dockerfile]# cat ceshiCMD
FROM centos
CMD ls -a
CMD ls -l

# 运行结果
[root@jingxl dockerfile]# docker run --rm 5d7ca4213b2e
total 48
lrwxrwxrwx  1 root root    7 May 11  2019 bin -> usr/bin
drwxr-xr-x  5 root root  340 Aug 22 13:15 dev
drwxr-xr-x  1 root root 4096 Aug 22 13:15 etc
……

# 2、CMD的主要目的是为正在执行的容器提供默认值。
# 如果在构建镜像时使用了CMD，则可以直接运行docker run image，相当于在docker run image时增加了一些命令或参数
# 如果在docker run image 时指定了需要运行的命令，则会覆盖CMD所包含的命令

# 运行结果
[root@jingxl dockerfile]# docker run --rm 5d7ca4213b2e ls
bin
dev
etc
……

# 3、CMD可以为ENTRYPOINT指令提供默认参数，则CMD和ENTRYPOINT指令都应该使用JSON数组格式指定。
# 备注：exec形式会被解析为JSON数组，这意味着必须对单词使用双引号，而不是单引号。
[root@jingxl dockerfile]# cat ceshiCMDandENTRYPOINT
FROM centos

ENTRYPOINT ["ls"]
CMD ["-l"]

# 测试结果
[root@jingxl dockerfile]# docker run --rm b8ef6c5079f8
total 48
lrwxrwxrwx  1 root root    7 May 11  2019 bin -> usr/bin
drwxr-xr-x  5 root root  340 Aug 22 13:23 dev
drwxr-xr-x  1 root root 4096 Aug 22 13:23 etc
……

# 如果CMD和ENTRYPOINT指令配合使用时，不都写成JSON数组格式的话，结果看下面的执行。
[root@jingxl dockerfile]# docker build -f ceshiCMDandENTRYPOINT -t rntest:1.0 .
Sending build context to Docker daemon  6.144kB
Step 1/3 : FROM centos
 ---> 0d120b6ccaa8
Step 2/3 : ENTRYPOINT ["ls"]
 ---> Using cache
 ---> 8dbac1914259
Step 3/3 : CMD -l			#CMD 这里没有写成json格式
 ---> Running in 4b87ced52e77
Removing intermediate container 4b87ced52e77
 ---> 9672dcec677a
Successfully built 9672dcec677a
Successfully tagged rntest:1.0
[root@jingxl dockerfile]# docker run --rm 9672dcec677a
lrwxrwxrwx 1 root root 4 Aug 22 03:15 /bin/sh -> bash

# 发现执行结果不符合预期
# 进行分析
[root@jingxl dockerfile]# docker history rntest:1.0
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
9672dcec677a        3 minutes ago       /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "-l"]    0B
8dbac1914259        5 minutes ago       /bin/sh -c #(nop)  ENTRYPOINT ["ls"]            0B
0d120b6ccaa8        11 days ago         /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
<missing>           11 days ago         /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B
<missing>           11 days ago         /bin/sh -c #(nop) ADD file:538afc0c5c964ce0d…   215MB

# 从它的构建过程来看，CMD -l 被解释成了CMD ["/bin/sh" "-c" "-l"]，此时是属于json格式的，那么将
# 作为ENTRYPOINT的参数
# 实际执行的方式就如下所示。
[root@jingxl dockerfile]# ls "/bin/sh" "-c" "-l"
lrwxrwxrwx. 1 root root 4 Jul 11  2019 /bin/sh -> bash
~~~



**ENTRYPOINT 总结**

~~~shell
# 1、同样，在Dockerfile中 ENTRYPOINT 只有最后一条生效，如果写了10条，前边9条都不生效
[root@jingxl dockerfile]# cat entrypoint
FROM centos

ENTRYPOINT ls
ENTRYPOINT pwd

# 执行结果
[root@jingxl dockerfile]# docker run --rm f5c01fb34dc5
/

# 2、ENTRYPOINT可以为执行的容器增加默认值。
# 如果在构建镜像时使用了ENTRYPOINT，同样可以直接运行docker run image，相当于在docker run image时增加了一些命令或参数
# 如果在docker run image 时增加了需要运行的命令，则会添加ENTRYPOINT到所包含的命令后面
[root@jingxl dockerfile]# cat ceshientrypoint
FROM centos

ENTRYPOINT ls

# 执行结果
[root@jingxl dockerfile]# docker build -f ceshientrypoint -t entry:1.0 .
Sending build context to Docker daemon  7.168kB
Step 1/2 : FROM centos
 ---> 0d120b6ccaa8
Step 2/2 : ENTRYPOINT ls
 ---> Running in ef26cd2ba70d
Removing intermediate container ef26cd2ba70d
 ---> be8e5f6c50d7
Successfully built be8e5f6c50d7
Successfully tagged entry:1.0
[root@jingxl dockerfile]# docker run --rm be8e5f6c50d7 -l
bin
dev
etc
……
~~~



## 实战：tomcat镜像

1、准备镜像文件 tomcat压缩包，jdk的压缩包

![image-20200821214348476](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821214348476.png)

2、编写dockerfile文件，官方命名 `Dockerfile`，build会自动寻找这个文件，就不需要-f指定了。

~~~shell
FROM centos
MAINTAINER jxl<1198285059@qq.com>

ADD jdk-8u261-linux-x64.tar.gz /usr/local
ADD apache-tomcat-9.0.22.tar.gz /usr/local

RUN yum install -y vim

ENV MYPATH /usr/local
WORKDIR $MYPATH

ENV JAVA_HOME /usr/local/jdk1.8.0_261
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.22
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

EXPOSE 8080

CMD /usr/local/apache-tomcat-9.0.22/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.22/bin/logs/catalina.out
~~~

3、构建镜像

~~~shell
docker build -t diytomcat .
~~~

4、启动镜像

~~~shell
docker run -d -p 9090:8080 --name jxltomcat -v /home/tomcat/test:/usr/local/apache-tomcat-9.0.22/webapps/test -v /home/tomcat/tomcatlog:/usr/local/apache-tomcat-9.0.22/logs diytomcat
~~~

5、访问测试

6、发布项目（由于做了卷挂载，我们直接在本地编写项目就可以发布了！）

~~~xml
[root@jingxl /]# cd /home/tomcat/test
[root@jingxl test]# mkdir webinfo
[root@jingxl test]# cd webinfo/
[root@jingxl webinfo]# vim web.xml

<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                               http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
           version="2.5">

</web-app>
~~~

~~~jsp
[root@jingxl webinfo]# cd ..
[root@jingxl test]# vim index.jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>hello jxl</title>
</head>
<body>
Hello World!<br/>
<%
System.out.println("---my test web logs---");
%>
</body>
</html>
~~~

发现：项目部署成功，可以直接访问。

访问：http://ip:9090/test/

我们以后开发的步骤：需要掌握dockerfile的编写，我们之后的一切都是使用docker镜像来发布运行。



## 发布自己的镜像

> dockerhub

1、地址：https://hub.docker.com/

注册自己的账号

2、确定这个账号可以登录

3、在我们的服务器上提交自己的镜像

~~~shell
[root@promote test]# docker login --help

Usage:  docker login [OPTIONS] [SERVER]

Log in to a Docker registry

Options:
      --help              Print usage
  -p, --password string   Password
      --password-stdin    Take the password from stdin
  -u, --username string   Username

[root@promote test]# docker login -u jingxl
Password:
Login Succeeded
~~~

4、登陆完毕后就可以提交镜像了，就是一步 docker push

~~~shell
# push自己的镜像到服务器上！
[root@promote test]# docker push diytomcat
The push refers to a repository [docker.io/library/diytomcat]
91879ee22da2: Preparing
090ed8dda8ff: Preparing
917ad7f367d7: Preparing
291f6e44771a: Preparing
denied: requested access to the resource is denied

# push镜像遇到的问题
[root@promote test]# docker push jingxl/diytomcat:1.0
The push refers to a repository [docker.io/jingxl/diytomcat]
An image does not exist locally with the tag: jingxl/diytomcat

# 解决：tag一下镜像
[root@promote test]# docker tag 3b07bd77a22c jingxl/tomcat:1.0

# docker push即可！自己发布的镜像尽量带上版本号
[root@promote test]# docker push jingxl/tomcat:1.0
The push refers to a repository [docker.io/jingxl/tomcat]
91879ee22da2: Preparing
090ed8dda8ff: Pushed
917ad7f367d7: Pushing [==================================================>]  353.3MB
291f6e44771a: Pushing [===>                                               ]  16.36MB/215.1MB
~~~

提交的时候也是按照镜像的层级来进行提交的！



> 阿里云镜像服务上

1、登陆阿里云

2、找到容器镜像服务

3、创建命名空间

![image-20200821225222471](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821225222471.png)



4、创建容器镜像仓库



![image-20200821225306387](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821225306387.png)

5、点进去创建好的容器镜像仓库

![image-20200821225345147](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200821225345147.png)

阿里云容器镜像就参考官方地址

~~~shell
# 将镜像推送到Registry步骤
# 1、登录
docker login --username=dejavu泷 registry.cn-shanghai.aliyuncs.com

# 2、给镜像打tag
docker tag 337c884eb2ef registry.cn-shanghai.aliyuncs.com/jingxltest/test:1.0
# 结果
[root@jingxl ~]# docker images
REPOSITORY                                          TAG                 IMAGE ID            CREATED             SIZE
diytomcat                                           latest              337c884eb2ef        21 minutes ago      640MB
registry.cn-shanghai.aliyuncs.com/jingxltest/test   1.0                 337c884eb2ef        21 minutes ago      640MB

# 3、推送镜像
docker push registry.cn-shanghai.aliyuncs.com/jingxltest/test:1.0
~~~



## 小结

![image-20200822223158462](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200822223158462.png)



# docker网络

## 理解docker网络（docker0）

清空所有环境

> 查看网络

![image-20200823101111138](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823101111138.png)

三个网络

~~~shell
# 问题：docker是如何处理容器网络的？
~~~

![image-20200823101254668](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823101254668.png)

~~~shell
[root@jingxl ~]# docker run -d -P --name tomcat01 tomcat

# 查看容器的内部网络地址  ip a
[root@jingxl ~]# docker exec -it tomcat01 ip a		发现容器启动的时候会得到 eth0@if7 的网卡，docker分配的！
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
6: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever

# 思考：Linux能不能ping通容器内部！
[root@jingxl ~]# ping 172.17.0.2
PING 172.17.0.2 (172.17.0.2) 56(84) bytes of data.
64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.088 ms
64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.063 ms

# Linux可以ping通docker容器内部
~~~

> 原理

1、我们每启动一个docker容器，docker就会给docker容器分配一个ip，我们只要安装了docker，就会有一个网卡docker0。

桥接模式，使用的技术是evth-pair技术！

再次测试ip a

![image-20200823101938338](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823101938338.png)

2、再启动一个容器测试，发现又多了一对网卡。

![image-20200823102058205](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823102058205.png)

![image-20200823102159214](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823102159214.png)

~~~shell
# 我们发现这些网卡都是一对一对的。
# evth-pair 就是一对虚拟设备接口，他们都是成对出现的，一端连着协议，一端彼此相连。
# 正因为有这个特性，evth-pair 充当一个桥梁，连接各种虚拟网络设备的
# OpenStack，docker容器之间的连接，OVS的连接，都是使用evth-pair技术
~~~

3、我们来测试一下tomcat01和tomcat02是否可以ping通

~~~shell
[root@jingxl ~]# docker exec tomcat01 ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
6: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
[root@jingxl ~]# docker exec tomcat02 ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
8: eth0@if9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
[root@jingxl ~]# docker exec tomcat02 ping 172.17.0.2
PING 172.17.0.2 (172.17.0.2) 56(84) bytes of data.
64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.099 ms
64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.065 ms
^C

# 结论：容器和容器之间是可以互相ping通的！
~~~

绘制一个网络模型图：

![image-20200823103555655](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823103555655.png)

结论：tomcat01和tomcat02是公用的一个路由器，docker0

所有的容器不指定网络的情况下，都是docker0路由的，docker会给我们容器分配一个默认可用的ip

255.255.0.0/16

00000000.00000000.00000000.00000000

255.255.255.255

255.255.0.0   256*256-0.0.0.0-255.255.255.255    大概是65535左右



255.255.0.0/24   域  局域网



> 小结

docker使用的是Linux的桥接，docker0是宿主机中的一个docker容器的网桥

![image-20200823104723738](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823104723738.png)

docker中的所有的网络接口都是虚拟的。虚拟的转发效率高！

只要容器删除，对应的一对网桥就没有了！

![image-20200823110022238](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823110022238.png)



## --link

> 思考一个场景，我们编写了一个微服务，database  去连接一个ip。ip可能一直都会变，我们希望可以处理这个问题，希望可以用名字来进行容器访问。

~~~shell
[root@jingxl ~]# docker exec tomcat02 ping tomcat01
ping: tomcat01: Name or service not known

# 如何可以解决呢？

# 通过--link就可以解决网络联通问题
[root@jingxl ~]# docker run -d -P --name tomcat03 --link tomcat02 tomcat
90f9f9322fe5832709a4e70284527fcf3e9a9b5cde3ed0cf55b47703f33b385b
[root@jingxl ~]# docker exec tomcat03 ping tomcat02
PING tomcat02 (172.17.0.3) 56(84) bytes of data.
64 bytes from tomcat02 (172.17.0.3): icmp_seq=1 ttl=64 time=0.086 ms
^C

# 反向可以ping通吗？
[root@jingxl ~]# docker exec tomcat02 ping tomcat03
ping: tomcat03: Name or service not known

~~~

探究：docker inspect 

![image-20200823110111694](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823110111694.png)

其实这个tomcat03就是在本地配置了tomcat02

~~~shell
# 查看hosts配置
[root@jingxl ~]# docker exec tomcat03 cat /etc/hosts
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
172.17.0.3      tomcat02 b250d3e1d8af
172.17.0.4      90f9f9322fe5

~~~

本质探究：--link就是在host配置中增加了一个映射

~~~shell
# tomcat02没有配置--link就没有映射
[root@jingxl ~]# docker exec tomcat02 cat /etc/hosts
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
172.17.0.3      b250d3e1d8af
~~~

我们现在玩docker已经不建议使用--link



自定义网络！不适用docker0

docker0问题：它不支持容器名访问。



## 自定义网络

容器互联：

> 查看所有的docker网络

![image-20200823111530174](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823111530174.png)

**网络模式**

bridge：桥接模式  docker上搭桥  （默认）

none：不配置网络

host：和宿主机共享网络

container：容器内网络连通（用的少，局限大）



**测试：**

~~~shell
# 我们直接启动的命令，--net bridge  而这个就是哦我们的docker0
[root@jingxl ~]# docker run -d -P --name tomcat01 tomcat
[root@jingxl ~]# docker run -d -P --name tomcat01 --net bridge tomcat

# docker0特点：默认，域名方式是不能访问的，--link可以打通连接

# 我们可以自定义网络！
# --driver bridge 
# --subnet 192.168.0.0/16		192.168.0.2-192.168.255.255
# --gateway 192.168.0.1
[root@jingxl ~]# docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 mynet
8757e952ecbb72062124883f731e041417e27bac207a2a7c92a31f11cb86e6bb

[root@jingxl ~]# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a796d2e1fbb0        bridge              bridge              local
017e88859852        host                host                local
8757e952ecbb        mynet               bridge              local
~~~

我们自己的网络就创建好了！

![image-20200823112400601](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823112400601.png)

~~~shell
# 创建容器后再次查看创建的网络
[root@jingxl ~]# docker run -d -P --name tomcat01 --net mynet tomcat
aa3f5209faf0682142689ae65409ccd447cdb37d295ade2d107e9234cf7fa0fa
[root@jingxl ~]# docker run -d -P --name tomcat02 --net mynet tomcat
11e594acdcc109688ea093c8a1a667a991d8245fa948edd59ca7c73c79dbcccd
[root@jingxl ~]# docker network inspect mynet
[
    {
        "Name": "mynet",
        "Id": "8757e952ecbb72062124883f731e041417e27bac207a2a7c92a31f11cb86e6bb",
        "Created": "2020-08-23T11:21:45.1360161+08:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.168.0.0/16",
                    "Gateway": "192.168.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "11e594acdcc109688ea093c8a1a667a991d8245fa948edd59ca7c73c79dbcccd": {
                "Name": "tomcat02",
                "EndpointID": "ac1bcfe49de62286e9a11afd79686ccd2906d60f17ad3f1d723e0b59a5205a39",
                "MacAddress": "02:42:c0:a8:00:03",
                "IPv4Address": "192.168.0.3/16",
                "IPv6Address": ""
            },
            "aa3f5209faf0682142689ae65409ccd447cdb37d295ade2d107e9234cf7fa0fa": {
                "Name": "tomcat01",
                "EndpointID": "7104dafdf924451e12dd60b106dce0f8718e5e1d685f352761c71d5b7133e75e",
                "MacAddress": "02:42:c0:a8:00:02",
                "IPv4Address": "192.168.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

# 再次测试ping
[root@jingxl ~]# docker exec tomcat01 ping "192.168.0.3"
PING 192.168.0.3 (192.168.0.3) 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=1 ttl=64 time=0.087 ms
^C

# 现在不使用--link也可以ping通
[root@jingxl ~]# docker exec tomcat01 ping tomcat02
PING tomcat02 (192.168.0.3) 56(84) bytes of data.
64 bytes from tomcat02.mynet (192.168.0.3): icmp_seq=1 ttl=64 time=0.042 ms
64 bytes from tomcat02.mynet (192.168.0.3): icmp_seq=2 ttl=64 time=0.086 ms
~~~

我们自定义的网络docker都已经帮我们维护好了对应的关系，推荐我们平时这样使用网络！



好处：

redis : 不同的集群使用不同的网络，保证集群是安全和健康的

mysql

![image-20200823113117849](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823113117849.png)



## 网络联通

![image-20200823145450942](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823145450942.png)

![image-20200823145514764](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823145514764.png)

~~~shell
# 测试，打通tomcat01 --> mynet
[root@jingxl ~]# docker network connect mynet tomcat01

# 联通之后就是将 tomcat01加入到mynet网络下
# 一个容器两个ip地址
# 阿里云 公网ip 私网ip
~~~

![image-20200823145704569](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823145704569.png)

~~~shell
# 01 连通
[root@jingxl ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
2af58d7f83e4        tomcat              "catalina.sh run"   10 minutes ago      Up 10 minutes       0.0.0.0:32779->8080/tcp   tomcat-mynet-02
cdd477d3a045        tomcat              "catalina.sh run"   10 minutes ago      Up 10 minutes       0.0.0.0:32778->8080/tcp   tomcat-mynet-01
6642f249a745        tomcat              "catalina.sh run"   11 minutes ago      Up 11 minutes       0.0.0.0:32777->8080/tcp   tomcat02
f7ef24c70529        tomcat              "catalina.sh run"   11 minutes ago      Up 11 minutes       0.0.0.0:32776->8080/tcp   tomcat01
[root@jingxl ~]# docker exec tomcat01 ping tomcat-mynet-01
PING tomcat-mynet-01 (192.168.0.2) 56(84) bytes of data.
64 bytes from tomcat-mynet-01.mynet (192.168.0.2): icmp_seq=1 ttl=64 time=0.080 ms
64 bytes from tomcat-mynet-01.mynet (192.168.0.2): icmp_seq=2 ttl=64 time=0.079 ms
^C

# 02 是依旧打不通的
[root@jingxl ~]# docker exec tomcat02 ping tomcat-mynet-01
ping: tomcat-mynet-01: Name or service not known
~~~

结论：假设要跨网络操作别人，就需要使用docker network connect 连通！



## 实战：部署redis集群

![image-20200823150551661](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823150551661.png)

shell脚本启动！

~~~shell
# 创建网卡
docker network create redis --subnet 172.38.0.0/16

# 通过脚本创建6个redis配置
for port in $(seq 1 6); \
do \
mkdir -p /mydata/redis/node-${port}/conf
touch /mydata/redis/node-${port}/conf/redis.conf
cat << EOF > /mydata/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 172.38.0.1${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
appendonly yes
EOF
done

docker run -p 637${port}:6379 -p 1637${port}:16379 --name redis-${port} \
-v /mydata/redis/node-${port}/data:/data \
-v /mydata/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.1${port} redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 手动启动
docker run -p 6371:6379 -p 16371:16379 --name redis-1 \
-v /mydata/redis/node-1/data:/data \
-v /mydata/redis/node-1/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.11 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

docker run -p 6372:6379 -p 16372:16379 --name redis-2 \
-v /mydata/redis/node-2/data:/data \
-v /mydata/redis/node-2/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.12 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

docker run -p 6373:6379 -p 16373:16379 --name redis-3 \
-v /mydata/redis/node-3/data:/data \
-v /mydata/redis/node-3/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.13 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

docker run -p 6374:6379 -p 16374:16379 --name redis-4 \
-v /mydata/redis/node-4/data:/data \
-v /mydata/redis/node-4/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.14 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

docker run -p 6375:6379 -p 16375:16379 --name redis-5 \
-v /mydata/redis/node-5/data:/data \
-v /mydata/redis/node-5/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.15 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

docker run -p 6376:6379 -p 16376:16379 --name redis-6 \
-v /mydata/redis/node-6/data:/data \
-v /mydata/redis/node-6/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.16 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 创建集群
/data # redis-cli   --cluster create 172.38.0.11:6379  172.38.0.12:6379  172.38.0.13:6379 172.38.0.14:6379 172.38.0.15:6379 172.38.0.16:6379 --cluster-replica
s 1
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 172.38.0.15:6379 to 172.38.0.11:6379
Adding replica 172.38.0.16:6379 to 172.38.0.12:6379
Adding replica 172.38.0.14:6379 to 172.38.0.13:6379
M: 667b489a41a59826c8eac259b1edc63aef8fdb66 172.38.0.11:6379
   slots:[0-5460] (5461 slots) master
M: afcbafa41d701a44d22c539d5cb8722ffbcc257b 172.38.0.12:6379
   slots:[5461-10922] (5462 slots) master
M: 8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e 172.38.0.13:6379
   slots:[10923-16383] (5461 slots) master
S: ba50cf28c382e01d59b884bd5711b0f84a7ad076 172.38.0.14:6379
   replicates 8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e
S: 0deafd1ebfb4c81434371b75d4663471d9a91af0 172.38.0.15:6379
   replicates 667b489a41a59826c8eac259b1edc63aef8fdb66
S: 9c34fdbbf57420d4a94dea8ad92f24f558915726 172.38.0.16:6379
   replicates afcbafa41d701a44d22c539d5cb8722ffbcc257b
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
...
>>> Performing Cluster Check (using node 172.38.0.11:6379)
M: 667b489a41a59826c8eac259b1edc63aef8fdb66 172.38.0.11:6379
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: 9c34fdbbf57420d4a94dea8ad92f24f558915726 172.38.0.16:6379
   slots: (0 slots) slave
   replicates afcbafa41d701a44d22c539d5cb8722ffbcc257b
M: 8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e 172.38.0.13:6379
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
M: afcbafa41d701a44d22c539d5cb8722ffbcc257b 172.38.0.12:6379
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
S: ba50cf28c382e01d59b884bd5711b0f84a7ad076 172.38.0.14:6379
   slots: (0 slots) slave
   replicates 8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e
S: 0deafd1ebfb4c81434371b75d4663471d9a91af0 172.38.0.15:6379
   slots: (0 slots) slave
   replicates 667b489a41a59826c8eac259b1edc63aef8fdb66
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.

# 测试
/data # redis-cli -c
127.0.0.1:6379>
127.0.0.1:6379>
127.0.0.1:6379>
127.0.0.1:6379> cluster info
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:1
cluster_stats_messages_ping_sent:96
cluster_stats_messages_pong_sent:99
cluster_stats_messages_sent:195
cluster_stats_messages_ping_received:94
cluster_stats_messages_pong_received:96
cluster_stats_messages_meet_received:5
cluster_stats_messages_received:195
127.0.0.1:6379> cluster nodes
9c34fdbbf57420d4a94dea8ad92f24f558915726 172.38.0.16:6379@16379 slave afcbafa41d701a44d22c539d5cb8722ffbcc257b 0 1598167577765 6 connected
8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e 172.38.0.13:6379@16379 master - 0 1598167577000 3 connected 10923-16383
afcbafa41d701a44d22c539d5cb8722ffbcc257b 172.38.0.12:6379@16379 master - 0 1598167577064 2 connected 5461-10922
667b489a41a59826c8eac259b1edc63aef8fdb66 172.38.0.11:6379@16379 myself,master - 0 1598167577000 1 connected 0-5460
ba50cf28c382e01d59b884bd5711b0f84a7ad076 172.38.0.14:6379@16379 slave 8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e 0 1598167576000 4 connected
0deafd1ebfb4c81434371b75d4663471d9a91af0 172.38.0.15:6379@16379 slave 667b489a41a59826c8eac259b1edc63aef8fdb66 0 1598167577566 5 connected
127.0.0.1:6379> set a b
-> Redirected to slot [15495] located at 172.38.0.13:6379
OK
172.38.0.13:6379> get a
Could not connect to Redis at 172.38.0.13:6379: Host is unreachable
(32.31s)
not connected>
/data # redis-cli -c
127.0.0.1:6379> get a
-> Redirected to slot [15495] located at 172.38.0.14:6379
"b"
172.38.0.14:6379> cluster nodes
0deafd1ebfb4c81434371b75d4663471d9a91af0 172.38.0.15:6379@16379 slave 667b489a41a59826c8eac259b1edc63aef8fdb66 0 1598167812612 5 connected
8db019410cc9fbdacc0aa9c749a2e7b1a5bf2c4e 172.38.0.13:6379@16379 master,fail - 1598167677953 1598167676247 3 connected
afcbafa41d701a44d22c539d5cb8722ffbcc257b 172.38.0.12:6379@16379 master - 0 1598167812000 2 connected 5461-10922
9c34fdbbf57420d4a94dea8ad92f24f558915726 172.38.0.16:6379@16379 slave afcbafa41d701a44d22c539d5cb8722ffbcc257b 0 1598167811609 6 connected
ba50cf28c382e01d59b884bd5711b0f84a7ad076 172.38.0.14:6379@16379 myself,master - 0 1598167811000 7 connected 10923-16383
667b489a41a59826c8eac259b1edc63aef8fdb66 172.38.0.11:6379@16379 master - 0 1598167812111 1 connected 0-5460
172.38.0.14:6379>
~~~

docker搭建redis集群完成！



![image-20200823153040856](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823153040856.png)

![image-20200823153134799](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200823153134799.png)

我们使用了docker之后，所有的技术都会慢慢地变得简单起来！



# springboot微服务打包为docker镜像

安装破解版2020 IDEA：https://chens.life/2020-2-idea.html

安装破解版2018 IDEA：https://www.cnblogs.com/miaoxingren/p/9868734.html

1、构建springboot项目

2、打包应用

3、编写dockerfile

4、构建镜像

5、发布运行



以后我们使用了docker之后，给别人交付的就是一个镜像即可！



到了这里我们已经完全够用了docker！



预告：如果有很多镜像？100个镜像？



企业级



# docker compose







# docker swarm







# ci/cd之jenkins

