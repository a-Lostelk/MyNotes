---
typora-root-url: images
---

## 											Redis修炼之路

### 为什么使用redis

在传统的javaweb项目中是采取数据库存储数据的方式,有一些来自性能方面的弊端,数据库持久化的操作主要是面向磁盘,磁盘的读写操作较慢,假如系统在执行成千上万次的读写操作的时候,数据库是消受不起的

Redis本质上是一种NOSQL工具,是一种基于内存的数据库,提供一定的持久化功能.支持每秒几十万次的读写操作*
总结：数据的总大小，一个机器无法承受
数据的索引（B+tree）一个机器的内存放不下
访问量（也就是读写操作）一个表或一个库无法承担

![](/QQ截图20191011092423.png)

### Redis性能优越的原因

基于ANSIC C语言编写的,性能接近汇编机器语言,是基于内存的读写,它的数据结构只有六种数据结构,相对传统数据库较为简单

应用场景
	一个是缓存常用的数据,一个是需要高速读写的场合

缓存
	1)在数据库的读写操作中,实际上是读操作的次数远超写操作
	2)使用内存存储数据的开销比较大,内存条的价值远比硬盘高,内部的容量也比较小,因此的数据必须是一些常用的数据,比如:用户登录
	的信息,客户基础存储信息
	3)第一次读取判断是否读取成功(读取失败会在数据库中读取并写入缓存中Redis中),第二次读取该数据的时候,就不用了读取数据库的
	流程了,读取数据库磁盘的速度是很低的,这要速度就会大大加快
	4)Redis的大部分行为是读操作,使用Redis应对读操作,降低对数据库的依赖,速度就会大大提高

	redis-cli.exe -h 127.0.0.1 -p 6379	这事redis默认的端口和IP号

### java程序使用Redis

下载相关jar包:jedis.jar

jedis是Java客户端

```Java
Jedis jedis = new Jedis("localhost", 6379); //连接Redis
    int i = 0;
    try {
        long start = System.currentTimeMillis();    //开始毫秒数
        while (true) {
            long end = System.currentTimeMillis();
            if (end - start >= 1000) {      //如果操作大于等于一秒的时候结束操作
                break;
            }
            i++;
            jedis.set("test" + i, i + "");
        }
    }finally {
        jedis.close();
    }
    System.out.println("每秒的操作----------"+i);
}
```



基础连接配置,更多的时候我们是使用连接池完成操作
Redis只能基于字符串型的操作,在java中的使用是以类对象的为主,使用需要Redis存储的字符串和java对象相互转换
Spring对其进行了封装



### redis是基于内存的数据库

并且提供一定的持久化功能,是一种键值对的数据库,支持6种数据类型
字符串(String):字符串,整数和浮点数,对字符串进行操作,如果是整数或是浮点型,可以实现自增或计算
列表(list):是一个链表,每一个节点都包括一个字符串,支持从链表的两端都插入数据,读取一个或多个节点,根据条件查找和删除节点
集合(set):无序收集器,每一个元素都是一个唯一的不相同的字符串,增读删操作,检测元素是否在集合中,随机读取元素等
哈希结构(hash):键值对的无序列表,增删改查操作,获取全部的键值对
有序集合(zset):是一个有序的集合,包含很多中基本数据,是按分值的大小来决定的
基数(HyperLoglog):计算重复度的值,确定存储的数量,提供基数的计算,不提供返回的功能

