---
typora-root-url: images
---

# Dubbo学习之路

### 单一应用架构

当一个应用流量很小的时候，将整个项目打包到一个服务器中，这时候需要考虑的性能就是降低增删改查的工作量，典型的（**ORM**）的l理念

![](/QQ截图20200329162301.png)

垂直应用架构

一个完整的互联网项目必定会有多个模块，模块之间可能互不相通，也可能互相依赖使用，将单独的一个业务模块拆分成一个独立的应用单元，例如：订单模块只负责处理订单业务，用户模块只负责用户的相关操作

如果某个应用模块的访问量单体服务器无法承受的时候，就可以将这个应用模块拓展到多台服务器上， 提高性能和效率

**这样的应用架构适合模块之间没有太大的交流和依赖，设计到模块之间必须搭配使用才能生效的情况下推荐使用 *分布式架构* **

### 分布式架构

![](/QQ截图20200329163118.png)

### RPC

简称： **远程服务调用** 

RPC [Remote Procedure Call]是指**远程过程调用**，是种进程间通信方式，他是一种技术的思想，而不是规范。允许程序调用另-个地址空间(通常是共享网络的另台机器上)的过程或函数，而不用程序员显式编码这个远程调用的细节。即程序员无论是调用本地的还是远程的函数，本质上编写的调用代码基本相同。

影响RPC框架的效率的亮点是：通信效率和序列化和反序列化效率

**Call ID映射** ：在本地调用中，程序是通过函数的指针去找到对应的方法，函数指针指向方法所在的内存区域，而在远程调用中，y远程的方法是无法通过函数指针来的，因为两者属于不同的机器其函数方法的地址内存空间是完全不一样的，需要在远程的方法带有一个唯一的**标识的ID** ，调用者调用时附上这个ID，就能找到对应的方法

**序列化和反序列化** ：本地函数调用是将参数压到栈中，函数在栈中读取，在远程方法中调用方法和执行方法是在不同的进程中，甚至不是同一种语言，把参数序列化成字节流，所有的语言都能识别，将字节流转换为能读取的格式，



### Dubbo特性

面向接口代理的RPC调用、服务注册和发现、智能负载均衡、高可用高拓展，运行期间流量调度（通过配置不同的路由规则，实现灰度发布）



### Dubbo注册中心

![](/QQ截图20200329175149.png)



#### 推荐使用的注册中心

#### [Zookeeper](http://zookeeper.apache.org/) <推荐使用>

是 Apacahe Hadoop 的子项目，是一个树型的目录服务，支持变更推送，适合作为 Dubbo 服务的注册中心，工业强度较高，可用于生产环境，并推荐使用 。

![](/zookeeper.jpg)



#### 添加依赖

需要在provider和consumer中添加Zookeeper客户端依赖

```xml
<dependency>
    <groupId>org.apache.zookeeper</groupId>
    <artifactId>zookeeper</artifactId>
    <version>3.3.3</version>
</dependency>
```

##### 两种客户端实现：

**zkclient客户端**

```properties
# 在SpringBoot中配置
dubbo.registry.client=zkclient
```

```xml
<dependency>
    <groupId>com.github.sgroschupf</groupId>
    <artifactId>zkclient</artifactId>
    <version>0.1</version>
</dependency>
```

**curator客户端**

```properties
dubbo.registry.client=curator
```

```xml
<dependency>
    <groupId>com.netflix.curator</groupId>
    <artifactId>curator-framework</artifactId>
    <version>1.1.10</version>
</dependency>
```





#### Multicast 

Multicast 注册中心，不需要启动任何中心节点，只要广播地址一样，就可以互相发现

1. 提供方启动时广播自己的地址
2. 消费方启动时广播订阅请求
3. 提供方收到订阅请求时，单播自己的地址给订阅者，如果设置了 `unicast=false`，则广播给订阅者
4. 消费方收到提供方地址时，连接该地址进行 RPC 调用。

适合小规模应用和开发阶段

配置

```xml
<dubbo:registry address="multicast://224.5.6.7:1234" />

<dubbo:registry protocol="multicast" address="224.5.6.7:1234" />
```

当一个机器上有多个消费者的时候，由于Multicast的单播发送将提供者的地址信息发送给消费者，可能一台服务器上的某个消费者只能接受到一个消息，消费者需声明 `unicast=false`，当服务者和消费者运行在同一台机器上，消费者同样需要声明`unicast=false`

```xml
<dubbo:registry address="multicast://224.5.6.7:1234?unicast=false" />
```

```xml
<dubbo:registry protocol="multicast" address="224.5.6.7:1234">
    <dubbo:parameter key="unicast" value="false" />
</dubbo:registry>
```



另外还有`Nacos注册中心、Redis注册中心、Simple注册中心



### Windows启动Zookeeper

`Zookeeper`的工程bin目录下，在Cmd中执行`zkServer.cmd`启动器，启动ZK的服务 ，默认端口是2181

![](/QQ截图20200331210046.png)

使用ZK自带的Cli客户端测试ZK服务器是否启动成功，`zkCli.cmd`

![](/QQ截图20200331212131.png)





### Dubbo的主要模块

只有核心模块jar包可以下载到，其它的均无法直接下载，所以我们需要构建dubbo

![](/20171119182514384.png)



### Dubbo的配置

#### 基于注解

推荐使用注解的方式，适用于SpringBoot项目

```properties
spring:
    dubbo:
        application:
          name: ${spring.application.name}	--当前工程的名字
        registry:
          address: zookeeper://116.62.139.15:2181	--Zookeeper的注册地址
        protocol:
          port: 20883		--Dubbo的端口号
          name: dubbo		--名字
        consumer：
          timeout: 30000
```

在非分布式项目中，接口和调用接口者是在一个项目下，也就是在一个Spring容器下，可以使用`@AutoWired`或`Reference`进行自动装配，分布式项目下，可能接口和调用者不再一个服务器内，需要通过Dubbo进行远处服务调用，需要使用**`@Reference`**调用外部的接口