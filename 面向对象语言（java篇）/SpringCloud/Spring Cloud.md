---
typora-root-url: images
---

## Spring Cloud进修之路



**官方网站：**<https://spring.io/projects/spring-cloud>

**中文文档** ：<https://www.springcloud.cc/spring-cloud-dalston.html>

**技术栈参考文档**：<https://www.springcloud.cc/spring-cloud-netflix.html>

**中国社区：**<http://springcloud.cn/>





### 微服务

提倡将单一应用程序划分成一组小的服务，每个服务运行在独立的进程中，服务之间相互协调、互相配合，例如在银行的的存钱、取钱和转账三个完全是分在不同的服务中，分布在不同的服务器上，但是最终却能协调运作完成类似一个项目的功能

微服务之间采用的是轻量级的基于HTTP的 **Restful** 风格（dubbo是基于RPC）

将传统的一站式应用，拆分成一个一个的服务，每一个服务都是一个独立的进程，且能有自己的数据库，一个服务只做一件事情

SpringCloud是微服务的一种实现方式



#### 微服务的优缺点

1. **优点：**

   每个服务都是一个小型的工程，代码易理解，每一个服务只有单一职责，是一个独立单一的实体，可以独立部署升级，因此当前服务的异常或者改动对其他的服务不会影响，易拓展耦合度低

   微服务可以使用不同的开发语言，无论是开发和部署都可以独立分开，方便集成第三方工具

   **微服务只是业务逻辑的代码，不会和HTML，CSS等页面组件混合**

2. **缺点**：

   复杂度高，要处理服务与服务之间的关系、连接和互相调用。每一个服务都有其数据库，在保证数据的一致性时需要额外操作，服务与服务之间需要通过`RPC`或`restful`进行通信，增加通信时延，开发时可能需要了解整个系统的架构和流程

3. **它具备了灵活部署、可扩展、技术异构等优点，但同时也带来了开发、运维的复杂性。**


#### 微服务技术栈

多种技术的集合体，	微服务的架构 
微服务条目			落地技术
服务开发				Springboot、Spring、SpringMVC	
服务配置与管理	 	Netflix公司的Archaius、阿里的Diamond等	
服务注册与发现	 	Eureka、Consul、Zookeeper等	
服务调用				Rest、RPC、gRPC	
服务熔断器			Hystrix、Envoy等	
负载均衡				Ribbon、Nginx等	
服务接口调用(客户端调用服务的简化工具)	Feign等	
消息队列				Kafka、RabbitMQ、ActiveMQ等	
服务配置中心管理	SpringCloudConfig、Chef等	
服务路由（			API网关）	Zuul等	
服务监控				Zabbix、Nagios、Metrics、Spectator等	
全链路追踪			Zipkin，Brave、Dapper等	
服务部署				Docker、OpenStack、Kubernetes等	
数据流操作开发包	SpringCloud Stream（封装与Redis,Rabbit、Kafka等发送接收消息）	
事件消息总线	Spring Cloud Bus	
......		



#### 微服务之间的通讯方式

同步：RPC、RESTFul等

异步：消息队列，ActiveMQ、Kafka等



### Spring Cloud 和 dubbo

#### 组成模块

- **Dubbo**主要分为**服务注册中心，服务提供者，服务消费者，还有管控中心**；
- SpringCloud则是一个完整的分布式一站式框架，他有着一样的**服务注册中心，服务提供者，服务消费者，管控台，断路器，分布式配置服务，消息总线，以及服务追踪**等；

#### 通信机制

- Dubbo底层是使用`Netty`这样的`NIO`框架，是基于`TCP协议`传输的，配合以`Hession`序列化完成`RPC`
- SpringCloud是基于`Http协议+rest接口调用远程`过程的，相对来说，Http请求会有更大的报文，占的带宽也会更多。

![](/主流微服务框架之间的区别.bmp)

**SpringCloud有最全面的组成模块，技术栈足够完成一个完整的微服务架构，dubbo停滞了五年，让背靠Spring社区的SpringCloud有了后来居上的能力**



### SpringCloud的版本对应

目前时间是2020年2月20日，SpringCloud和SpringBoot的版本对应

![](/QQ截图20200220114456.png)



### SpringCloud的技术集