```java
/**JedisPoolConfig 　　　　　　　　  jedis连接池配置对象
JedisConnectionFactory   　　　　  jedis连接工厂，生成连接对象
RedisTemplate　　　　　　　　　 RedisTemplate 对 RedisConnection 进行了封装。提供连接管理，序列化等功能，它对 Redis 的交互					
				进行了更高层次的抽象，极大的方便和简化了 Redis 的操作
RedisCacheManager　　　　　　  做为 redis 统一的调度和管理者
RedisCacheConfig　　　　　　　  RedisCacheConfig extends org.springframework.cache.annotation.CachingConfigurerSupport，
			自定义redis的key生成规则，如果不在注解参数中注明key=“”的话，就采用这个类中的key生成规则生成key

RedisTemplate Redis 操作*/
	stringRedisTemplate.opsForValue().set("test", "100",60*10,TimeUnit.SECONDS);	//向redis里存入数据和设置缓存时间  
	stringRedisTemplate.boundValueOps("test").increment(-1);	//val做-1操作  
	stringRedisTemplate.opsForValue().get("test")	//根据key获取缓存中的val  
	stringRedisTemplate.boundValueOps("test").	increment(1);	//val +1  
	stringRedisTemplate.getExpire("test")	//根据key获取过期时间  
	stringRedisTemplate.getExpire("test",TimeUnit.SECONDS)	//根据key获取过期时间并换算成指定单位  
	stringRedisTemplate.delete("test");	//根据key删除缓存  
	stringRedisTemplate.hasKey("546545");	//检查key是否存在，返回boolean值  
	stringRedisTemplate.opsForSet().add("red_123", "1","2","3");	//向指定key中存放set集合  
	stringRedisTemplate.expire("red_123",1000 , TimeUnit.MILLISECONDS);	//设置过期时间  
	stringRedisTemplate.opsForSet().isMember("red_123", "1")	//根据key查看集合中是否存在指定数据  
	stringRedisTemplate.opsForSet().members("red_123");	//根据key获取set集合  
```



### NoSql数据模型

聚合模型，在NoSql非关系型数据库中，为了简化Sql操作和提高执行效率，不建议在数据库Sql语句中包含过多的join，group等多表关联操作，提取重要的数据和字段，放在高效快速的Redis等Nosql内存数据库中

![](/QQ截图20191014140701.png)



#### NoSql数据库的四大分类

KV键值：新浪: `BerkeleyDB+ redis`	美团: `redis+tair`	阿里、百度: `memcache+ redis`

文档型数据库（BSON格式）：MongoDB

列存储数据库：Cassandra，HBase，分布式文件系统

图关系数据库：朋友圈社交网络，广告推荐系统，社交网络

**MongoDB**是一个**基于分布式文件存储**的数据库。由C++语言编写。旨在为WEB应用提供可扩展的高性能数据存储解决方案。
**MongoDB**是一个**介于关系数据库和非关系数据库**之间的产品，是非关系数据库当中功能最丰富，最像关系数据库的。

![](/QQ截图20191014193334.png)



### 分布式CAP原理和BASE 

#### 传统的ACDI特性

##### 1、A (Atomicity) 原子性

?	原子性很容易理解，也就是说事务里的所有操作要么全部做完，要么都不做，事务成功的条件是事务里的所有操作都成功，只要有一个操作失败，整个事务就失败，需要回滚。比如银行转账，从A账户转100元至B账户，分为两个步骤: 1)从A账户取100元; 2)存入100元至B账户。这两步要么一起完成，要么一起不完成，如果只完成第一步，第二步失败，钱会莫名其妙少了100元。

##### 2、C (Consistency)一致性

一致性也比较容易理解，也就是说数据库要-直处于-致的状态，事务的运行不会改变数据库原本的一致性约束。

##### 3、I (Isolation) 独立性

所谓的独立性是指**并发的事务之间不会互相影响**，如果-一个事 务要访问的数据正在被另外一个事务修改，只要另外一个事务未提交，它所访问的数据就不受未提交事务的影响。比如现有有个交易是从A账户转100元至B账户，在这个交易还未完成的情况下，如果此时B查询自己的账户，是看不到新增加的100元的

##### 4、D (Durability) 持久性

持久性是指一旦事务提交后，它所做的修改将会**永久的保存在数据库上**，即使出现宕机也不会丢失。

#### CAP

1. ##### Consistency（强一致性）

  一致性又称为原子性或者事务性。表示一个事务的操作是不可分割的，要不然这个事务完成，要不然这个事务不完成

