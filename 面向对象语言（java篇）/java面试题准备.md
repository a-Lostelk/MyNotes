---
typora-root-url: images
---

# 								java面试题准备



### String

##### String要设计成不可变

字符串常量池的需要，Java堆内存中一个特殊的存储区域, 当创建一个String对象时,假如此字符串值已经存在于常量池中,则不会创建一个新的对象,而是引用已经存在的对象

String对象缓存HashCode，Java中String对象的哈希码被频繁地使用, 比如在hashMap 等容器中，字符串不变性保证了hash码的唯一性,因此可以放心地进行缓存

安全性，String被许多的Java类(库)用来当做参数,例如 网络连接地址URL,文件路径path,还有反射机制所需要的String参数等，这些都是不能轻易被改变的

### StringBuffer和StringBuilder

String是不可变的字符序列，StringBuffer和StringBuilder是可变的字符序列

- String：char[] 以final修饰即不可变
  - StringBuffer：效率低，线程安全（所有的同步方法都是被synchronized修饰的），没有final修饰，底层创建了一个长度为16的数组
- StringBudler：效率高，线程不安全，没有final修饰

*作为参数传递的时候，方法内部 String不会改变值，StringBuffer和 StringBuilder会改变值*，不存在多线程和线程安全问题，一般建议使用StringBuilder

可变：底层的char[]数组中含有abc，添加def，不会改变原有的数组，而是在原有的数组上进行增加改变

##### **String为什么不可变**

虽然String、StringBuffer和StringBuilder都是final类，它们生成的对象都是不可变的，而且它们内部也都是靠char数组实现的，String类中定义的char数组是final的，而StringBuffer和StringBuilder都是继承自AbstractStringBuilder类，它们的内部实现都是靠这个父类完成的，可以用append追加

都是底层使用char[] 数组存储

```java
//结果是0，返回的有多少值的长度，而不是StringBuffer数组的默认长度，
StringBuffer stringBuffer2 = new StringBuffer();
System.out.println(stringBuffer2.length());
```

**扩容问题**：*如果原有的底层数组装不下了，那么就需要扩容新的数组，默认情况下是扩容原来的2倍 +  2，同时将原有数组中的数据复制到新的数组中*

在开发过程中使用带有参数的StringBuffer（int capacity）

##### StringBuffer的常用方法

StringBuffer 和 StringBuilder的常用方法差不多，只不过一个是有synchronized关键字一个没有

***StringBuffer append(xxx):***提供了很多的append()方法，用于进行字符串拼接
***StringBuffer delete(int start,int end)***:删除指定位置的内容
***StringBuffer replace(int start, int end, String str)***:把[start,end)位 置替换为str
***StringBuffer insert(int offset, XXX)***:在指定位置插入xXX
***StringBuffer reverse()***:把当前字符序列逆转

append和insert时， 如果原来value数组长度不够，可扩容数组

##### String、StringBuffer和StringBuilder的执行效率

StringBuilder > StringBuffer > String



### 日期时间API

##### java.lang.system类

System类提供的public static long currentTimeMillis()用来返回当前时间与1970年1月1日0时0分0秒之间以毫秒为单位的时间差。

##### java.util.Date

Date date = new Date();

System.out.println(date.getTime());//1566296624156

### JVM虚拟机

全称 **Java virtual machine** (**JVM**)



### 泛型

建立类型安全的集合，本质是***数据类型的参数化***，使用了泛型的集合不必进行强制类型转换，类型的转换在编译器内完成了，提高了可读性和安全性

泛型相当于数据结构中的占位符，在调用的时候传入实际类型

许多容器list、collection、map等都包含了泛型



### Collection接口

是list、map、list子集合的父类，collection中的方法，其所有的子类都有