可以说，`SpringCloud`并不是单纯是一个框架，是对微服务多个技术的技术实现，也就是说，单凭SpringCloud本身是无法完成微服务的架构

![](/diagram-distributed-systems.svg)

`SpringCloud`, 基于`SpringBoot`提供了一 套微服务解决方案,包括**服务注册与发现，配置中心，全链路监控，服务网关，负载均衡，熔断器**等组件，除了基于NetFlix的开源组件做高度抽象封装之外，还有一些选型中立的开源组件。

`SpringCloud`利用`SpringBoot`的开发便利性巧妙地简化了分布式系统基础设施的开发, SpringCloud为开发 人员提供了快速构建分布式系统的一些工具，包括**配置管理、服务发现、 断路器、路由、微代理、事件总线、全局锁、决策竞选、分布式**会话等等它们都可以用SpringBoot的开发风格做到一键启动和部署。

`SpringBoot`并没有重复制造轮子, 它只是将目前各家公司开发的比较成熟、经得起实际考验的服务框架组合起来,通过SpringBoot风格进行再封装屏蔽掉了复杂的配置和实现原理，最终给开发者留出了-套简单易懂、易部署和易维护的分布式系统开发工具包



### Spring Cloud和Spring Boot的关系

- Boot可以独立开发，Cloud是依附于Boot 的
- Boot注重于开发微服务单体（也就是一个个项目），Cloud注重于协调各个微服务单体，也就是将一个个Boot项目整合并管理
- Spring Boot专注于快速、方便的开发单个微服务个体，Spring Cloud关注全局的服务治理框架。



### Spring Cloud的落地实现

Cloud集成了诸多技术，每个技术实现都对应着一项热门的技术	

![](/QQ截图20200214122927.png)



### 微服务案例

实体类需要继承`Serializable`接口，Cloud是基于HTTP的Rest 通信，网络之间的传输最终要转换为二进制流，Java的序列化操作是必不可少的

在Spring Boot工程中，自动化配置省去大部分的配置项，@Service添加在Impl实现类里，才会被容器扫描

```java
@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptDao deptDao;
```

@Mapper注解添加到Mapper接口上，Spring Boot的启动类就不用添加`MapperScan`注解扫描

```java
@SpringBootApplication
//@MapperScan(basePackages = "com.sunny.springcloud.service")
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}
```



##### RestTemplate

有三个参数(url, requestMap, ResponseBean.class)这三个参数分别代表
**REST请求地址、请求参数、HTTP响应**转换被转换成的对象类型。

```java
@RequestMapping(value="/consumer/dept/get/{id}")
public Dept get(@PathVariable("id") Long id)
{
    return restTemplate.getForObject(REST_URL_PREFIX + "/dept/get/" + id, Dept.class);
}

@SuppressWarnings("unchecked")
@RequestMapping(value="/consumer/dept/list")
public List<Dept> list()
{
    return restTemplate.getForObject(REST_URL_PREFIX + "/dept/list", List.class);
}
```



### SpringCloud版本对应

![](/1375038-20190616163011109-1565312463.png)



### Eureka服务注册

如上所示，消费者微服务对生产者微服务调用，需要使用`RestTemplate`类手动调用，效率低下，

dubbo中对应的是zookeeper，在Cloud中是使用Eureka作为注册中心	

Eureka是**Netflix**的一个子模块,也是核心模块之一。Eureka是一 个基于`REST`的服务,用于**定位服务**,以实现云端中间层服务发现和故障转移。**服务注册与发现**对于微服务架构来说是非常重要的,有了服务发现与注册，***只需要使用服务的标识符,就可以访问到服务,而不需要修改服务调用的配置文件了。功能类似于dubbo的注册中心，比如Zookeeper。***

Eureka Server是作为服务注册功能的注册中心，提供服务注册功能，采用了C-S设计架构

EurekaClient是Java客户端



#### 服务注册

服务注册:将服务所在主机、端口、版本号、通信协议等信息登记到注册中心上

**（等同于你将别人的的手机号存储到你的电话簿里）**

#### 服务发现

服务发现:服务消费者向注册中心请求已经经登记的服务列表,然后得到某个服务的主机、端口、版本号、通信协议等信息，从而实现对具体服务的调用;

