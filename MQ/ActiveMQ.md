---
typora-root-url: images
---

### 简介

编辑

**Apache ActiveMQ**是[Apache软件基金会](https://baike.baidu.com/item/Apache软件基金会)所研发的开放源代码[消息中间件](https://baike.baidu.com/item/消息中间件)；由于ActiveMQ是一个纯[Java](https://baike.baidu.com/item/Java)程序，因此只需要[操作系统](https://baike.baidu.com/item/操作系统)支持[Java虚拟机](https://baike.baidu.com/item/Java虚拟机)，ActiveMQ便可执行。



### JMS

JMS，即Java Message Service，通过面向消息中间件（MOM：Message Oriented Middleware）的方式很好的解决了上面的问题。大致的过程是这样的：发送者把消息发送给消息服务器，消息服务器将消息存放在若干**队列**/主题中，**在合适的时候**，消息服务器会将消息转发给接受者。

在JMS的思想下，可以完成一对一和一对多的通信模式   

#### JMS规范

Provider/MessageProvider：生产者

Consumer/MessageConsumer：消费者

PTP：Point To Point，点对点通信消息模型

Pub/Sub：Publish/Subscribe，发布订阅消息模型

Queue：队列，目标类型之一，和PTP结合

Topic：主题，目标类型之一，和Pub/Sub结合

ConnectionFactory：连接工厂，JMS用它创建连接

Connnection：JMS Client到JMS Provider的连接

Destination：消息目的地，由Session创建

Session：会话，由Connection创建，实质上就是发送、接受消息的一个线程，因此生产者、消费者都是Session创建

一个对一

在分布式系统中，当客户端的请求访问变大时候，因为客户端的请求和服务器中提供服务器的线程是一对一的，客户端会有成百上千的个，普通的系统的服务器不能对应这么多，把请求放到中间件服务器上，业务服务器在合理的时间不断的读取中间件MQ服务器的请求，一般是写入请求（读请求可能会从缓存中取出） 



#### MQ

是指利用高效可靠的消息传递机制进行**与平台无关的数据交流**，并基于数据通信来进行分布式系统的集成。
通过提供消息传递和消息排队模型在分布式环境下提供应用解耦，**弹性伸缩,冗余存储,流量削峰，异步通信，数据同步**等
大致流程
发送者把消息发给消息服务器，消息服务器把消息存放在若干队列主题中，在合适的时候，消息服务器会把消息转发给接受者。在这个过程中，发送和接受是异步的，也就是发送无需等待，发送者和接受者的生命周期也没有必然关系 

**解耦性：**平台无关的数据交流：在传统的SSM开发中，controller是用Java写的，对应调用的服务也是要用Java语言写的，但是有中间件的作用，调用者和服务者可以用不同的语言，降低了分布式服务之间的解耦度

**削峰性：**设置缓冲池，可以根据后台的吞吐量来对MQ的请求进行消费

**异步性：**发送请求和处理请求的服务是相对独立的，有各自的生命周期不会受到各自的影响	

MQ会将消息放在队列中，在数据结构中，队列的特点是先进先出，先进的消息的优先级更高，  在后台系统中会被优先处理

**队列** 一个消息只能被一个消费者消费，**主题**相当于订阅公众号，公众号推送的文章所有的关注者都可以看到公众号的文章



#### 异步处理

消息发送者可以发送一个消息而无需等待响应。 消息发送者把消息发送到一条虚拟的通道(主题或队列上;
消息接收者则订阅或监听该通道。F条信息可能最络转发给**一个或多 个消息接收者**,这些接收者都无需对消息发送者做出回应。整个过程都是异步的。

生产者只把消息发送给消息队列，然后就不管这条消息了，至于消费者什么时候能得到这条消息，生产者并不关系



### 安装和使用

http://www.apache.org/dyn/closer.cgi?filename=/activemq/5.15.12/apache-activemq-5.15.12-bin.zip&action=download

![](/20200515090622.png)

启动解压文件/bin/文件中的activemq.bat文件启动ActiveMQ服务

![](QQ拼音截图20200515091016.png)

提示登录，对应的用户数据文件在conf文件夹下



### ActiveMQ测试

发送者：

```java
public void testMQProducerQueue() throws Exception {
    // 创建mq的连接工厂
    ConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://127.0.0.1:61616");
    Connection connection = connectionFactory.createConnection();
    // 连接开启
    connection.start();
    // 创建会话对象，消息与MQ中间是一个会话
    Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
    Queue queue = session.createQueue("test-queue");
    // 创建生产者
    MessageProducer producer = session.createProducer(queue);
    TextMessage message = session.createTextMessage("hello world");
    producer.send(message);
    producer.close();
    session.close();
    connection.close();
}

public static void main(String[] args) {
    ActiveMQProducer activeMQProducer = new ActiveMQProducer();
    try {
        activeMQProducer.testMQProducerQueue();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

接收端

```java
public void testMQConsumerQueue() throws Exception {
    //1、创建工厂连接对象，需要制定ip和端口号
    ConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://127.0.0.1:61616");
    //2、使用连接工厂创建一个连接对象
    Connection connection = connectionFactory.createConnection();
    //3、开启连接
    connection.start();
    //4、使用连接对象创建会话（session）对象
    Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
    //5、使用会话对象创建目标对象，包含queue和topic（一对一和一对多）
    Queue queue = session.createQueue("test-queue");
    //6、使用会话对象创建生产者对象
    MessageConsumer consumer = session.createConsumer(queue);
    //7、向consumer对象中设置一个messageListener对象，用来接收消息
    consumer.setMessageListener(new MessageListener() {

        @Override
        public void onMessage(Message message) {
            // TODO Auto-generated method stub
            if(message instanceof TextMessage){
                TextMessage textMessage = (TextMessage)message;
                try {
                    System.out.println(textMessage.getText());
                } catch (JMSException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    });
    //8、程序等待接收用户消息
    System.in.read();
    //9、关闭资源
    consumer.close();
    session.close();
    connection.close();
```

![](QQ拼音截图20200515114408.png)以上是queue的情况，在ActiveMQ中还有一个Topic

JMS中定义了两种消息模型：**点对点（point to point， queue）**和**发布/订阅（publish/subscribe，topic）**。主要区别就是是否能重复消费。

##### 点对点queue 不可重复消费

> 消息生产者生产消息发送到queue中，然后消息消费者从queue中取出并且消费消息。
> 消息被消费以后，queue中不再有存储，所以消息消费者不可能消费到已经被消费的消息。
> Queue支持存在多个消费者，但是对一个消息而言，只会有一个消费者可以消费、其它的则不能消费此消息了。生产者不需要在消费者接受消息期间运行，消费者同理
> 当消费者不存在时，消息会一直保存，直到有消费消费

![](899685-20161113123757092-1011064196.jpg)

##### 发布订阅Topic 不可重复消费

> 消息生产者（发布）将消息发布到topic中，同时有多个消息消费者（订阅）消费该消息。
> 和点对点方式不同，发布到topic的消息会被所有订阅者消费。
> 当生产者发布消息，不管是否有消费者。都不会保存消息

![](899685-20161113124140030-1649021876.jpg)

在SpringBoot配置

```properties
spring.activemq.broker-url=tcp://127.0.0.1:61616
# true是使用内置的Tomcat，false是连接到服务器
spring.activemq.in-memory=false
# 使用Mq的连接池，false是每次发一个请求是一个连接
spring.activemq.pool.enabled=true
spring.activemq.pool.max-connections=10
# 最大空闲时间
spring.activemq.pool.idle-timeout=30s
```

#### JMS应用程序接口

**ConnectionFactory**

建立ActiveMQ连接的ActiveMQConnectionFactory就是继承该类

**Connection**

连接工厂中获取的连接对象

**MessageProducer/MessageConsumer**

消息提供者和消费者

**Session会话**

是一个单线程的上下文，用于接收和发送消息，消息是按照发送的顺序来接收（先进先出的队列），支持事务



#### 同步和异步消费者

##### 同步异步的简单概念

**同步：**调用者发送请求后，必须等接收者反馈给调用者消息后调用者才会接下来其他的操作

**异步：**调用者发送请求后，无须关注接收者又没有反馈消息和干了什么，调用者继续其他的操作，两者互不影响但存在一定的关系

**Message message = consumer.receive();**

receive()不带参数会一直阻塞，直到接收到生产者发送的消息，receive(10000L)表示在是秒接收不到消息后会关闭当前线程放弃