2. ##### Availability（可用性）

   好的可用性主要是指系统能够很好的为用户服务，不出现用户操作失败或者访问超时等用户体验不好的情况，上线的系统不能轻易出现无法访问，访问超时等错误

3. ##### Partition tolerance（分区容错性）

   好的分区容错性要求能够使应用虽然是一个分布式系统，而看上去却好像是在一个可以运转正常的整体

   比如现在的分布式系统中有某一个或者几个机器宕掉了，其他剩下的机器还能够正常运转满足系统需求，这样就具有好的分区容错性

根据CAP原理，将NoSQL数据库分成也只能满足**CA原则、CP原则和AP原则** 三大类：
CA - 单点集群，满足一致性，可用性的系统，通常在可扩展性上不太强大。 （传统数据库）
CP - 满足一致性，分区容忍性的系统，通常性能不是特别高。 （Redis、MongoDB）
AP - 满足可用性，分区容忍性的系统，通常可能对一致性要求低一些。 （**大多数网站架构的选择**）

对于关系型数据库，插入一条数据立刻查询，是可以立刻读出这条数据，但对于一些web应用，不需要立马得到回应，就比如说，进行转账时，转账完对面不会立马都收到但最终还是会收到钱

#### BASE

基本可用( Basically Available)
软状态(Soft state)|
最终一致(Eventually consistent)

BASE就是为了解决关系数据库强一致性引起的问题而引起的可用性降低而提出的解决方案。比如说可以牺牲某段时刻的数据库数据准确性，将需要插入的数据插入到Redis等NoSql数据库中，但是最终这些数据会顺利插入到数据库中，Redis相当于是一个缓冲带

它的思想是通过让系统放松对某--时刻数据--致性的要求来换取系统整体伸缩性和性能上改观。



#### 分布式集群简介

分布式系统( distributed system)
由多台计算机和通信的软件组件通过计算机网络连接(本地网络或广域网)组成。分布式系统是建立在网络之上的软件系统。正是因为软件的特性，所以分布式系统具有高度的内聚性和透明性。因此，网络和分布式系统之间的区别更多的在于高层软件(特别是操作系统)，而不是硬件分布式系统可以应用在在不同的平台上如: Pc、 工作站、局域网和广域网上等。

##### 1分布式:

不同的多台服务器上面部署**不同的服务模块(工程)**，他们之间通过Rpc/Rmi之间通信和调用，对外提供服务和组内协作。

2集群:不同的多台服务器上面**部署相同的服务模块**，通过分布式调度软件进行统一的调度，对外提供服务和访问。



#### Redis全称

Remote dictionary server（远程字典服务器），是一个高性能分布式内存数据库，key/vaule键值

- Redis支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用]

- Redis不仅仅支持简单的key-value类型的数据，同时还提供list，set,zset，hash等数据结构的存储

- Redis支持数据的备份，即master-slave模式的 数据备份

支持内存存储和持久化，异步将内存中的数据写到硬盘上，但不影响继续服务



### BSON

是一种类似于JSON的二进制文件，简称**Binary JSON**	

和JSON一样，支持数组对象和文档对象



#### GCC

gcc是Linux下的一个C，C++，Java，Objective-C的编辑器



#### 在Linux下安装redis

- 首先获得Redis对应的压缩包，使用`tar -zxvf` 解压（tar -zcvf是打包压缩）

- 执行make安装需要使用到gcc编译器，可以使用`yum install gcc `安装，或是在Linux镜像文件中安装，

- 使用make命令安装后使用`make install`命令检查安装的配置环境是否正确

- 在Redis的解压目录下找到配置文件redis.conf复制到一个文件下作为备份
- 启动`redis-server /myredis/redis.conf `服务加载备份的配置文件，原生的redis配置文件最好不要修改
- `redis-cli -p 6379`通过指定的端口号启动redis服务
- `ps -ef | grep redi`s 查看后台的redis进程情况