**（等同于通过自己的电话谱查找需要联系的人的电话号码，姓名、地址等信息）**



#### CAP理论

一个分布式系统是不可能满足的`C（一致性）`、`A（可用性）`和`P（分区容错性`三个条件，因此最多只能满足其中两项



#### Eureka和zookeeper

- Eureka满足AP，zookeeper保证CP
- 当服务集群的时候，zookeeper当 **Master **节点（master是主节点，其他的时候从节点）发生故障的时候，剩余的节点会重新进行leader选举选择新的master节点，选举节点是需要一定的时间的，选举期间整个**ZooKeeper集群都是不可用的**，这就导致在选举期阃注册**服务瘫痪**。在云部署的环境下，因网络问题使得ZooKeeper集群失去master节点是大概率事件,虽然服务最终能够恢复,但是在选举时间内会导致服务注册长期不可用
- Eureka优先保证可用性, Eureka 各个节点是平等的,几个节点挂掉不会影响正常节点的工作，剩余的节点依然可以提供注册和查询服务。而Eureka的客户端在向某个Eureka注册或时如果发现连接失败，则会自动切换至其它节点,**只要有一台Eureka还在,就能保证注册服务可用(保证可用性)**，只不过查到的信息可能不是最新的(不保证强一致性)



#### 配置Eureka的踩坑路

SpringCloud中Eureka配置有诸多难处

1. 在POM文件添加**SpringCloud的依赖**，Cloud有严格的版本对应，`Finchley.RC2`版本对应的是SpringBoot的2.0x，不支持2.1x或者以下低级版本

   （由于访问的是外网仓库，在下载Eureka依赖的时候回特别慢。耐心的泡杯咖啡吧）

   ```xml
   <!-- 添加对SpringCloud的指定版本依赖 -->
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>Finchley.RC2</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   <!-- eureka在maven仓库中无法下载，需要配置指导的SpringCloud仓库 -->
   <repositories>
       <repository>
           <id>spring-milestones</id>
           <name>Spring Milestones</name>
           <url>https://repo.spring.io/libs-milestone</url>
           <snapshots>
               <enabled>false</enabled>
           </snapshots>
       </repository>
   </repositories>
   ```

2. 修改application.properties文件

   ```properties
   server.port=8083

   # 注册服务中心的name
   eureka.instance.hostname=localhost
   # 表示当前注册中心是服务注册中心，不需要想自己注册自己，默认的注册中新需要将注册中心注册到服务注册中心
   eureka.client.register-with-eureka=false
   # 表示不需要去检索其他的服务，服务注册中心的本质就是维护其他服务实例
   eureka.client.fetch-registry=false
   # 指定注册中心的位置
   eureka.client.service-url.defaulZone=http://${eureka.instance.hostname}:${server.port}/eureka/

   ```

3. 在启动器上添加Eureka注解，表示该模块是注册中心模块

   ```java
   @SpringBootApplication
   @EnableEurekaServer     //开启Eureka服务端
   public class SpringcloudEurekaServerApplication {

       public static void main(String[] args) {
           SpringApplication.run(SpringcloudEurekaServerApplication.class, args);
       }

   }

   ```

4. 浏览器访问指定的端口号8083，出现如下画面就表示注册服务中心Eureka成功启动

   ![](QQ截图20200220183410.png)



#### 向Eureka服务注册中心服务

被注册的服务需要添加Eureka注册中心的依赖（客户端Client），因为向服务中心注册的时候需要通过客户端向服务端连接，

在分布式系统中，每个微服务都应该配置一个名称，表示该微服务，服务之间的运作和调度是根据服务名进行匹配查找的，通常是项目名称保持一致

步骤和添加服务端类似

1. 添加Client依赖和指定版本的SpringCloud

   ```xml
   <!--Eureka客户端-->
   <dependency>
       <groupId>org.springframework.cloud</groupId>
       <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
   </dependency>
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>Finchley.RC2</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>

   <repositories>
       <repository>
           <id>spring-milestones</id>
           <name>Spring Milestones</name>
           <url>https://repo.spring.io/libs-milestone</url>
           <snapshots>
               <enabled>false</enabled>
           </snapshots>
       </repository>
   </repositories>
   ```