```java
Collection<String> collection = new ArrayList<String>();
    System.err.println(collection.size());
    System.out.println(collection.isEmpty());
    collection.add("sunny");
    collection.add("sunny1");
    System.out.println(collection);
    System.out.println(collection.size());

    Map map;

    //是否包含某个元素
    boolean contains = collection.contains("sunny");
    System.out.println(contains);

    //移除只是将该值的存储地址改变，并不是将对象删除
    collection.remove("sunny1");
    System.out.println(collection);

    //转换为数组对象
    Object[] array = collection.toArray();
    System.out.println(array);

    //移除集合中所有的元素
    collection.clear();
    System.out.println(collection.size());
```

集合的常用方法

![](/QQ拼音截图20190818094026.png)



##### Iterator遍历集合

iterator对象我们诚挚为迭代器，是设计模式中的一种，遍历collection中的集合元素

GOF给迭代器模式的定义为:提供一种方法访问一个**容器**(container)对象中各个元索，而又不需暴露该对象的**内部细节**。迭代器模式，*就是为容器而生*。类似于“公交车上的售票员”、“火车上的乘务员”、“空姐”。

Collection接口继承了java.lang.Iterable接口，该接口有一个iterator()方法，那么所
有实现了Collection接口的集合类都有一个iterator()方法， 用以返回一个实现了
Iterator接口的对象。

**Iterator的遍历方法**

next []方法遍历出集合中的一个元素，遍历多次就能得出集合中所有的元素（又时候回发生数组越界状况）

hasNext() 判断是否还有下一个元素

推荐方法：

```java
//推荐使用方式.next 和 hasNext搭配使用
while (iterator.hasNext()) {
    System.out.print(iterator.next());

}
```

![](/QQ截图20190821233841.png)

### List

有序可重复的的容器

常用的实现类是ArrayList（数组），LinkedList（链表）和Vector（线程安全的数组）

#### ArrayList

底层是`Object数组`实现，查询效率高，增删效率低，线程不安全，但实际开发中不涉及到太多的增删和修改的业务，我们一般使用它

***可以存放任意数量的对象，长度是不受限制的***，本质是当数组的存储已满时，定义一个新的更大的数组，将原数组和新数组的内容一起加入到新数组中，默认大小是10

#### LinkedList

是一个实现了List接口和Deque接口的双端链表。 LinkedList底层的链表结构使它支持高效的插入和删除操作，另外它实现了Deque接口，使得LinkedList类也具有队列的特性; LinkedList不是线程安全的，如果想使LinkedList变成线程安全的，可以调用静态类Collections类中的synchronizedList方法

```java
List list=Collections.synchronizedList(new LinkedList(...));
```

##### 内部结构

![](/arraylist.png)

addAll方法通常包括下面四个步骤：

1. 检查index范围是否在size之内
2. toArray()方法把集合的数据存到对象数组中
3. 得到插入位置的前驱和后继节点
4. 遍历数据，将数据插入到指定位置

常见方法

**add(E e)** 方法：将元素添加到链表尾部

**addFirst(E e)：** 将元素添加到链表头部

**addAll(int index, Collection c)：** 将集合从指定位置开始插入

**get(int index)：** 根据指定索引返回数据

**remove(int index)**：删除指定位置的元素

### HashMap



 HashMap底层是使用哈希表，基本结构是数组+链表，默认的长度是16



 * 数组:占用空间连续。寻址容易,查询速度快。但是,增加和删除效率非常低。
 * 链表:占用空间不连续。寻址困难， 查询速度慢。 但是,增加和删除效率非常高。

***entry[]*** 数组是HashMap的核心，entry对象中存储了key value键值对，next指向下一个节点，hash值，每一个entry对象都是一个**单向链表**（或者叫节点对象）

![](/QQ拼音截图20190814221752.png)

##### HashMap的数据结构

自上而下是数组结构，每个数组节点可以是一个单向链表，相比单纯的链表数组，HashMap存储的更多数值，同时具备数组链表各自的有点

![](/QQ拼音截图20190814225446.png)

##### 存储过程

