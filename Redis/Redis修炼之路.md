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

基于ANSIC C语言编写的,性能接近汇编机器语言,是基于内存的读写,它的数据结构只有**六种数据结构**,相对传统数据库较为简单

应用场景
	一个是缓存常用的数据,一个是需要高速读写的场合

缓存
	1)在数据库的读写操作中,实际上是读操作的次数远超写操作
	2)使用内存存储数据的开销比较大,内存条的价值远比硬盘高,内部的容量也比较小,因此的数据必须是一些常用的数据,比如:用户登录，热点高频字段优先添加到redis中
	的信息,客户基础存储信息
	3)第一次读取判断是否读取成功(读取失败会在数据库中读取并写入缓存中Redis中),第二次读取该数据的时候,就不用了读取数据库的
	流程了,读取数据库磁盘的速度是很低的,这要速度就会大大加快
	4)Redis的大部分行为是读操作,使用Redis应对读操作,降低对数据库的依赖,速度就会大大提高
	

	redis-cli.exe -h 127.0.0.1 -p 6379	这事redis默认的端口和IP号

### java程序使用Redis

下载相关jar包:jedis.jar

jedis是Java客户端

```Java
Jedis jedis = new Jedis("localhost", 6379); //连接Redis host主机ip，port端口号
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



**另外**，redis是单线程的数据库，不存在锁和线程竞争的情况，因此效率是极高的



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

CAP

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

### BASE

基本可用( Basically Available)
软状态(Soft state)|
最终一致(Eventually consistent)

BASE就是为了解决关系数据库强一致性引起的问题而引起的可用性降低而提出的解决方案。比如说可以牺牲某段时刻的数据库数据准确性，将需要插入的数据插入到Redis等NoSql数据库中，但是最终这些数据会顺利插入到数据库中，Redis相当于是一个缓冲带

它的思想是通过让系统放松对某--时刻数据--致性的要求来换取系统整体伸缩性和性能上改观。



#### 分布式集群简介

**分布式系统( distributed system)**
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

[关于redis的五种数据类型介绍](https://www.cnblogs.com/lizhenghn/p/5322887.html)

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



### Redis的常用操作

##### key

keys *					  查看当前库的所有key
exists key的名字		 	判断某个key是否存在
move key db			   	当前库就没有了，被移除了
expirekey秒钟:			为给定的key设置过期时间
ttl key					查看还有多少秒过期，**-1表示永不过期，-2表示已过期**
type key					查看你的key是什么类型

DEL key： 				删除key，一般场景不使用

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

##### set

sadd/smembers/sismember		添加和获取set中的元素
scard,								 获取集合里面的元素个数
srem key value				  删除集合中元素
srandmember key			 某个整数(随机出几个数) 
spop key							随机出栈
smove key1 key2在key1里某个值作 用是将key1里的某个值赋给key2
数学集合类						 差集：sdiff，**取出在第一个set里面而不在后面任何一个set里面的项（取不同的）**

?											交集：sinter，**取出一个或多个set中相同的数据（取相同的）**

?											并集：sunion，**取出一个或多个set中的所有的元素**

##### Hash

本质是key/vaue，但value实际上还是一个键值对

![](/QQ截图20191021181405.png)

hset/hget/hmset/hmget/hmget/hgetall/hdel		获取设置一个值，获取设置多个值，一次获取所有key的值，删除

hlen		获取Hash的长度

hexits key		判断Hash中某个值是否存在

hkeys/hvals	 获取所有的键值

hincrby/hincrbyfloat	以此自增加上一个整数，小数

hsetnx			添加一个如果不存在的值



##### ZSet有序集合（sorted set）

zadd/zrange 
zrangebyscore key		开始score结束score 
zremkey						某score下对应的value值，作用是删除元素
zcard/zcount key score	区间/zrank key values值，作用是获得下标值/zscore key对应值,获得分
zrevrank key values		值，作用是逆序获得下标值
zrevrange
zrevrangebyscore key	结束score开始score



### redis过期策略

在redis中的配置文件中，默认有6种过期策略，默认是永不过期的

```xml
# volatile-lru -> remove the key with an expire set using an LRU algorithm
# allkeys-lru -> remove any key according to the LRU algorithm
# volatile-random -> remove a random key with an expire set
# allkeys-random -> remove a random key, any key
# volatile-ttl -> remove the key with the nearest expire time (minor TTL)
# noeviction -> don't expire at all, just return an error on write operations
```

volatile-lru：使用了LRU算法移除key，移除某个设置了过期时间的key

allkeys-lru：使用LUR算法随机移除key，最近使用频率少的移除key

volatile-random：在过期集合中移除随机的key，只对设置了过期时间的键

allkeys-random：移除随机的key

volatile-ttl：移除TTL值最小的值，也就是最近要过期的key

noeviction：永不过期策略，一般在实际开发中不会选择它



#### Redis.conf配置文件介绍

Redis.conf配置项说明如下:
1. Redis默认不是以守护进程的方式运行，可以通过该配置项修改，使用yes启用守护进程
    daemonize no

2. 当Redis以守护进程方式运行时，Redis默认会把pid写入/var/run/redis.pid文件， 可以通过pidfile指定
   pidfile /var/run/redis. pid

3. 指定Redis监听端口，默认端口为6379，作者在自己的一篇博文中解释了为什么选用6379作为默认端口，因为6379在手机按键EMERZ对应的号码，而MERZ取自意大利歌女Alessia Merz的名字
    port 6379

4. 绑定的主机地址
    bind 127.0.0.1

5. 当客户端闲置多长时间后关闭连接，如果指定为0，表示关闭该功能
    timeout 300

6. 指定日志记录级别，Redis总 共支持四个级别: `debug、 verbose、notice、 warning`, **默认为**`verbose
    loglevel verbose`

7. 日志记录方式，默认为标准输出，如果配置Redis为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给/dev/null
    logfile stdout

8. 指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合
    save <seconds> <changes>
    Redis默认配置文件中提供了三个条件:
    save 900 1
    save 300 10

9. 设置数据库的数量，默认当前数据库为0，`select dbid`选择使用的数据库

10. 存储本地数据库是够进行压缩，默认是yes，采用的是LZF压缩

  rdbcompression yes

11. 指定本地数据库的文件名

   dbfilename dump.rdb

12. 指定本地数据库存放目录，可能会在不同的目录启动redis，存放的目录可能会随之改变

   dir ./

13. 设置当本机为slav服务时，设置master服务的IP地址及端口，在Redis启动时， 它会自动从master进行数据同步
      slaveof <masterip> <masterport>

14. 当master服务设置了密码保护时，slav服务连接master的密码
      masterauth <master-password>

15. 设置Redis连接密码，如果配置了连接密码，客户端在连接Redis时需要通过`AUTH <password>`命令提供密码，默认关闭
      requirepass foobared

16. 设置同一时间**最大客户端连接数**，默认无限制，Redis可 以同时打开的客户端连接数为Redis进程可以打开的最大文件描述符数，如果设置maxclients 0,表示不作限制。当客户端连接数到达限制时，Redis会关闭新的连接并向客户端返回max number of clients reached错误信息
      maxclients 128

17. 指定Redis**最大内存限制**，Redis在 启动时会把数据加载到内存中，达到最大内存后，Redis会先尝 试清除已到期或即将到期的Key,当此方法处理后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis新的vm机制， 会把Key存放内存，Value会存放在swap区
      maxmemory <bytes>

18. 指定是否在**每次更新操作后进行日志记录**，Redis在默认情况下是**异步**的把数据写入磁盘，***如果不开启，可能会在断电时导致一段时间内的数据丢失***。 因为redis本身
      同步数据文件是按上面save条件来同步的，所以有的数据会在一段时间内只存在于内存中。 默认为no

   appendonly yes

19. 指定更新日志文件名，默认为**appendonly.aof**
      appendfilename appendonly.aof

20. 指定更新日志条件，共有3个可选值:
      **no:** 表示等操作系统进行数据缓存同步到磁盘(快)
      **always**: 表示每次更新操作后手动调用fsync()将数据写到磁盘(慢，安全)
      **everysec**: 表示每秒同步一次(折衷，默认值)

21. 指定是否启用虚拟内存机制，默认值为no,简单的介绍一下，VM机制将数据分页存放，由Redis将访问量较少的页即冷数据swap到磁盘上，访问多的页面由磁盘自动换出到内存中(在后面的文章我会仔细分析Redis的VM机制)
      vm-enabled no

22. 虚拟内存文件路径，默认值为/tmp/redis.swap,不可多个Redis实例共享
      vm-swap-file /tmp/redis. swap

23. 将所有大于vm-max-memory的数据存入虚拟内存,无论vm-max-memory设置多小,所有索引数据都是内存存储的(Redis的索引数据就是keys),也就是说,当
      vm-max-memory设置为0的时候,其实是所有value都存在于磁盘。默认值为0
      vm-max-memory 0

24. Redis swap文件分成了很多的page,一个对象可以保存在多个page上面，但一-个page 上不能被多个对象共享，vm-page-size是 要根据存储的数据大小来设定的，
    作者建议如果存储很多小对象，page大小最好设置为32或者64bytes;如果存储很大大对象，则可以使用更大的page,如果不确定，就使用默认值
    vm-page-size 32
25. 设置swap文件中的page数量，由于页表(一种表示页面空闲或使用的bitmap)是在放在内存中的，，在磁盘上每8个pages将消耗1byte的内存。
      vm-pages 134217728
26. 设置访问swap文件的线程数,最好不要超过机器的核数如果设置为0,那么所有对swap文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为4
      vm-max-threads 4



### Redis和持久化

#### RDB（Redis Database）

<u>**在指定的时间间隔内将闪存中的数据集快照写入磁盘，它恢复时将快照文件直接读在内存中**</u>

Redis会单独创建一个子进程来进行持久化，会先将数据写入到一个临时文件中，持久化过程都结束了，再用这个临时文件替换上次持久化的文件

在子进程持久化的过程中，**主线程是不会进行任何的IO操作**，这就确保了极高的性能，RDB适合于恢复大批量的数据高高效对数据的精度不高，RDB最后一次持久化后的数据可能丢失

Rdb保存的文件是`dump.rdb`文件，保存在内存中的数据在断电就会消失，然而在对redis的操作还能获得上次操作的数据，说明在我们断电之前，redis对数据进行快照保存，读取的内容是.rdb文件中的内容到数据中，一般在redis的启动文件夹会保存一个**dump文件**

注意点：**当flush shutdown等斩断内存操作的时候，redis会立刻执行备份并生辰一个空的rdb文件，多台服务器可以将一个rdb文件进行备份，当一个文件出现故障，可以使用另外一个服务器的备份文件进行备份恢复**

- **`fork`：**复制一个和当前线程一样的进程，新进程**所有的变量**（变量、环境变量、程序计数器）都和原进程一致，作为当前线程一个权限的子线程

- `save`：保存数据，`save 900 1` 表示900s内如果有1条是写入命令，就触发产生一次快照，可以理解为就进行一次备份
- `stop-writes-on-bgsave-error yes`：这是当备份进程出错时，主进程就停止接受新的写入操作，是为了保护持久化的数据一致性问题。**如果自己的业务有完善的监控系统，可以禁止此项配置，** 否则请开启
- `rdbcompression yes`：对存储到硬盘中的数据是否，是否进行压缩存储，会采用LZF算法进行压缩
- `rdbchecksum yes`：在存储快照，使用CRC64算法来进行校验，会有一点的性能消耗，但是基本忽略不计
- `save和bgsave`：Save: save时**只管保存，其它不管，全部阻塞**，BGSAVE: Redis会在后台异步进行快照操作，快照同时还可以响应客户端请求。可以通过lastsave|命令获取最后--次成功执行快照的时间

在执行`flushAll`命令的时候，还是会产生一个`.dump`文件，只不过这个文件是空白的，重新读取的时候就是读取空的内容

![](/QQ截图20191023235651.png)





#### AOF（Append only File）

以日志的形式来记录每个`写`操作，读记录不会记录，只需追加文件但不可以改写文件，redis重启后会根据日志文件将写指令从前到后重新执行一遍，就可以完成数据的恢复工作

默认的日志文件是保存在appendonly.aof文件中，redis中的操作都会记载.aof文件中

有一个注意点：flushAll命令也会记录到日志文件中，redis根据日志文件逐步加载操作的时候，再次执行清除命令，当flushAll命令在日志文件中删除的时候，redis在重启后根据文件重新加载后，之前redis中的相关操作也会逐一执行，所有数据就能恢复

**修复apendonly.aof文件**

在某些情况，断电或是网络延迟的情况下，导致appendonly.aof文件写入错误的不符合语法的数据，会导致redis无法启动，`redis-check-aof --fix appendonly.aof`命令可以修复日志文件，将所有不属于语法规范的错误命令数据删除

![](/QQ截图20191028092111.png)

- `appendonly`：开启appendonly，默认是no

- `appendfilename`：修改默认的日志文件名字

- `Appendfsync`

  **Always**:同步持久化每次发生数据变更会被立即记录到磁盘性能较差但数据完整性比较好，系统的大部分性能都用在复制
  **Everysec**: 出厂默认推荐，异步操作，每秒记录如果一秒内宕机，有数据丢失
  **No**：不开启

- `No-appendfsync-on-rewrite`:重写时是否可以运用Appendfsync，用默认no即可，保证数据安全性。

  AOF采用文件追加的方式，追加的数据越来越多，文件会变得相当庞大，因此添加了**文件重写机制**，AOF文件超出了一定的阈值 ，会对原来的文件进行压缩，只保留恢复文件的最小指令集，`bgrewritteaof`

  **重写原理：**AOF文件在持续增大的时候，会fork出一条新的进程进行重写操作，在实例操作中可能redis会删除某些数据，而重写机制重写写入的是在redis中还有的数据文件，遍历新的AOF文件，每一条记录都是有一个set指令，将redis数据库中所有的存在的数据重写成为一个新的AOF数据文件，下次恢复文件就是按照这个数据文件进行恢复，和快照类似  

  **触发机制：**默认配置是当前AOF文件是上次rewrite文件的1倍，且大小超过了64的时候触发机制

  ![](/QQ截图20191028103058.png)

- `Auto-aof-rewrite-min-size`:设置重写的基准值

- `Auto-aof-rewrite-percentage`: 设置重写的基准值

- AOF要记录的日志文件远大于RDB，恢复速度也就慢于RDB ，AOF的恢复策略是逐条恢复，效率比较低 

#### 总结

![](/QQ截图20191028130047.png)

RDB在指定的时间段对数据进行快照存储，AOF对每次读入操作进行日志记录，在服务器重启后redis会对日志文件中的数据会重新执行日志中的操作，进行文件恢复并保存

#### 两种持久化方式的使用

- 当数据只需要在服务器运行的时候存在，不用开启任何持久化方式，redis只做缓存操作
- **redis在重启的时候回优先加载AOF文件恢复原始的数据 **（AOF文件比RDB文件更加的完整），AOF文件在不断的写入操作中可能会发生一些未知错误，所以不能只使用AOF操作，RDB更适合备份数据库数据，AOF更适合Redis 重启恢复数据

#### 性能建议

因为RDB文件只用作后备用途，建议只在Slave上持久化RDB文件，而且只要**15**分钟备份一次就够了，只保留`save 900 1`这条规
则。

如果`Enalbe AOF`，好处是在最恶劣情况下也只会丢失不超过两秒数据，启动脚本较简单只load自己的AOF文件就可以了。代价一
是带来了持续的IO，二是AOF rewrite的最后将rewrite过程中产生的新数据写到新文件造成的阻塞几乎是不可避免的。只要硬盘
许可，应该尽量**减少AOF rewrite的频率**，AOF重写的基础大小默认值**64M**太小了，可以设到**5G**以上。默认超过原大小100%大小
时重写可以改到适当的数值。
如果不Enable AOF，仅靠`Master-Slave Replication`（主从复制）实现高可用性也可以。能省掉一大 笔IO也减少了rewrite时带来的系统波
动。代价是如果Master/Slave同时倒掉，会丢失十几分钟的数据，启动脚本也要比较两个Master/Slave中的RDB文件，载入较新
的那个。新浪微博就选用了这种架构



### Redis的事务

Redis对事务的支持是部分的，不像关系型数据库对事务的支持是绝对的

可以一次执行多个命令，本质一组命令的集合，一个事务中的所有命令都会**序列化**，按照**顺序串行化执行**而不会被其他命令插入

 相关命令，类似于Java中的数据结构队列queue

`DISCARD`:取消事务，放弃事务中的所有命令

`EXEC`：执行事务的命令

`MULTI`：标记事务的开始

`UNWATCH`：取消WATCH对key的监视

`WATCH key`：

**放弃事务**：在执行批量操作的时候，可以在执行事务之前取消，所有执行的事务都会取消

**全体连坐：**在执行批量操作的时候，有一条操作是错误的或是不可实现的，那么执行的时候所有的事务也会失败

#### watch监控

类似乐观锁，如果key的值被其他用户改变了，整个事务都不会执行

##### 悲观锁

悲观的认为一定会有事情发生，每次获取的时候都会加锁，确保自己的数据不会被其他用户所修改，期间其他读写的线程会在等待，传统的关系型数据库就会遇到很多这种锁机制，行锁，表锁，读锁，写锁

**适合写入较为频繁的场景**

表锁：对数据库的表加上锁

##### 乐观锁

每次获取数据的时候都不会担心数据的修改，所以每次获取数据的时候都不会进行加锁，但是在更新数据的时候需要判断该数据是否被别人修改过，如果数据被其他线程修改，则不进行数据更新，如果数据没有被其他线程修改，则进行数据更新。由于数据没有进行加锁，期间该数据可以被其他线程进行读写操作。

乐观锁有版本号的机制，提交的时候要大于当前版本号才能执行

**适合读取操作较为频繁的操作**

##### CAS 

#### 事务的三个阶段

- 开启:以`MULTI`开始一个事务

- 入队:将多个命令入队到事务中，接到这些命令并不会立即执行，而是放到等待执行的事务队列里面

- 执行:由`EXEC`命令触发事务

在Redis中是单独的隔离操作，所有的命令都会序列化、按顺序地执行，没有传统的关系型数据库的隔离级别和出现的脏读幻读情况

不保持原子性：redis的批量操作事务中如果有一条命令失败了，其他命令仍然执行，不会回滚，部分执行回滚机制



### redis的消息订阅

类似于微信中的订阅号，只有当你关注了订阅号，才会每天收到各种订阅号的消息

进程中的一种消息通信模式，发送者（pub）发送消息，订阅者（sub）接受消息

类似于消息中间件的作用，但是实际开发中不会选择redis的消息订阅功能



### redis的主从复制

**也就是我们所说的主从复制，主机数据更新后根据配置和策略，自动同步到备机的`master/slaver`机制，Master以写 为主，Slave以读 为主**

因为用户的增多，数据的增多，单机的数据库往往支撑不住快速发展的业务，所以数据库集群就产生了！

读写分离： 读写分离顾名思义就是**读和写**分离了，对应到数据库集群一般都是一主一从(**一个主库，一个从库**)或者一主多从(**一个主库，多个从库**)，业务服务器把需要写的操作都写到**主数据库**中，读的操作都去**从库查询**。主库会同步数据到从库保证数据的一致性。

容灾恢复：容灾备份系统是指在相隔较远的异地，建立两套或多套功能相同的IT系统，互相之间可以进行健康状态监视和功能切换，当一处系统因意外(如火灾、地震等)停止工作时，整个应用系统可以切换到另一处，使得该系统功能可以继续正常工作

#### 主从配置

info replication，查看当前机器主机从机中的关联信息，主机master，从机slaver

slaveof 127.0.0.1 6379 （主机端口号+ip地址）	与主机关联成为从机，能够读取主机中的数据，主机的所有数据都会被从机获得

只有主机能执行写操作，从机不能写，只能读主机的数据

当主机宕机关机后，从机和主机之间的关系不会发生改变，从机原地待命等待主机的恢复，其中的从机不会上位称为主机，role角色是slave，连接状态会从up变为down，仍然能获取到主机写入的数据

当从机宕机关机后，从机和主机之间的关系会发送改变，这时候从机的主从关系会变为主机，需要重新和主机连接才能成为从机，这时候就能和普通的redis数据库一样，可以读和写，而从机数据库只能读



#### 复制原理

Slave启动成功连接到master后会发送一个sync命令，Master接到命令启动后台的存盘进程，同时收集所有接收到的用于修改数据集命令，

在后台进程执行完毕之后，master将传送整个数据文件到slave,以完成一次完全同步

- 全量复制:而slave服 务在接收到数据库文件数据后，将其存盘并加载到内存中。

- 增量复制:Master继续将新的所有收集到的修改命令依次传给slave,完成同步

但是只要是重新连接master,一次次完全同步(**全量复制**)将被自动执行



#### 哨兵模式

 Redis 主从复制有一个很大的缺点就是没有办法对 master 进行动态选举（当 master 挂掉后，会通过一定的机制，从 slave 中选举出一个新的 master）

Sentinel(哨兵) 进程是用于**监控 Redis 集群中 Master 主服务器工作的状态**，当master主机挂掉后，会在从机中通过

某种策略选定一个新的主机，新的主机和其他的从机形成联系关联，自成一派体系，当原来的主机恢复了，他会成为从机而不再是主机了，因为新的老大已经上位了已经开始管理其他的小弟了



##### 注意点

配从不配主

从库配置：slaveof主库IP地址端口