2. 在Spring Boot的入口函数处，通过添加`@EnableEurekaClient` 注解来表明己是一个eureka客户端，让我的服务提供者可以连接eureka注册中心。

3. 配置application.properties文件

   ```properties
   # 配置服务的名称(当前服务名)
   spring.application.name=springcloud-service-provider
   # eureka的连接地址，也就是注册服务中心地址
   eureka.client.service-url.defaultZone=http://localhost:8083/eureka
   ```

4. 启动后，Eureka就可以监测到注册到服务中心的服务

   ![](/QQ截图20200220202024.png)



### 发现和消费服务

Eureka是 **发现服务**， Ribbon是 **消费服务**

服务的调用，需要Eureka客户端和Ribbon组合配合使用

Eureka客户端是一个Java客户端，用来连接Eureka服务端，与服务端进行交互、负载均衡,服务的故障切换等;。

Ribbon是一个基于**HTTP和TCP**的客户端负载均衡器,当使用Ribbon对服务进行访问的时候，它会**扩展Eureka 客户端的服务发现功能**,实现从Eureka注册中心中获取服务端列表,并通过Eureka客户端来确定服务端是否已经启动。Ribbon在Eureka客户端服务发现的基础上，实现了对**服务实例的选择策略**,从而实现对服务的**负载均衡**消费。

#### Ribbon的配置

1. 添加Eureka依赖，连接注册服务中心获取服务，配置Client客户端（修改POM文件添加SpringCloud依赖）

2. `RestTemplate`类中添加`@LoadBalanced`注解表示开启了Ribbon支持

   ```java
   @Bean
   @LoadBalanced
   public RestTemplate restTemplate() {
       return new RestTemplate();
   }
   ```

3. 消费者服务原来调用生产者服务是通过固定写死的路径访问，增加了Ribbon后就可以直接是根据被调用者服务的HostName名字，来调用服务

   ```java
   @RequestMapping("/web/toHello")
       public String toHello() {
   //        return restTemplate.getForObject(PROVIDER_URL + "/service/hello", String.class);
   //        优点在于只需要关注服务的名称，不需要管服务在什么机器，端口是什么，只要在注册中心记录了，消费者服务都可以直接调用
           return restTemplate.getForEntity("http://SPRINGCLOUD-SERVICE-PROVIDER//service/hello", String.class).getBody();
       }
   ```

4. 加入了Ribbon的支持后，只需要关注服务的名称HostName，不需要管服务在什么机器，端口是什么，只要在注册中心记录了，消费者服务都可以直接调用

5. 浏览器访问消费者服务的端口号，可以出现消费者生产的内容，表示成功



#### Eureka的高可用集群

如果只有一台服务器进行Eureka注册，如果这台服务器发生故障，就会导致注册服务 **单点故障**

Eureka本身是不能注册自己的，但是可以想其他注册服务注册自己，也就是说 **注册服务A可以向注册服务B注册自己，反之B也可以向A注册自己**

Eureka Server 的高可用实际上就是将自己作为服务向其他服务注册中心**注册自己**，这样就会形成一组互相注册的服务注册中心，进而实现服务清单的互相同步，**往注册中心A上注册的服务，可以被复制同步到注册中心B上**,所以**从任何一台注册中心上都能查询到已经注册的服务**,从而达到`高可用`的效果



应用场景：在一台机器上模拟搭建Eureka的服务集群

Spring Boot项目启动多个工程实例，即一个项目，修改一个端口启动一个服务，通过加载不同的配置文件一个项目启动多个实例

![](QQ截图20200223223929.png)

在IDEA中启动时，添加`--spring.profiles.active=eureka8761`加载application-eureka8761.properties的配置文件

![](/QQ截图20200223224036.png)



Eureka的相互注册，就是在properties文件中修改指定注册中心的位置为另一个工程的地址端口号`eureka.client.service-url.defaulZone=http://eureka8761:8761/eureka/`

```properties
server.port=8080

# 配置服务的名称
spring.application.name=springcloud-service-provider
# eureka的连接地址
eureka.client.service-url.defaultZone=http://eureka8761:8761/eureka/,http://eureka8762:8762/eureka/
```

