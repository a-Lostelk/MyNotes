---
typora-root-url: images
---

# 								java面试题准备

### 动态语言和静态语言

1、动态语言
是一类在**运行时可以改变其结构**的语言:例如新的函数、对象、甚至代码可以被引进，已有的函数可以被刪除或是其他结构上的变化。通俗点说就是在**运行时代码可以根据某些条件改变自身结构**。
主要动态语言: ***Object-C、C#、JavaScript、 PHP、Python、 Erlang。***

2、静态语言
与动态语言相对应的，运行时结构不可变的语言就是静态语言。如Java、 C、C++。

**Java**不是动态语言，但**Java**可以称之为“**准动态语言**”。即Java有-定的动态性，我们可以利用**反射机制**、**字节码操作**获得类似动态语言的特性。Java的动态性让编程的时候更加灵活!

### **三元运算符**

(条件表达式)？表达式1：表达式2；

用来完成简单的选择逻辑，即根据条件判断，从两个选择中选择一种执行。

##### **使用格式**

(条件表达式)？表达式1：表达式2；

**a) 判断条件表达式，结果为一个布尔值。**

**b) true，运算结果为表达式1**

**c) false，运算结果为表达式2**



### String

##### String设计成不可变

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

建立类型安全的集合，本质是**数据类型的参数化**，使用了泛型的集合不必进行强制类型转换，类型的转换在编译器内完成了，提高了可读性和安全性

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

##### 迭代器的remove()方法

