# Docker进阶版

# Docker Compose

## 简介

docker

dockerfile   build   run   手动操作，单个容器！

微服务，100个，依赖关系

Docker Compose 来轻松高效地管理容器。定义运行多个容器。



> 官方介绍

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. To learn more about all the features of Compose, see [the list of features](https://docs.docker.com/compose/#features).

定义、运行多个容器

yaml 配置文件

single command。什么命令？



Compose works in all environments: production, staging, development, testing, as well as CI workflows. You can learn more about each case in [Common Use Cases](https://docs.docker.com/compose/#common-use-cases).



**三步骤：**

Using Compose is basically a three-step process:

1. Define your app’s environment with a `Dockerfile` so it can be reproduced anywhere.
   - dockerfile保证我们项目能在任何地方运行。

1. Define the services that make up your app in `docker-compose.yml` so they can be run together in an isolated environment.
   - services 什么是服务？
   - docker-compose.yml这个文件怎么写？
2. Run `docker-compose up` and Compose starts and runs your entire app.
   - 启动项目。down停止



Compose是docker官方的开源项目。需要安装！

docker-compose.yml文件示例：

~~~shell
version: '2.0'
services:
  web:
    build: .
    ports:
    - "5000:5000"
    volumes:
    - .:/code
    - logvolume01:/var/log
    links:
    - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
~~~



Compose：重要的概念。

- 服务services，容器，应用。
- 项目。一组关联的容器。



## 安装

1、下载

~~~shell
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
~~~

2、赋权限

~~~shell
chmod +x /usr/local/bin/docker-compose
~~~



## 体验

地址：https://docs.docker.com/compose/gettingstarted/



1、应用 app.py

2、dockerfile 应用打包镜像

3、docker-compose.yml文件（定义整个服务，需要的环境。web、redis）

4、启动compose

完整的上线服务！



流程：

1、创建网络

2、执行构建

3、启动服务



看到done说明启动完毕了：

reating composetest_web_1   ... done
Creating composetest_redis_1 ... done

![image-20200830123318082](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830123318082.png)



文件夹名composetest 加上 服务名，服务名在docker-compose.yml中定义：

~~~shell
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
~~~

![image-20200830123452294](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830123452294.png)



docker images

![image-20200830123519296](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830123519296.png)

~~~shell
[root@jingxl ~]# docker service ls
Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.
~~~

默认的服务名  文件名_服务名 _num

如果以后有多个服务器，集群，  _num 代表副本数量。

集群状态：服务都不可能只有一个运行实例。弹性



网络规则

![image-20200830124021053](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830124021053.png)

项目中的内容都在同一个网络下



![image-20200830124239812](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830124239812.png)



![image-20200830124314620](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830124314620.png)

如果在同一个网络下，我们可以直接通过域名访问。



停止：

docker-compose down

ctrl + c

![image-20200830142013823](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830142013823.png)



以前都是单个docker run 启动容器。

现在通过docker-compose编写yaml文件，到时候一键启动、停止所有服务！



### **yaml 规则**

docker-compose.yml

官网文档地址：https://docs.docker.com/compose/compose-file/

~~~shell

version: ""		# 版本
services: 	# 服务
  服务1：
    # 服务配置
    images
    build
    network
    ……
  服务2：redis
    ……
  # 其他配置：网络/卷，全局规则
  volumes：
  network：
  configs：
~~~

只要多写，多看docker-compose.yml配置！

1、看官方文档

2、看开源项目



## 开源项目

### 部署博客

下载程序、安装数据库、配置……

compose项目 --->一键启动



1、下载项目（docker-compose.yml）

2、如果需要文件，准备

3、文件准备齐全，直接一键启动项目!



部署非常简单！

![image-20200830144522661](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200830144522661.png)



## 实战

1、编写项目微服务

2、dockerfile构建镜像

3、docker-compose.yml 编排项目

4、在服务器上启动。docker-compose up



小结：

未来项目只要有docker-compose文件，按照文件里的规则，启动编排容器！



假设项目要重新部署打包

~~~shell
docker-compose up --build		#重新构建镜像
~~~





总结：

compose：三层

- 工程project
- 服务
- 容器 运行实例   docker --> k8s



# Docker Swarm

集群

## 购买服务器

> 4台服务器 1核2G

腾讯云比阿里云便宜，这里用腾讯云！

![image-20200905105645993](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905105645993.png)

![image-20200905105921570](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905105921570.png)



到此，服务器购买完毕！

1主3从



## 4台机器安装Docker

和单机安装一样

技巧：直接同步操作



## 工作模式

Docker Engine 1.12 introduces swarm mode that enables you to create a cluster of one or more Docker Engines called a swarm. A swarm consists of one or more nodes: physical or virtual machines running Docker Engine 1.12 or later in swarm mode.

There are two types of nodes: [**managers**](https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/#manager-nodes) and [**workers**](https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/#worker-nodes).

![Swarm mode cluster](https://docs.docker.com/engine/swarm/images/swarm-diagram.png)

If you haven’t already, read through the [swarm mode overview](https://docs.docker.com/engine/swarm/) and [key concepts](https://docs.docker.com/engine/swarm/key-concepts/).



## 搭建集群

![image-20200905111758001](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905111758001.png)

![image-20200905111841076](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905111841076.png)

![image-20200905112031095](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905112031095.png)



10.206.0.12

![image-20200905112258929](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905112258929.png)

初始化节点`docker swarm init`

docker swarm join 加入一个节点！



~~~shell
# 获取令牌
docker swarm join-token manager
docker swarm join-token worker
~~~

![image-20200905112543922](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905112543922.png)



![image-20200905112619995](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905112619995.png)



把后面的节点都加入进去！

![image-20200905112825133](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905112825133.png)



步骤：

1、生成主节点

2、加入（管理者、worker）



## Raft协议

Raft协议：保证大多数节点存活才可以用。集群至少3台主节点起。



## 体会

弹性、扩缩容！

以后告别docker run

docker-compose up  	启动一个项目

集群：swarm  `docker service`



体验：

![image-20200905114552824](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905114552824.png)



创建服务，动态扩展、更新服务



![image-20200905114831517](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905114831517.png)

~~~shell
docker run 容器启动，不具有扩缩容
docker service  具有扩缩容，滚动更新！
~~~



查看服务

![image-20200905115729498](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905115729498.png)

动态扩缩容

~~~shell
docker service update --replicas 3 my-nignx
docker service scale my-nginx=5
~~~

这个服务，集群中的任意节点都可以访问。服务可以有多个副本动态扩缩容实现高可用！



移除命令：

~~~shell
docker service rm
~~~



## 概念总结

**swarm**

集群的管理和编排，docker可以初始化一个swarm集群，其他节点可以加入。（管理、worker）

**node**

就是一个docker节点。多个节点就组成了一个集群。

**service**

任务，可以在管理节点或工作节点运行。

**task**

运行容器的细节。

![image-20200905212101911](C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200905212101911.png)



命令  ----> 管理节点   ----> api   ----> 调度   ----> 工作节点（创建容器 task）



# docker stack

docker compose：单机部署项目

docker stack部署，集群部署！

~~~shell
# 单机
docker-compose up -d xx.yml
# 集群
docker stack depoly xx.yml  
~~~



# docker secret

安全配置，证书等



# docker config

配置



# 拓展到k8s

## 云原生时代

云应用



下载 ---> 配置