当服务生产者`springcloud-service-provider`启动后，两个注册中心都会收到provider的注册信息，注册中心服务如果一个发生了故障，其他的服务中心有共同的数据不会收到游戏



### Eureka的自我保护机制

<span style="color:red">**EMERGENCY! EUREKA MAY BE INCORRECTLY CLAIMING INSTANCES ARE UP WHEN THEY'RE NOT. RENEWALS ARE LESSER THAN THRESHOLD AND HENCE THE INSTANCES ARE NOT BEING EXPIRED JUST TO BE SAFE.**</span>

在没有Eureka自我保护的情况下，如果Eureka Server在一定时间内没有 接收到某个微服务实例的心跳, Eureka Server将会**注销该实例**，但是当发生网络分区故障时，那么微服务与Eureka Server之间将无法正常通信,以上行为可能会导致注册中心在微服务运行正常的情况下收不到心跳，将注册实例注销了

进入自我保护模式后，**Eureka Server**会保护注册的服务，不会删除注册服务信息，在网络恢复后，会自动退出保护模式

缺陷：假如在保护期间，某个注册微服务因为某些原因宕机了，Eureka的自我保护机制会将不正常的微服务仍然保存了，但是在调用者调用的时候回调用到已经故障的服务而无法实现功能

```properties
# 每隔30秒向注册中心发送心跳，证明自己依旧存活
eureka.instance.lease-renewal-interval-in-seconds=30
# 60s内没有收到心跳，就会被注册服务踢除
eureka.instance.lease-expiration-duration-in-seconds=90


# 默认开启Eureka Server的自动保护机制，开发测试及时将不可用的服务剔除false
eureka.server.enable-self-preservation=false
```

当provider微服务在停止90s后，没有向注册中心发生心跳，就会将该服务注销 



### 客户端负载均衡（Ribbon）

通常说的是 **将请求均匀的分发到多个不同的节点上执行，提高执行效率和性能**

**硬件负载均衡**:比如F5、深信服、Array 等;
**软件负载均衡**:比如Nginx、 LVS、 HAProxy等;

**Ribbon**的主要功能是提供客户端的客户端的软件负载均衡算法，是基于HTTP和TCP的客户端负载均衡工具

Spring Cloud 对Ribbon做了二次封装,可以让我们使用RestTemplate的服务请求，自动转换成客户端负载均衡的服务调用

Ribbon只是一个工具类框架（也就是一个jar包），比较小巧, Spring Cloud对它封装后使用也非常方便,它不像服务注册中心、配置中心、API 网关那样需要独立部署，Ribbon只需要在代码直接使用即可



在Spring Cloud中，**Ribbon** 主要与**RestTemplate**对象配合起来使用, Ribbon会自动化配置RestTemplate对象,通过`@LoadBalanced`开启RestTemplate对象调用时的负载均衡



#### Ribbon的负载均衡调用

当一个消费者微服务调用多个生产者服务时（生产者服务之间除了端口号不同其他都一样），Ribbon会平均的将请求转发到多个生产者服务，不会出现多次重复调用一个服务的情况



Ribbon的多种负载均衡策略都是由`IRule`实现的，`IRule`的实现关系

![](/QQ截图20200225113421.png)



`RandomRule`：随机

`RoundRobinRule`：轮询

`AvailabilityFilteringRuleo`：先过滤掉由于多次访问故障的服务，以及并发连接数超过阈值的服务，然后对剩下的服务按照轮询策略进行访问

默认是采用轮询

```java
/**
 * 覆盖默认的轮询策略，使用随机策略
 * @return
 */
@Bean
public IRule iRule() {
    return new RandomRule();
}
```



### RestTemplate详解

GET：`getForEntity`方法返回的是一个 **ResponseEntity<T>**泛型对象

**注意：由于Ribbon的客户端负载均衡机制，通过服务名调用，Eureka注册中心注册的服务名而非端口名，如果使用服务地址端口访问就无法使用**

第一个参数是URL地址，第二个是返回的对象类型（String.class），或者实体对象（User.class）