#### redis的一些知识

redis是单进程的，对读写的操作是通过epoll函数的包装来实现的，redis的执行速率是由机器的执行效率决定的，epoll函数是Linux内核中一个专门用来处理多路复用IO操作的函数，提高多并发率的系统CPU利用率

redis目录默认是16个数据库（一个人扛不住，请十六个兄弟）  

![](/QQ截图20191017201919.png)

`select 7`可以切换到对应的redis数据库

`Dbsize`查看当前库key的数量

`FlushDB`：清空当前库

`FlushAll`：删除所有的库中内容 

统一密码管理，16个库都是一样的密码

redis中的索引是从0开始的





### Redis数据结构

#### 哈希（hash）

哈希表结构如同java的map,一个对象里面有许多键值对,适合存储java对象,hash是一个字符串类型的filed和value的映射表 
 hmset role_1 id 001 roleName role_name note note111
表名   id     字段名1            字段名2

是一个String类型的filed类型的field和value映射表，hash特别适合用于存储对象

Map<String,Object>



#### 列表(linked-list)

有序列表,双向链表,可以从从左到右或是从右到左遍历链表中的数据,使用链表也会带俩性能上的缺失,每一个节点代表的是一个字符串
在大量的数据中找一个节点的性能消耗是巨大的,链表结构的优势在于插入和删除遍历
链表命令"I"代表左操作,"r"代表的是右操作,在使用redis链表的时候,为了防止并发安全和一致性的问题,需要给链表的命令加上
锁机制,保证链表的命令安全性

#### 字符串（String）

是redis最基本的类型，一个key对应一个value，String是二进制安全的，包括任意类型的数据，jpg图片或者序列化的对象

#### 集合(set)

redis中的集合不是一个线性结构,而是哈希表结构,会在内部根据hash分子来查找和存储数据（无序不可重复）
对于集合来说,插入的每一个元素都是无序的
当插入相同的数据的时候会失败,集合是无序的
集合中的每一个元素的都是String类型的数据结构5

#### 有序集合（sorted set）

和set一样也是String类型元素的集合，不允许重复的成员，**有一个特点每个元素都会关联一个double类型的分数**，redis是通过分数来对集合中的成员进行从小到大的排序，集合中的成员是唯一的，但分数是可以重复的





#### Redis的常用操作

##### key

keys *					  查看当前库的所有key
exists key的名字		 判断某个key是否存在
move key db			   当前库就没有了，被移除了
expirekey秒钟:			为给定的key设置过期时间
ttl key						  查看还有多少秒过期，**-1表示永不过期，-2表示已过期**
type key					  查看你的key是什么类型

DEL key： 				 删除key，一般场景不使用

##### String

set/get/del/append/strlen	 strlen是当前字符串的长度
Incr/decr/incrby/decrby		一定要是数字才能进行加减 incr 3 每次当前数值+3，decr 2 每次减2
getrange/setrange 			 设置获取一个区间的的值，类似是Java的subString
setex(set with expire )		键秒值/setnx(set if not exist)团
mset/mget/msetnx			  同时获取设置多个key的值	
getset								(先get再set)			

##### list

lpush/rpush/lrange			 往list中插入数据，获取所有的数据

有点类似于数据结构中的单向链表和双向链表

![](/QQ截图20191020131016.png)

lpop/rpop：移除list集合中的第一个元素，根据插入的顺序决定

lindex		按照索引获得元素（从上到下）

llen			获得list集合的长度

lrem key 	删除N个Value

ltrim key	 截取指定范围的key，然后赋值给key

rpoplpush	源列表目的列表

Iset key index value 

linsert key before/after 	值1值2

它是一个字符串链表，left、 right都可 以插入添加;
如果键不存在，创建新的链表;
如果键已存在，新增内容;
如果值全移除，对应的键也就消失了。
链表的操作无论是头和尾效率都极高，但假如是对中间元素进行操作，效率就很惨淡了。|