Object对象的hashCode()方法，k y 两个对象存放到entry[]数组中，通过hashcode()方法得到hash码，HashMap的hash()方法计算出数组的长度，计算出对于的hash值（区间在[0,数组长度-1]）之间，转换的hash值尽量均匀分布在这个区间之内，通过散列算法等分散分配put进去的值，理论上越分散越有利于HashMap的性能

![](/QQ拼音截图20190814231536.png)

**总结**：由上可知，当添加一个元素时，首先计算key的hash值，一次确定插入数组的位置，如果某一hash值存在的数组节点中已经有元素了，就添加到同一hash值的后面（单项列表），jdk8之后，链表长度大于8时，链表转换为红黑树，提高效率

##### 取数据过程

1. 获得key的hashcode , 通过hash()散列算法得到hash值,进而定位到数组的位置。

2. 在链表上挨个比较key对象。调用equals()方法 ,将key对象和链表上所有节点的key对象进行，,直到碰到返回true的节点对象为止。

3. 返回equals()为true的节点对象的value对象

   ***Java中规定,两个内容相同(equals(为true)的对象必须具有相等的hashCode巴易quals()***

##### HashMap扩容

HashMap的位桶数组,初始大小为16。实际使用时,显然大小是可变的。如果位桶数组中的元素，达到(0.75*数组length)，就重新调整数组大小变为原来2倍大小。（数组为16，大小为12时开始扩容）

扩容的本质是定义新的更大的数组,并将旧数组内容挨个拷贝到新数组中。很费时



### 多线程

**什么是线程安全？**

线程安全是编程中的术语，指某个函数、函数库在并发环境中被调用时，能够正确地处理多个线程之间的共享变量，使程序功能正确完成。即在多线程场景下，不发生有序性、原子性以及可见性问题。

**如何保证线程安全？**

Java中主要通过加锁来实现线程安全。通常使用synchronized和Lock

**什么是锁？死锁？**

死锁是指两个或两个以上的进程在执行过程中，由于竞争资源或者由于彼此通信而造成的一种阻塞的现象，若无外力作用，它们都将无法推进下去。此时称系统处于死锁状态或系统产生了死锁，这些永远在互相等待的进程称为死锁进程。

死锁四个必要条件：互斥条件、请求和保持条件、不剥夺条件、环路等待条件

死锁的解决办法就是破坏以上四种必备条件中的一个或者多个。

#### Synchronized关键字

***synchronized***，是Java中用于解决并发情况下数据同步访问的一个很重要的关键字。当我们想要保证一个共享资源在同一时间只会被一个线程访问到时，我们可以在代码中使用`synchronized`关键字对类或者对象加锁

两种使用形式

```java
public class SynchronizedTest {

    //方法块
    public synchronized void doSth(){
        System.out.println("Hello World");
    }

    //代码块（类对象）
    public void doSth1(){
        synchronized (SynchronizedTest.class){
            System.out.println("Hello World");
        }
    }
}
```

在进行反编译后，字节码文件同步方法和同步代码块都有自己的标识

对于**同步方法**，JVM采用`ACC_SYNCHRONIZED`标记符来实现同步，同步方法的常量池中会有一个`ACC_SYNCHRONIZED`标志。当某个线程要访问某个方法的时候，会检查是否有`ACC_SYNCHRONIZED`，如果有设置，则需要先获得监视器锁，然后开始执行方法，方法执行之后再释放监视器锁。这时如果其他线程来请求执行方法，会因为无法获得监视器锁而被阻断住，*如果在方法执行过程中，发生了异常，并且方法内部并没有处理该异常，那么在异常被抛到方法外面之前监视器锁会被自动释放。*

对于**同步代码块**。JVM采用`monitorenter`、`monitorexit`两个指令来实现同步，执行`monitorenter`指令理解为加锁，执行`monitorexit`理解为释放锁。 每个对象维护着一个记录着被锁次数的计数器，同一个线程访问锁会多次递增，当计数器为0释放所并可以被其他线程获取