```java
ResponseEntity<String> responseEntity = restTemplate.getForEntity("http://SPRINGCLOUD-SERVICE-PROVIDER/service/hello", String.class);
HttpStatus statusCode = responseEntity.getStatusCode();	//200
int codeValue = responseEntity.getStatusCodeValue(); //200
HttpHeaders headers = responseEntity.getHeaders();	//{Content-Type=[text/plain;charset=UTF-8], Content-Length=[20], Date=[Tue, 25 Feb 2020 14:48:53 GMT]}
Class<? extends ResponseEntity> aClass = responseEntity.getClass();	//class org.springframework.http.ResponseEntity
String body = responseEntity.getBody();	//传输的数据
```



### 服务熔断Hystrix

微服务架构中每个服务都是单独部署的，通过Eureka服务注册中心搭配Ribbon远程调用发现和消费微服务，如果网络原因或服务进程响应太慢大量的请求在某个服务中累积，调用者的线程一直在挂起等待无法响应

如果故障服务长时间没有处理，会导致与之相关的服务发生故障，**例如用户下单时，处理下单的服务挂起故障了，与之相应的减库存的服务也会故障，用户也没有得到相应的响应**，因此需要 **熔断机制**

Spring Cloud Hystrix 实现了**熔断器、线程隔离**等系列服务保护功能。 该功能也是基于Netflix 的开源框架Hystrix实现的，该框架的目标在于通过控制那些访问远程系统、服务和第三方库的节点，从而对延迟和故障提供更强大的容错能力。**Hystrix賂服务降级、服务熔断、线程和信号隔离、请求缓存、请求合并以吸服务监控等强大功能**。

#### 步骤

1. 在消费者服务添加pom依赖

   ```xml
   <!--开启hystrix熔断-->
   <dependency>
       <groupId>org.springframework.cloud</groupId>
       <artifactId>spring-cloud-starter-hystrix</artifactId>
       <version>1.4.4.RELEASE</version>
   </dependency>
   ```

2. 启动类添加`@EnableCircuitBreaker`注解

3. 在需要注意熔断机制的方法添加`@HystrixCommand(fallbackMethod = "error")`，error是一个方法

4. 以上的注解可以使用`@SpringCloudApplication`注解代替

hystrix默认超时时间是1000 毫秒,如果你后端的响应超过此时间，就会触发断路器;

```java
//设置熔断器的响应方法，和响应时间为4秒
@HystrixCommand(fallbackMethod = "error",commandProperties = {@HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "3000")})
```

将其中一台服务提供者设置线程挂起时间，将**负载均衡**策略该为依次轮询策略，就会发现服务1会等待三秒并处罚熔断机制，并响应指定的信息

```java
@RequestMapping(value = "/service/hello",method = RequestMethod.GET)
public String hello() {
    try {
        Thread.sleep(4000);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("服务提供者1 。。。。。。");
    return "Hello Spring Cloud 1";
}
```



#### Hystrix服务降级

有了服务的熔断,随之就会有服务的降级,所谓**服务降级**,就是当某个服务熔断之后，服务端提供的服务将不再被调用，此时由客户端自己准备一个本地的fallback回调，返回一个默认值来代表服务端的返回;

#### Hystrix的异常处理

网络故障或是服务自身错误，都会处罚Hystrix的熔断机制，终止请求访问

`ignoreExceptions = Exception.class`也可以忽略异常信息

#### Hystrix仪表盘

主要监控Hystrix的实时运行状态

在程序的入口类添加`@EnableHystrixDashboard`注解开启Hystrix仪表盘

**注意：访问Hystrix所在工程的端口号后要加上 /hystrix，localhost:3721/hystrix**

![](/QQ截图20200316211432.png)

依次是：1. 要监控服务地址	2. 轮询监控的时间	3.仪表盘的标题，默认URL



### Feign声明Rest客户端

[Feign](https://github.com/Netflix/feign)是一个**声明式的Web服务客户端**。这使得Web服务客户端的写入更加方便 要使用Feign创建一个界面并对其进行注释。支持可插拔式的解码器和编码器，支持SpringMVC的标准注解和HttpMessageConverters，Feign可以和Ribbon组合使用负责负载均衡

只需要创建一个接口，接口上添加Feign的相关注解

在实际开发中，所有的接口可能在一个工程下，一个接口可能被多个微服务调用，SpringCloud对Feign进行一些封装，只需要创建一个接口并添加相关注解

SpringCloud——**面向接口编程**