迭代器内部定义了remove(）方法，可以删除集合中指定的元素。此方法不同于集合collection中的remove()方法，迭代器的remove()方法必须是使用next()方法之后

```java
while (iterator.hasNext()) {
    Object object = iterator.next();
    if ("tom".equals(object)) {
        iterator.remove();
    }
}
```



***迭代器是用啦遍历collection及其后台类子类，不包括map，因为map接口不是继承collection接口的***



##### 常见的错误写法

```java
while(iterator.next() != null){
    System.out.println(iterator.next());
}

//每次执行的都是第一个元素。
//迭代器每次执行.interator（）都会形成一个新的迭代器对象，默认游标是在集合的第一个元素
while(collection.iterator().hasNext()){
    System.out.println(collection.iterator().next());
}
```



#### 自定义collection及其子类需要实现的方法

equals()方法：判断两个对象是否相等，hashCode()：生成唯一的hash值保证唯一性和数据的存放位置

List: equals()方法。
Set: (HashSet、LinkedHashSet 为例): equals()、 hashCode()

​	（Treeset）：compareble接口：compareTO(Object obj)

​				 comparator接口：compare（OBject obj1， Object obj2）



### List

有序可重复的的容器，每个元素都有对应的顺序索引，数组存储数据的局限性，通常使用`list`替代数组，相当于是一个动态的自增长的数组

常用的实现类是ArrayList（数组），LinkedList（链表）和Vector（线程安全的数组）



##### ArrayList、LinkedList、Vector三者的异同?

*同*：

​	存储数据的特点（有序可重复），继承list接口，ArrayList、Vector底层是使用object数组结构支持随机访问，LinkedList是双向链表存储的

*异*：

- `ArrayList`是list集合的主要实现类，一般情况下我们都是ArrayList，线程不安全。扩容是1.5倍，jdk8中默认不会实例化添加内存，当需要add的时候默认为10的大小，***涉及到多次查询的时候使用ArrayList***

- `LinkedList`底层是双向链表，插入删除快，查询慢，线程不安全的，***涉及到多次插入删除的时候，使用linkedlist***

- `vector`是最古老的的实现类，线程安全的，扩容是2倍



##### 常见的List接口方法

***add(Object obj)***
***remove(Object obij/remove(int index)u***
***set(int index,Object obj)***
***get(int index)***
***add(int index,Object obj)***
***size()*** 

**使用Iterator;foreach;普通的for,**

#### ArrayList

底层是`Object数组`实现，查询效率高，增删效率低，线程不安全，但实际开发中不涉及到太多的增删和修改的业务，我们一般使用它

**可以存放任意数量的对象，长度是不受限制的**，本质是当数组的存储已满时，定义一个新的更大的数组，将原数组和新数组的内容一起加入到新数组中，默认大小是10

##### 源码分析

```java
ArrayList arrayList = new ArrayList();	//默认长度是10，可以动态的添加数组
```

ArrayList中的元素添加满了后继续添加的话，会在最小容量minCapacity size+1，如果minCapacity - 默认大小  > 0，则说明需要更大的大小去扩容新的元素，默认情况是扩容到原来内存的1.5倍，会创建一个新的Object数组并将原来的旧数组中的值复制到新的数组中并抛弃到就的数组，扩容是占据一定的性能和时间的

JDK7中创建的时候Object[]数组的默认大小是10

而在JDK1.8中并没有初始化的时候指定默认大小，而是在使用**add()**方法时，底层才**创建长度为10**的数组，在使用的时候才实例化

***jdk7中ArrayList对象床架类似于单例模式中的饿汉式，jdk8中的类似于懒汉式，延时在需要使用的时候才会创建***

```java
//判断是否需要扩容
public boolean add(E e) {
	ensureCapacityInternai(minCapacity: size + 1);
    // Increments modCount! !
    elementData[size++] = e;
    return true;
}
//执行扩容（默认情况下是扩容到原大小的1.5倍）
private void ensureCapacityInternal(int minCapacity) {
    modCount++ ;
    // overflow-conscious code
    if (minCapacity - elementData.length > eii
    grow(minCapacity);
}

```



*在开发中，尽量使用带参的构造器：	ArrayList arrayList = new ArrayList(int capacity);*



#### LinkedList

是一个实现了List接口和Deque接口的**双端链表**。 LinkedList底层的链表结构使它支持**高效的插入和删除操作**，另外它实现了Deque接口，使得LinkedList类也具有**队列**的特性; LinkedList不是线程安全的，如果想使LinkedList变成线程安全的，可以调用静态类Collections类中的**synchronizedList**方法

```java
List list=Collections.synchronizedList(new LinkedList(...));
```

##### 内部结构

![](/arraylist.png)

***双向链表优势***：链表中每一个元素都包含着***两个指针***，指向上一个元素和下一个元素的内存地址，在某个位置插入元素，***是将该位置索引前的元素的next指针指向新插入的元素，新插入的元素的prev指针指向该位置前的那个元素***

![](/QQ截图20190822101355.png)

addAll方法通常包括下面四个步骤：

1. 检查index范围是否在size之内
2. toArray()方法把集合的数据存到对象数组中
3. 得到插入位置的前驱和后继节点
4. 遍历数据，将数据插入到指定位置

常见方法

*****

**void add(int index, 0bject ele)**：在index位置插入ele元素
**boolean addAll(int index, Collection eles)**：从index位置开始将eLes中的所有元素添加进来
**object get(int index)**：获取指定index位置的元素
**int indexOf(object obj)：**返回obj在集合中首次出现的位置
**int LastIndexOf(object obj)**：返回obj在当前集合中末次出现的位置
**object remove(int index)：**移除指定index位置的元素，并返回此元素
**object set(int index, object ele)**：设置指定index位置的元素为ele
**List sublist(int fromIndex, int toIndex)**：返回从fromIndex到toIndex位置的子集合

**addFirst(E e)**： 将元素添加到链表头部
**addAll(int index, Collection c)**： 将集合从指定位置开始插入
**get(int index)**： 根据指定索引返回数据
**remove(int index)**：删除指定位置的元素

*****

##### 源码分析

双向链表的表现，单向链表是知道节点的下一个节点，只有next，不能知道上一个节点的元素

```java
private static cLass Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;
    
    Node(Node<E> prev, E eLement, Node<E> next) {
    this. item = eLement;
    this.next = next;
    this.prev = prev;
    }
}
```

```java
private static class Node<E> {
    E item;	//元素本身
    Node<E> next;	//指向下一个节点的指针
    Node<E> prev;	//指向上一个节点的指针
｝	
    //还有last和first Node节点
```

首次调用linkLast新建一个node节点，第一次创建时第一个也是最后一个节点，如果l（prev指针为null），说明节点之前没有被添加过时第一个节点，如果不是则说明之前是有节点的并将前一位节点的l指向新加入的节点newNode

```java
void linkLast(E e) {
    final Node<E> 1 = last;
    final Node<E> newNode = new Node<>(1, e, next: null);
    last = newNode;
    if (1 == null)
    	first = newNode ;
    else
    1.next = newNode;|
    	size++;
    modCount++ ;
}
```



#### Vector 

和ArrayList功能类似，创建方式也大致相同，底层都是创建的长度为10的数组，不同的一点是在扩容方面，默认扩容的是原来数组长度的2倍

线程安全的，效率慢



### Set

存储**无序不可重复**的数据

（**无序性**不等于随机性，遍历的时候会遵循一个规律但不是数据的存放顺序，而是根据数据添加的hash值，**不可重复性**，添加的元素都会和集合中的元素进行equals比较一下，返回***false***表示不存在这个元素的时候才允许添加到集合中，*相同的元素只能添加一个*）

***set接口每页额外定义的新方法，是继承父类collection定义的方法***



#### Hashset

set接口的主要实现类，存储无序，不可重复的数据，可以存储null值，**线程不安全**的

底层是**数组+链表**存储

*****

![](/QQ截图20190823180303.png)

*****

##### 添加元素的过程

- 添加元素的时候会调用Object对象的hashCode()方法生成一个**唯一不重复**的Hash值，Hash值保证数据的唯一性和确定**存放的位置**（索引位置）

- 如果此位置上没有其他元素或者首次添加，直接插入数据

- 有可能发生数据要存放的位置已经有元素，但是两个数据彼此之间的hash值并不相同，通过**equals()**方法判断两个元素的hash值，hash值不相等的话被认为是两个不同的元素，就会添加元素，否则添加失败

- **HashSet提供了链表的机制**，新元素会添加到集合数组已存在数据位置的链表前或是后，JDK7是添加在当前数据前并将**next**指针指向该数据，jdk8添加到当前数据后指针指向新插入的数据（***七上八下***）

![](/QQ截图20190823212026.png)

**正式图**

![](/QQ截图20190823215054.png)



#### LinkedHashSet

作为HashSet的子类，遍历其内部的数据时，***可以根据添加的顺序遍历***，***但本质上存放的位置顺序还是无序的***

在HashSet的基础上，每个元素都添加了**两个指针**，指向新前一个和后一个添加的元素，***底层的链表linked是用来计入数据的添加顺序***

##### 原理图

![](/QQ截图20190823234406.png)

***对于频繁遍历的数据操作，使用LinkedHashSet***



#### Teeset

可以按照添加对象的指定属性进行排序（比如从小到大），但是不能是不同类的对象

底层是用**二叉红黑树**存储的***，要求放入TreeSet的数据必须是同一个对象new出来的***

两种排序方式：**自然排序**（comparable）和**定制排序**（compareator）

自然排序中比较两个对象是否相同的标准是 compareTo方法返回的结果是0，不在是list集合中的equals方法

![](/QQ截图20190824092211.png)



值的关注的是，set的底层，对应的是一个Map（向下对应）

***HashSet LinkedHashSet TreeSet***

***HashMap LinkedHashMap TreeMap***



### Map

#### 继承树

![](/QQ截图20190825135553.png)

双列数据，key-value对应的数据



#### HashMap

HashMap是Map主要的实现类，线程不安全，效率高

HashMap底层是使用**哈希表**，基本结构是**数组+链表**，默认的长度是***16***

 * 数组:占用空间连续。寻址容易,查询速度快。但是,增加和删除效率非常低。
 * 链表:占用空间不连续。寻址困难， 查询速度慢。 但是,增加和删除效率非常高。

***entry[]*** 数组是HashMap的核心，entry对象中存储了key value键值对，next指向下一个节点，hash值，每一个entry对象都是一个**单向链表**（或者叫节点对象）

![](/QQ拼音截图20190814221752.png)

##### key和value的存储特点：

key其实是无序的，不能重复，就相当于集合中的set，value是可重复，根据key的分布规则，可以一定意义上理解value也是无序的

key和value键值对组成一个entry对象

![](/QQ截图20190826085852.png)

***小结：存储自定义类对象，vaule的所在类一定要重写hashCode()方法和equals()方法***



##### HashMap的数据结构

自上而下是数组结构，每个数组节点可以是一个**单向链表**，相比单纯的链表和数组，HashMap存储的更多数值，同时具备数组链表各自的有点

![](/QQ拼音截图20190814225446.png)

***HashMap的底层:  数组+链表(jdk7及之前)***
				***数组+链表+红黑树(jdk8)***

##### 存储过程

Object对象的**hashCode()**方法，通过hashcode()方法得到hash码，得到在entry数组中的存放位置，HashMap的hash()方法计算出数组的长度，计算出对于的hash值（区间在[0,数组长度-1]）之间，转换的hash值尽量均匀分布在这个区间之内，通过**散列算法**等分散分配put进去的值，理论上越分散越有利于HashMap的性能

![](/QQ拼音截图20190814231536.png)

**总结**：由上可知，当添加一个元素时，首先计算key的hash值，**确定插入数组的位置**，如果某一hash值存在的数组节点中已经有元素了，哈希值相同的继续比较**equals**，返回false表示两个对象是不同的，返回true则是修改功能覆盖原来的数据，数据添加到同一hash值的后面（**单向链表**），jdk8之后，链表长度大于8时，链表转换为**红黑树**，提高效率，jdk8中的底层数组是Node[]，而非entry[]数组，

##### 取数据过程

1. 获得key的hashcode , 通过hash()散列算法得到hash值,进而定位到数组的位置。

2. 在链表上挨个比较key对象。调用equals()方法 ,将key对象和链表上所有节点的key对象进行，,直到碰到返回true的节点对象为止。

3. 返回equals()为true的节点对象的value对象

   ***Java中规定,两个内容相同(equals(为true)的对象必须具有相等的hashCode和quals()***

##### HashMap扩容

HashMap的位桶数组,初始大小为16。实际使用时,显然大小是可变的。如果位桶数组中的元素，达到(0.75*数组length)，就重新调整数组大小变为原来2倍大小。（数组为16，大小为12时开始扩容）

扩容的本质是定义新的更大的数组,并将旧数组内容挨个拷贝到新数组中。很费时间

##### jdk8中HashMap的区别

jdk8相较于jdk7在底层实现方面的不同:
1. new HashMap():底层没有创建一个长度为16的数组
2. jdk 8底层的数组是: Node[], 而非Entry[]
3.首次调用put()方法时，底层创建长度为16的数组
4. jdk7底层结构只有:数组+链表。jdk8中底层结构:**数组+链表+红黑树**。
当数组的某一个索引位置上的元素以链表形式存在的数据个数> 8且当前数组的长度> 64时，
些索引位器的所有数据改为用红黑树存储；



#### LinkedHashMap

HashMap的子类，在遍历数据的时候，可以按照添加的顺序实现遍历

在HashMap的基础上添加了两个指针，指向前一个后一个元素，***频繁的遍历高于HashMap***

##### LinkedHashMap和HashMap的内部类区别

```java
//HashMap的内部类
static class Node<K,V> implements Map. Entry<K,V> {
    final int hash;
    final K key;
    V value;
    Node<K,V> next;
}

//LinkedHashMap的内部类
static class Entry<K,V> extends HashMap . Node<K,V> {
    //在HashMap的继承上添加了指向上一个和下一个元素的指针
    Entry<K,V> before, after;
    Entry(int hash, K key, V value, Node<K,V> next) {
    	super(hash, key, value, next);
    }
}
```

##### 关于HashSet

*new一个HashSet实际上就是new一个HasMap，操作HashSet就相当于操作HashMap*

```java
public HashSet(){
	Map = new HashMap<>();
}
```

##### Map的常用方法

- 添加删除方法

***object Put(0bject key, object value):*** 将指定key-value 添加到(或修改)当前map对象中
***void putAll(Map m)***: 将另一个Map m中的所有key-value对存放到当前map中
***0bject remove(0bject key)***:移除指定key的key-value对， 并返回value
***void clear():*** 清空当前map中的所有数据

- 查询的操作:

***0bject get(object key):***获取指定key对应的value
***boolean containsKey(0bject key)***: 是否包含指定的key
***boolean containsValue(object value):*** 是否包含指定的value
***int size():*** 返回map中key-value对的个数
***boolean isEmpty():*** 判断当前map是否为空
***boolean equals(0bject obj):*** 判断当前map和参数对象obj是否相等

- 元视图操作的方法:

***Set keySet():*** 返回所有**key**构成的**Set**集合
***collection values():*** 返回所有**value**构成的**Collection**集合
***Set entrySet():*** 返回所有**key-value**对构成的**Set**集 合

##### HashMap的遍历

在collection及其子类，可以使用forEach，迭代器，for循环遍历

HashMap中的存储数据是键值对存在的，只要取到其中的一个属性，就能知道另一个属性，比如说先获得Map中的Key，key相当于是一个set的集合

```java
	//遍历所有的key
    Set set = map.keySet();
    Iterator iterator = set.iterator();
    while (iterator.hasNext()) {
        System.out.print(iterator.next());
    }

	//通力而言，拿到了key就可以拿到值，Object get(key)
    Set set = map.keySet();
    Iterator iterator = set.iterator();
    while (iterator.hasNext()) {
        Object next = iterator.next();
        Object o = map.get(next);
        System.out.print(o + ",");
    }

    System.out.println();
    //遍历所有的value
    Collection values = map.values();
    for (Object o : values) {
        System.out.print(o + ",");
    }
    System.out.println();
    //遍历所有的key value
    Set entrySet = map.entrySet();
    Iterator iterator1 = entrySet.iterator();
    while (iterator1.hasNext()) {
        Object next = iterator1.next();
        Map.Entry entry = (Map.Entry) next;
        System.out.printf(entry.getKey() + "======>" + entry.getValue());
    }
```





#### TreeMap

底层使用的是红黑树，因为需要对key进行排序，必须保证key是同一类型的对象：自然排序和定制排序



#### Hashtable

线程安全的，不能存储null的键值对

##### Properties

配置文件类，key和value都是String类型



#### ConcurrentHashMap

是J.U.C(java.util.concurrent包)的重要成员，它是HashMap的一个**线程安全的**、**支持高效并发**的版本，***ConcurrentHashMap可以支持16个线程执行并发写操作及任意数量线程的读操作***。

##### 概述

HashMap不是线程安全的，多线程环境下，操作HashMap可能会出现线程安全问题

ConcurrentHashMap本质上是一个Segment数组，而一个Segment实例又包含若干个桶，每个桶中都包含一条由若干个 HashEntry 对象链接起来的链表。总的来说

![](/ConcurrentHashMap.jpg)

### Lambda表达式

Lambda是一个**匿名函数**，我们可以把Lambda表达式理解为是一段**可以传递的代码**（*将代码像数据一样进行传递*)。使用它可以写出更简洁、更灵活的代码。作为一种更紧凑的代码风格，使Java的语言表达能力得到了提升。|

实例

```java
//普通写法
Runnable runnable = new Runnable() {
        @Override
        public void run() {
            System.out.println("hello world");
        }
    };
    runnable.run();

//Lambda表达式
Runnable runnable = () -> System.out.println("hello world Lambda");
    runnable.run();
```

##### 使用方法

->lambda操作符	

->左边的是接口中抽象方法的形参列表

->重写抽象方法的方法体

##### 六种语法格式

```java
//无参无返回值
Runnable runnable = new Runnable() {
    @Override
    public void run() {
        System.out.println("hello world");
    }
};
Runnable runnable = () -> System.out.println("hello world Lambda");

//有参无返回值
Consumer<String> consumer = new Consumer<String>() {
        @Override
        public void accept(String s) {
            System.out.println(s);
        }
    };
    System.out.println("-----------------");
    Consumer<String> consumer1 = s -> System.out.println(s);

//前面的方法形参决定了实现类的数据类型，可以直接省略
Consumer<String> consumer1 = (s) -> System.out.println(s);

//只需要一个参数的时候，（）可以省略
Consumer<String> consumer1 = s -> System.out.println(s);

//需要两个或以上的参数并且有返回值的情况
Comparator<Integer> comparator = new Comparator<Integer>() {
    @Override
    public int compare(Integer o1, Integer o2) {
        System.out.println(o1);
        System.out.println(o2);
        return o1.compareTo(o2);
    }
};

//只有一个方法体的时候，return和大括号都可以省略
Comparator<Integer> comparator = (o1, o2) -> {
    System.out.println(o1);
    System.out.println(o2);
    return o1.compareTo(o2);
};
Comparator<Integer> comparator1 = (o1, o2) -> o1.compareTo(o2);
```



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





### 反射

**Reflection** (反射)是被视为**动态语言**的关键，反射机制允许程序在**执行期间**借助于Reflection API取得任何类的内部信息，**并能直接操作任意对象的内部属性及方法**。

加载完类之后，在**堆内存的方法区**中就产生了一个**Class**类型的对象(一个类只有一个Class对象)，这个对象就包含了完整的类的结构信息。我们可以通过这个对象看到类的结构。这个对象就像一面镜子，透过这个镜子看到类的结构，所以，我们形象的称之为:**反射**。

![](/../../%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E8%AF%AD%E8%A8%80%EF%BC%88java%E7%AF%87%EF%BC%89/images/QQ%E6%88%AA%E5%9B%BE20190827230328.png)

反射机制使原本是静态语言的Java有了类似动态语言的特性，使编程更加的灵活，可以在运行期间决定是用的哪个类的对象、

#### 反射机制体统的功能

在运行时判断任意一个对象所属的类
在运行时构造任意一个类的对象
在运行时判断任意一个类所具有的成员变量和方法
在运行时获取泛型信息
在运行时调用任意一个对象的成员变量和方法
在运行时处理注解
生成**动态代理**（Spring的动态代理机制）

#### 反射的主要API

java.lang.Class:代表一个类
java.lang.reflect.Method:代表类的方法
Java.lang.reflect.Field:代表类的成员变量
Java.lang.reflect.Constructor:代表类的构造器



```java
//反射创建Person类对象，String.class 和int.class对应的是Person中的两个对象
Class clazz = Person.class;
Constructor constructor = clazz.getConstructor(String.class, int.class);
Person p1 = (Person) constructor.newInstance("Tom", 12);

//调用属性（set重新设置值）
Field field = clazz.getDeclaredField("age");
field.set(p1, 88);

//调用方法 （invoke执行方法）
Method show = clazz.getDeclaredMethod("show");
show.invoke(p1);

//反射可以调用某个类里的私有方法或属性
Constructor declaredConstructor = clazz.getDeclaredConstructor(String.class);
declaredConstructor.setAccessible(true);
Person person = (Person) declaredConstructor.newInstance("Steve");

//可以调用私有的属性
Field name = clazz.getDeclaredField("name");
name.setAccessible(true);
name.set(p1, "Mark");

//可以调用私有的方法
Method showInside = clazz.getDeclaredMethod("showInside", String.class);
showInside.setAccessible(true);
showInside.invoke(p1, "这是一首简单的小情歌");
```

#### 使用反射的场景

在某些场景，在运行的时候确定要创建什么样的对象，根据传递过来的参数指定生产类的对象

反射的特性具有动态性，例如，在服务器运行的时候，会根据浏览器发生的请求去生成相应的实例对象，发送login请求对应的是生成login的对象，发送regist注册生成对应的regist对象

***Java的封装性和反射机制不存在矛盾性***



#### 关java. Lang. CLass类的理解

##### 1.类的加载过程:

程序经过**javac.exe**命令以后，会生成一个或多个**字节码文件**(.class结尾)。
接着我们使用java. exe命令对某个字节码文件进行解释运行。相当于将某个字节码文件**加载到内存**中。**此过程就称为类的加载。**加载到内存中的类，我们称之为运行时类，是Class类的实例

Class类的实例对应着一个运行时类，不需要new创建，无论是自定义的类还是系统提供的类，都是可以作为Class的实例

加载到内存中的运行时类，会在内存中缓存一定的时间，期间可以用以下的方式来获取运行时类

获取Class实例的方式

```java
//通过运行时类调用.class 属性获取类实例
//需要加载的类已经固定，无法改变，必须正确才能通过编译期
Class<Person> clazz = Person.class;

//通过运行时类的对象调用getClass方法
Person person =  new Person();
Class clazz = person.getClass();

//调用Class类的静态方法，.forName(String classPath)方法,
//获得类的全路径名，需要抛出异常
//加载的类会在运行期间进行判断，不存在的时候才异常，
Class.forName(“com.sunny.Person”);

//类加载器
ClassLoader classLoader = ReflectionTest.class.getClassLoader();
Class<?> clazz4 = classLoader.loadClass("com.sunny.reflection.Person");

//调取的是同一个类的运行时类实例，所有内存地址和值都是一样的
System.out.println(clazz1 == clazz2 && clazz1 == clazz3 && clazz3 == clazz2);
```

#### 类的加载过程

![](/QQ截图20190828220211.png)

**加载**:将class文件字节码内容加载到内存中，并将这些静态数据转换成方法区的**运行时数据结构**，然后生成一个代表这个类的**java.lang.Class**对象，作为方法区中类数据的**访问入口**(即引用地址)。所有需要访问和使用类数据只能通过这个Class对象。这个加载的过程需要**类加载**器参与。

**链接**：将Java类的二进制代码合并到JVM的运行状态之中的过程。

验证:确保加载的类信息符合JVM规范，例如:以cafe开头， 没有安全方面的问题

准备:正式为类变量(static) **分配内存并设置类变量默认初始值**的阶段，具体的值会在初始化的时候分配，这些内存都将在方法区中进行分配。

解析:虚拟机常量池内的符号引用(常量名)替换为直接引用(地址)的过程。

**初始化**：执行**类构造器**<clinit>()方法的过程。类构造器<clinit>()方法是由编译期自动收集类中所有类变量的**赋值动作**和**静态代码块**中的语句合并产生的。 (类构造器是构造类信息的，不是构造该类对象的构造器)。

当初始化一个类的时候，如果发现其父类还没有进行初始化，则需要先触发其父类的初始化。

虚拟机会保证一个类的<clinit:()方法在多线程环境中被正确加锁和同步。

例子：

![](/QQ截图20190828224609.png)

#### 三种类加载器

系统类加载器、拓展类加载器、引导类加载器

```java
//自定义类，使用系统类加载器
ClassLoader classLoader = ClassLoaderTest.class.getClassLoader();
System.out.println(classLoader);

//获取系统类加载器的父类：拓展类加载器
ClassLoader parent = classLoader.getParent();
System.out.println(parent);

//拓展类加载器的父类：引导类加载器（无法获取），无法加载自定义类，主要用于加载核心类库
ClassLoader parent1 = parent.getParent();
System.out.println(parent1);

//换言之，核心类库，java系统类库中的属性的加载器则无法被获取到
ClassLoader classLoader1 = String.class.getClassLoader();
System.out.println(classLoader1);
```



#### 反射的例子

##### 调用反射机制来加载配置文件

```java
//读取配置文件的方式一：流的方式
Properties properties = new Properties();
FileInputStream inputStream = new FileInputStream("jdbc.properties");
properties.load(inputStream);

//识别默认配置文件的路径是在src下：调用的是当前类的类加载器
ClassLoader classLoader = ClassLoaderTest.class.getClassLoader();
InputStream resourceAsStream = classLoader.getResourceAsStream("jdbc1.properties");
properties.load(resourceAsStream);
```

##### 通过反射创建运行时类的对象

```java
Class<Person> clazz = Person.class;
Person person = clazz.newInstance();	
//调用的是Person类的无参构造器，可以看出，只要是创建对象，就会使用到构造器，
//而newInstance，调用的是运行时类的无参构造器，运行时类必须要有运行时参构造器

```

##### 根据传递的参数创建对象

```java
for (int i = 0; i < 10; i++) {
    //0,1,2
    int num = new Random().nextInt(3);
    String classPath = "";
    switch (num) {
        case 0:
            classPath = "java.util.Date";	//随机数为0的时候打印日期
            break;
        case 1:
            classPath = "java.lang.Object";	//随机数为1的时候打印对象名
            break;
        case 2:
            classPath = "com.sunny.reflection.Person";	////随机数为2的时候打印自定义对象
            break;
    }
    try {
        Object instance = newInstance(classPath);
        System.out.println(instance);
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```



### 多线程

#### 程序、进程和线程的概念

● **程序(program)**是为完成**特定任务**、用某种语言编写的**一组指令的集合**。即指一段**静态的代码**，静态对象。

● **进程(process)**是程序的**一次执行过程**， 或是正在运行的一个程序。是一个动态的过程:有它自身的**产生**、**存在**和**消亡**的过程。生命周期	
➢如:运行中的QQ,运行中的MP3播放器
➢程序是**静态**的，进程是**动态**的
➢进程作为**资源分配的单位**，系统在运行时会为每个进程分配不同的内存区域

● **线程(thread)**， **进程可进一步细化为线程**，是一个程序内部的**一条执行路径**。
➢若一个进程同一时间并行执行多个线程，就是支持多线程的
➢线程作为调度和执行的单位，每个线程拥有独立的运行栈和程序计数器(pc)，线程切换的开
销小
➢一个进程中的多个线程共享相同的内存单元/内存地址空间→它们从同一堆中分配对象，可以
访问相同的变量和对象。这就使得线程间通信更简便、高效。***但多个线程操作共享的系统资***
***源可能就会带来安全的隐患。***

 Java中一个main方法其实就是对应一个线程

![](/QQ截图20190902214736.png)

虚拟机栈和程序计数器每一个线程都各自具备一个，方法区和堆是一个进程一个，进程下的多个线程共享方法区和堆



##### ● 单核CPU和多核CPU的理解

**➢单核CPU**, 其实是一种**假的多线程**，因为在一一个时间单元内，也只能执行一个线程的任务。例如:虽然有多车道，但是收费站只有一一个工作人员在收费，只有收了费才能通过，那么CPU就好比收费人员。如果有某个人不想交钱，那么收费人员可以把他**“挂起”**(晾着他， 等他想通了，准备好了钱，再去收费)。***但是因为CPU时间单元特别短，因此感觉不出来***。

➢如果是多核的话， 才能更好的发挥多线程的效率。(**现在的服务器都是多核的**)

➢一个Java应用程序Java.exe，其实至少有三个线程: main()主线程，GC()垃圾回收线程，异常处理线程。当然如果发生异常，会影响主线程。

● **并行与并发**

➢**并行**:**多个CPU同时执行多个任务**。比如:多个人同时做不同的事。
➢**并发**:一个CPU(采用时间片)**同时执行多个任务**。比如:秒杀、多个人做同一件事，会设计到多个线程访问一个共享资源

java程序在执行的时候，至少会执行三个线程，main方法主方法线程，垃圾回收机制，

##### 单核多线程的用意

背景:
以单核CPU为例，只使用单个线程先后完成多个任务(调用多个方法)，肯定比用多个线程来完成用的时间更短，为何仍需多线程呢?
**多线程程序的优点**:

1.提高应用程序的响应。对图形化界面更有意义，可增强用户体验。
2.提高计算机系统CPU的利用率
3.改善程序结构。将既长又复杂的进程分为多个线程，独立运行，利于理解和修改

执行的背景

● 程序需要同时执行两个或多个任务。
● 程序需要实现一些需要等待的任务时，如用户输入、文件读写操作、网络操作、搜索等。
● 需要一些后台运行的程序时。

##### 多线程的创建

###### 方式一

1. 继承Thread类，创建一个继承Thread类的子类
2. 重写run（）方法的子类 ，线程执行的操作写在run（）方法中
3. 创建Thread类的子类对象
4. 调用start（）执行当前线程，和调用当前线程的run方法

注意：不能直接调用执行方法的run（）方法，这样不会开启新的线程，已经执行的线程不能再次star()执行，但是可以new一个新的线程执行

较为简洁的方式

```java
//匿名类的方式创建
new Thread(() -> {
    for (int i = 0; i < 100; i++) {
        if (i % 3 == 0) {
            System.out.println(Thread.currentThread().getName() + "被3整除的数:" + i);
        }
    }
}).start();
```

###### 方式二

多线程的创建，方式- -: 继承于Thread类

1.创建-一个继承Thread类的子类

2.重写Thread类的run() --> 将此线程执行的操作声明在run()中

3.创建**Thread**类的子类的对象

4. 通过此对象调用start()

两种方式对比，实现接口的方式多态性更强，更灵活的实现方式，例如，根据java的特性，extends单继承的局限性，实现的方式更适合有多个线程共享数据的时候

Thread类本身也实现了Runnable接口，两种方式都需要重写Run（）方法

***优先选择实现Runnable***



##### 线程的调度

● 调度策略

➢时间片

➢抢占式：高优先级的线程抢占CPU

● Java的调度方法
➢ 同优先级线程组成先进先出队列(先到先服务)，使用时间片策略?
➢ 对高优先级，使用优先调度的抢占式策略

##### 线程的优先级

1. 线程的优先级:

* MAX PRIORITY: 10 

* MIN PRIORITY: 1

* NORM PRIORITY: 5 

  2.如何获取和设置当前线程的优先级:
  getPriority():获取线程的优先级
  setPriority(int p): 设置线程的

* 线程优先级高的线程被CPU执行的概率更高，但是并不是说，执行级别高的会优先执行，而低优先级的线程就不会被执行

##### 线程的分类

守护线程（GC垃圾回收线程 ）和用户线程（main方法，主线程）

线程的五种状态

- **新建:**当一个Thread类或其子类的对象被声明并创建时，新生的线程对象处于新建状态

- **就绪**:处于新建状态的线程被start()后，将进入线程队列等待CPU时间片，此时它已具备了运行的条件，只是没分配到CPU资源
- **运行**:当就绪的线程被调度并获得CPU资源时,便进入运行状态，run()方法定义了 线程的操作和功能
- **阻塞**:在某种特殊情况下，被人为挂起或执行输入输出操作时，让出CPU并临时中止自己的执行，进入阻塞状态
- **死亡**:线程完成了它的全部工作或线程被提前强制性地中止或出现异常导致结束

***线程最终会走向死亡***

![](/QQ截图20190905080108.png)



##### 线程的同步

多个线程对同一共享资源的操作要具有同步性，当某个线程在操作共享数据中尚未完成时，其他线程参与进来对共享资源进行操作，就可能会发生多个线程对一共享资源访问但是返回了不一致的结果

**解决方法：**

当一个线程在操作共享数据的时候，其他线程不能参与进来，直到当前线程操作完成退出时，就算当前线程是存在阻塞状况，其他线程也不能参与到对共享资源的访问，当前线程访问共享资源如果对资源进行了修改，修改后的资源才是其他线程访问的共享资源

关键字：线程锁、同步机制

###### 方法一：同步代码块

操作共享数据的代码块

共享数据

同步监视器（锁），任何一个类的对象，当前对象this

加了线程锁的线程，即便是阻塞了只要没完成操作退出对共享资源的访问，其他线程都不能访问

（要求多个线程要公用一个线程锁）

操作同步代码块的时候，只能有一个线程参与，其他线程等待，相当于是也该单线程的过程，效率低

###### 方法二：同步方法

同步方法的同步监视器是this当前对象



##### 线程安全的懒汉式

```java
/**
 * 静态类同步锁是当前类本身
 * @return
 */
public static  Bank getInstance() {
    //方式一：先进入线程，然后判断是否为null，为null再进行操作共享数据，
    //无论null和非null都会进入到方法，执行效率低
//        synchronized (Bank.class) {
//            if (instance == null) {
//                instance = new Bank();
//            }
//            return instance;
//        }
    //方式二：进入线程首先要判断是否为null，为null才能进行同步方法进行对共享数据的操作
    //不为null的不会放行到
    if (instance == null) {
        synchronized (Bank.class) {
            //new 一个实例，此时被认为是在操作共享数据
            if (instance == null) {
                instance = new Bank();
            }
        }
    }
    return instance;
}
```



线程死锁

➢不同的线程分别占用对方需要的同步资源不放弃，都在等待对方放弃自己需要的同步资源，就形成了线程的死锁
➢出现死锁后，不会出现异常，不会出现提示，只是所有的线程都处于阻塞状态，无法继续



#### 异常处理

**Error和RuntimeException**这一类的异常运行时javac编译的时候不检测，不需要主动添加处理异常的手段当然我们愿意的话也可以添加除了.上述以外其他的异常都需要做检测要求我们必须添加处理异常的手段编译不过去

**Final**（修饰符，修饰变量，方法，或者类本身） **finally**（try catch后的最终执行代码块） **finalize**（Object中的一个方法，在对象被回收的时候使用）

**throws**

1. 只能在方法和构造方法结构上存在
2. 谁调用这个方法，谁处理异常
3. 抛出异常也可以有多个



