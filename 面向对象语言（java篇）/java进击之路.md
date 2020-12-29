---
typora-root-url: images
---

# 								java进击之路

### 动态语言和静态语言

1、动态语言
是一类在**运行时可以改变其结构**的语言:例如新的函数、对象、甚至代码可以被引进，已有的函数可以被刪除或是其他结构上的变化。通俗点说就是在**运行时代码可以根据某些条件改变自身结构**。
主要动态语言: ***Object-C、C#、JavaScript、 PHP、Python、 Erlang。***

2、静态语言
与动态语言相对应的，运行时结构不可变的语言就是静态语言。如Java、 C、C++。

**Java**不是动态语言，但**Java**可以称之为“**准动态语言**”。即Java有-定的动态性，我们可以利用**反射机制**、**字节码操作**获得类似动态语言的特性。Java的动态性让编程的时候更加灵活!



### Java面向对象三大特性

#### 封装

把一个对象的属性私有化，同时提供一些给外部访问属性的方法，一个类不能被外部访问，那就失去了存在的意义

#### 继承

在已经存在的类作为基础拓展父类的功能或者继续使用父类的功能建立新的类，Java的一个强大之处就是在于代码的复用性很高，能非常方便的使用之前使用过的代码

1. 子类拥有父类对象所有的属性和方法（包括私有属性和私有方法），但是父类中的私有属性和方法子类是无法访问，**只是拥有**。
2. 子类可以拥有自己属性和方法，即子类可以对父类进行扩展。
3. 子类可以用自己的方式实现父类的方法

#### 多态

一个引用变量会指向那个类的实例，该类引用变量调用的方法是哪个类中的方法，在编程期间不确定，要在运行期间才能决定

Java实现多态的两种方式：**继承**（多个子类继承同一个父类）和 **接口**（实现接口并覆盖接口中的方法）

- Java的方法重载，就是在类中可以创建多个方法，它们具有相同的名字，但可具有不同的参数列表、返回值类型。调用方法时通过传递的参数类型来决定具体使用哪个方法，这就是多态性

- Java的方法重写，是父类与子类之间的多态性，子类可继承父类中的方法，但有时子类并不想原封不动地继承父类的方法，而是想作一定的修改，这就需要采用方法的重写。重写的参数列表和返回类型均不可修改



### **三元运算符**

(条件表达式)？表达式1：表达式2；

用来完成简单的选择逻辑，即根据条件判断，从两个选择中选择一种执行。

##### **使用格式**

(条件表达式)？表达式1：表达式2；

#### **a) 判断条件表达式，结果为一个布尔值。**

**b) true，运算结果为表达式1**

**c) false，运算结果为表达式2**



### Object类

是所有类的基本类，`java.lang`包下

1. `getClass`方法获取运行时类
2. `hashCode()`生成唯一的hash值，经常被用来HashMapla来保证键的唯一性，或者确认元素的存放位置
3. `equals()`：当equals()方法被重写时，通常需要重写 hashCode 方法，以维护在hashCode 方法最开始的声明，即相等对象必须具有相等的哈希码。
4. `notify()`和`notifyAll()`和`wait()`线程的一些唤醒和等待操作继承于此
5. `finalize()`实现了JVM会释放一些资源，一个对象的`finalize()`只会被调用一次，但不一定会被GC立马回收
6. `Clone()`复制对象，分配一个和源对象一样大小的空间，然后在这个空间创建一个对象，
7. `toString()`方法返回对象表示的字符串，是对这个类的重写



### String

##### String设计成不可变

**字符串常量池**的需要，Java堆内存中一个特殊的存储区域, 当创建一个String对象时,假如此字符串值已经存在于常量池中,则不会创建一个新的对象,而是引用已经存在的对象

String对象缓存`HashCode`，Java中String对象的哈希码被频繁地使用, 比如在hashMap 等容器中，字符串不变性保证了hash码的**唯一性,**因此可以放心地进行缓存

**安全性**，String被许多的Java类(库)用来当做参数,例如 网络连接地址URL,文件路径path,还有反射机制所需要的String参数等，这些都是不能轻易被改变的



### StringBuffer和StringBuilder

`String`是不可变的字符序列，`StringBuffer`和`StringBuilder`是可变的字符序列

- String：`char[] `以final修饰即不可变
- StringBuffer：效率低，线程安全（所有的同步方法都是被synchronized修饰的），没有final修饰，底层创建了一个长度为16的数组
- StringBudler：效率高，线程不安全，没有final修饰

作为参数传递的时候，方法内部 String不会改变值，`StringBuffer`和 `StringBuilder`会改变值，不存在多线程和线程安全问题，一般建议使用`StringBuilder`

可变：底层的char[]数组中含有abc，添加def，不会改变原有的数组，而是在原有的数组上进行增加改变



##### **String为什么不可变**

虽然`String、StringBuffer和StringBuilder`都是final类，它们生成的对象都是不可变的（StringBuffer和StringBuilder可以追加内容），而且它们内部也都是靠char数组实现的，String类中定义的char数组是final的，而StringBuffer和StringBuilder都是继承自`AbstractStringBuilder`类，它们的内部实现都是靠这个父类完成的，可以用**`append`**追加

都是底层使用`char[]`数组存储

```java
//结果是0，返回的有多少值的长度，而不是StringBuffer数组的默认长度，
StringBuffer stringBuffer2 = new StringBuffer();
System.out.println(stringBuffer2.length());
```

**扩容问题**：*如果原有的底层数组装不下了，那么就需要扩容新的数组，默认情况下是扩容原来的2倍 +  2，同时将原有数组中的数据复制到新的数组中*

扩容条件：当Map中阈值大于8同时数组的长度大于64的时候才会进行转红黑树，无满足其中的条件，数组会进行扩容不会转为红黑树

在开发过程中使用带有参数的`StringBuffer`（int capacity）

##### StringBuffer的常用方法

StringBuffer 和 StringBuilder的常用方法差不多，只不过一个是有synchronized关键字一个没有

**StringBuffer append(xxx):**提供了很多的append()方法，用于进行字符串拼接
***StringBuffer delete(int start,int end)***:删除指定位置的内容
***StringBuffer replace(int start, int end, String str)***:把[start,end)位 置替换为str
***StringBuffer insert(int offset, XXX)***:在指定位置插入xXX
***StringBuffer reverse()***:把当前字符序列逆转

append和insert时， 如果原来value数组长度不够，可扩容数组

##### String、StringBuffer和StringBuilder的执行效率

StringBuilder > StringBuffer > String



### 日期时间API

##### `java.lang.system`类

`System类`提供的`public static long currentTimeMillis()`用来返回当前时间与1970年1月1日0时0分0秒之间以毫秒为单位的时间差。

##### `java.util.Date`

```java
Date date = new Date();

System.out.println(date.getTime());//1566296624156
```



### 泛型

建立类型安全的集合，本质是**数据类型的参数化**，使用了泛型的集合不必进行强制类型转换，类型的转换在编译器内完成了，提高了可读性和安全性

泛型相当于数据结构中的占位符，在调用的时候传入实际类型

许多容器`list、collection、map`等都包含了泛型



### Collection接口

是**`list、map、list`**子集合的父类，collection中的方法，其所有的子类都有

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

iterator对象我们称之为**迭代器**，是设计模式中的一种，遍历collection中的集合元素

GOF给迭代器模式的定义为:提供一种方法访问一个**容器**(container)对象中各个元索，而又不需暴露该对象的**内部细节**。迭代器模式，*就是为容器而生*。类似于“公交车上的售票员”、“火车上的乘务员”、“空姐”。

Collection接口继承了`java.lang.Iterable`接口，该接口有一个`iterator()`方法，那么所
有实现了Collection接口的集合类都有一个iterator()方法， 用以返回一个实现了
Iterator接口的对象。

**Iterator的遍历方法**

`next []`方法遍历出集合中的一个元素，遍历多次就能得出集合中所有的元素（又时候回发生数组越界状况）

`hasNext()`判断是否还有下一个元素

推荐方法：

```java
//推荐使用方式.next 和 hasNext搭配使用
while (iterator.hasNext()) {
    System.out.print(iterator.next());

}
```

![](/QQ截图20190821233841.png)

##### 迭代器的remove()方法

迭代器内部定义了`remove()`方法，可以删除集合中指定的元素。此方法不同于集合collection中的remove()方法，迭代器的remove()方法必须是使用next()方法之后

```java
while (iterator.hasNext()) {
    Object object = iterator.next();
    if ("tom".equals(object)) {
        iterator.remove();
    }
}
```



***迭代器是用遍历collection及其后台类子类，不包括map，因为map接口不是继承collection接口的***



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

`equals()`方法：判断两个对象是否相等，`hashCode()`：生成唯一的hash值保证唯一性和数据的存放位置

List: equals()方法。
Set: (HashSet、LinkedHashSet 为例): equals()、 hashCode()

​	（Treeset）：compareble接口：compareTO(Object obj)

​				 comparator接口：compare（OBject obj1， Object obj2）



### List

**有序可重复**的的容器，每个元素都有对应的顺序索引，数组存储数据的局限性，通常使用`list`替代数组，相当于是一个动态的自增长的数组

常用的实现类是`ArrayList`（数组），`LinkedList`（链表）和`Vector`（线程安全的数组）



##### ArrayList、LinkedList、Vector三者的异同?

*同*：

​	存储数据的特点（有序可重复），继承list接口，`ArrayList、Vector`底层是使用object数组结构支持随机访问，`LinkedList`是双向链表存储的

*异*：

- `ArrayList`是list集合的**主要实现类**，一般情况下我们都是ArrayList，线程不安全。扩容是1.5倍，jdk8中默认不会再第一次使用的时候实例化添加内存，当需要add的时候默认为10的大小，**涉及到多次查询的时候使用ArrayList**

- `LinkedList`底层是双向链表，插入删除快，查询慢，线程不安全的，**涉及到多次插入删除的时候，使用LinkedList**

- `vector`是最古老的的实现类，线程安全的，扩容是2倍，不常用



##### 常见的List接口方法

***add(Object obj)***
***remove(Object obij/remove(int index)u***
***set(int index,Object obj)***
***get(int index)***
***add(int index,Object obj)***
***size()*** 

**遍历方式：使用Iterator;foreach;普通的for,**



#### ArrayList

底层是`Object数组`实现，查询效率高，增删效率低，线程不安全，但实际开发中不涉及到太多的增删和修改的业务，我们一般使用它

**可以存放任意数量的对象，长度是不受限制的**，本质是当数组的存储已满时，定义一个新的更大的数组，将原数组和新数组的内容一起加入到新数组中，默认大小是10

##### 源码分析

```java
ArrayList arrayList = new ArrayList();	//默认长度是10，可以动态的添加数组
```

ArrayList中的元素添加满了后继续添加的话，会在最小容量minCapacity size+1，如果minCapacity - 默认大小  > 0，则说明需要更大的大小去扩容新的元素，默认情况是扩容到原来内存的**1.5倍**，会创建一个新的Object数组并将原来的旧数组中的值复制到新的数组中并抛弃到旧的数组，扩容是占据一定的性能和时间的

JDK7中在ArrayList创建的时候`Object[]`数组的默认大小是10

而在JDK1.8中并没有初始化的时候指定默认大小，而是在使用**add()**方法时，底层才**创建长度为10**的数组，在使用的时候才实例化

***jdk7中ArrayList对象创建类似于单例模式中的饿汉式，jdk8中的类似于懒汉式，延时在需要使用的时候才会创建***

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

*在开发中，尽量使用带参的构造器：	`ArrayList arrayList = new ArrayList(int capacity)`;*

#####  ArrayList的遍历方式

Collection及其子类都可以使用三种方式进行遍历：for循环、forEach循环、迭代器

```Java
//顺序遍历
for (int i = 0; i < lists.size(); i++) {
  System.out.print(lists.get(i));
}
//forEach循环
for (Integer list : lists) {
System.out.print(list);
}
//迭代器遍历
Iterator<Integer> iterator = linkedList.iterator();
while (iterator.hasNext()) {
    iterator.next();
}
```





#### LinkedList

是一个实现了`List`接口和`Deque接口`的**双端链表**。 LinkedList底层的链表结构使它支持**高效的插入和删除操作**，另外它实现了Deque接口，使得`LinkedList类`也具有**队列**的特性; LinkedList不是线程安全的，如果想使LinkedList变成线程安全的，可以调用静态类`Collections类`中的**synchronizedList**方法

```java
List list=Collections.synchronizedList(new LinkedList(...));
```

##### 内部结构

![](/arraylist.png)

**双向链表优势**：链表中每一个元素都包含着**两个指针**，指向**上一个元素**和**下一个元素**的内存地址，在某个位置插入元素，***是将该位置索引前的元素的next指针指向新插入的元素，新插入的元素的prev指针指向该位置前的那个元素***

![](/QQ截图20190822101355.png)

addAll方法通常包括下面四个步骤：

1. 检查index范围是否在size之内
2. toArray()方法把集合的数据存到对象数组中
3. 得到插入位置的前驱和后继节点
4. 遍历数据，将数据插入到指定位置

常见方法

*****

**void add(int index, 0bject ele)**：	在index位置插入ele元素
**boolean addAll(int index, Collection eles)**：	从index位置开始将ele中的所有元素添加进来
**object get(int index)**：	获取指定index位置的元素
**int indexOf(object obj)：**	返回obj在集合中首次出现的位置
**int LastIndexOf(object obj)**：	返回obj在当前集合中末次出现的位置
**object remove(int index)：**	移除指定index位置的元素，并返回此元素
**object set(int index, object ele)**：	设置指定index位置的元素为ele
**List sublist(int fromIndex, int toIndex)**：	返回从fromIndex到toIndex位置的子集合

**addFirst(E e)**： 将元素添加到链表头部
**addAll(int index, Collection c)**： 将集合从指定位置开始插入
**get(int index)**： 根据指定索引返回数据
**remove(int index)**：删除指定位置的元素

*****

##### 源码分析

双向链表的表现，单向链表是知道节点的下一个节点，只有next，不能知道上一个节点的元素

```java
//双向链表的优势
private static cLass Node<E> {
    E item;
    Node<E> next;	//指向下一个节点的指针
    Node<E> prev;	//指向上一个节点的指针
    
    Node(Node<E> prev, E eLement, Node<E> next) {
    this. item = eLement;
    this.next = next;
    this.prev = prev;
    }
}
```



首次调用`linkLast`新建一个node节点，第一次创建时第一个也是最后一个节点，如果（prev指针为null），说明节点之前没有被添加过时第一个节点，如果不是则说明之前是有节点的并将前一位节点的l指向新加入的节点newNode

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

和`ArrayList`功能类似，创建方式也大致相同，底层都是创建的长度为10的数组，不同的一点是在扩容方面，默认扩容的是原来数组长度的2倍

线程安全的，效率慢



### Set

存储**无序不可重复**的数据

（**无序性**不等于随机性，遍历的时候会遵循一个规律但不是数据的存放顺序，而是根据数据添加的**hash**值，**不可重复性**，添加的元素都会和集合中的元素进行equals比较一下，返回***false***表示不存在这个元素的时候才允许添加到集合中，*相同的元素只能添加一个*）

**set接口没有额外定义的新方法，是继承父类collection定义的方法**



#### Hashset

set接口的主要实现类，存储无序，不可重复的数据，可以存储null值，**线程不安全**的，`HashSe`t底层是`HashMap`

底层是**数组+链表**存储

*****

![](QQ截图20190823180303.png)

*****

##### 添加元素的过程

- 添加元素的时候会调用**Object**对象的`hashCode()`方法生成一个**唯一不重复**的**Hash**值，Hash值保证数据的唯一性和确定**存放的位置**（索引位置）

- 如果此位置上没有其他元素或者首次添加，直接插入数据

- 有可能发生数据要存放的位置已经有元素，但是两个数据彼此之间的hash值并不相同，通过`equals()`方法判断两个元素的hash值，hash值不相等的话被认为是两个不同的元素，就会添加元素，否则添加失败

- **HashSet提供了链表的机制**，新元素会添加到集合数组已存在数据位置的链表前或是后，JDK7是添加在当前数据前并将**next**指针指向该数据，jdk8添加到当前数据后指针指向新插入的数据（***七上八下***）

![](/QQ截图20190823212026.png)

**正式图**

![](QQ截图20190823215054.png)



#### LinkedHashSet

作为`HashSet`的子类，遍历其内部的数据时，***可以根据添加的顺序遍历***，***但本质上存放的位置顺序还是无序的***

在`HashSet`的基础上，每个元素都添加了**两个指针**，指向新前一个和后一个添加的元素，***底层的链表linked是用来计入数据的添加顺序***

##### 原理图

![](QQ截图20190823234406.png)

***对于频繁遍历的数据操作，使用LinkedHashSet***



#### TreeSet

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

***双列数据，key-value对应的数据***



#### HashMap

`HashMap`是Map主要的实现类，线程不安全，效率高

`HashMap`底层是使用**哈希表**，基本结构是**数组+链表**，默认的长度是***16***

 * 数组:占用空间连续。寻址容易,查询速度快。但是,增加和删除效率非常低。
 * 链表:占用空间不连续。寻址困难， 查询速度慢。 但是,增加和删除效率非常高。
 * HashMap结合两种数据结构的优点

```java
/*
* DEFAULT_LOAD_FACTOR 加载
*/
public HashMap() {
    this.loadFactor = DEFAULT_LOAD_FACTOR; // all other fields defaulted
}
```

***entry[]*** 数组是HashMap的核心，entry对象中存储了key value键值对，next指向下一个节点，hash值，每一个entry对象都是一个**单向链表**（或者叫节点对象）

![](QQ拼音截图20190814221752.png)

##### key和value的存储特点：

key其实是无序的，不能重复，就相当于集合中的set，value是可重复，根据key的分布规则，可以一定意义上理解value也是无序的

key和value键值对组成一个entry对象

![](/QQ截图20190826085852.png)

***小结：存储自定义类对象，vaule的所在类一定要重写hashCode()方法和equals()方法***



##### HashMap的数据结构

自上而下是数组结构，每个数组节点可以是一个**单向链表**，相比单纯的链表和数组，HashMap存储的更多数值，同时具备数组链表各自的有点

![](QQ拼音截图20190814225446.png)

***HashMap的底层:  数组+链表(jdk7及之前)***
							 ***数组+链表+红黑树(jdk8)***

##### 存储过程

Object对象的`hashCode()`方法，通过`hashcode()`方法得到hash码，得到在entry数组中的存放位置，HashMap的hash()方法计算出数组的长度，计算出对于的hash值（区间在[0,数组长度-1]）之间，转换的hash值尽量均匀分布在这个区间之内，通过**散列算法**等分散分配put进去的值，***理论上越分散越有利于HashMap的性能***

![](QQ拼音截图20190814231536.png)

**总结**：由上可知，当添加一个元素时，首先计算key的hash值，**确定插入数组的位置**，如果某一hash值存在的数组节点中已经有元素了，哈希值相同的继续比较**equals**，返回false表示两个对象是不同的，返回true则是修改功能覆盖原来的数据，数据添加到同一hash值的后面（**单向链表**），jdk8之后，链表长度大于8时，链表转换为**红黑树**，提高效率，jdk8中的底层数组是Node[]，而非entry[]数组，



##### 取数据过程

1. 获得key的hashcode , 通过**hash()散列算法**得到hash值,进而定位到数组的位置。

2. 在链表上挨个比较key对象。调用equals()方法 ,将key对象和链表上所有节点的key对象进行，,直到碰到返回true的节点对象为止。

3. 返回equals()为true的节点对象的value对象

   ***Java中规定,两个内容相同(equals(为true)的对象必须具有相等的hashCode和quals()***

   

##### HashMap扩容

HashMap的位桶数组**,初始大小为16**。实际使用时,显然大小是可变的。如果位桶数组中的元素，达到(0.75*数组length)，就重新调整数组大小变为原来**2倍**大小。（数组为16，大小为12时开始扩容）

**扩容的本质是定义新的更大的数组,并将旧数组内容挨个拷贝到新数组中。很费时间**

根据**LoadFactor**加载因子，加载因子越接近于1，说明HashMap中的数据存储的越多链表越长，越接近于0，存储的数据越少，临界因子的大小会影响到执行效率，0.75f是最好的临界值

```java
public HashMap(int initialCapacity, float loadFactor) {
    if (initialCapacity < 0)
        throw new IllegalArgumentException("Illegal initial capacity: " +
                                           initialCapacity);
    if (initialCapacity > MAXIMUM_CAPACITY)
        initialCapacity = MAXIMUM_CAPACITY;
    if (loadFactor <= 0 || Float.isNaN(loadFactor))
        throw new IllegalArgumentException("Illegal load factor: " +
                                           loadFactor);
    this.loadFactor = loadFactor;
    this.threshold = tableSizeFor(initialCapacity);
}
```

- 第一个参数：**初始容量**，指明初始的桶的个数；相当于桶数组的大小。
- 第二个参数**：装载因子**，是一个0-1之间的系数，根据它来确定需要扩容的阈值，默认值是0.75。



##### jdk8中HashMap的区别

jdk8相较于jdk7在底层实现方面的不同:
1. new HashMap():底层没有创建一个长度为16的数组
2. jdk 8底层的数组是: Node[], 而非Entry[]
3. 首次调用`put()`方法时，底层创建长度为16的数组
4. jdk7底层结构只有:数组+链表。jdk8中底层结构:**数组+链表+红黑树**。
    当数组的某一个索引位置上的元素以链表形式存在的数据个数> 8且当前数组的长度> 64时，
    些索引位器的所有数据改为用红黑树存储；



#### LinkedHashMap

HashMap的子类，在遍历数据的时候，**可以按照添加的顺序实现遍历**

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

在collection及其子类，可以使用**forEach，迭代器，for循环遍历**

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

线程安全的，不能存储null的键值对，是线程安全的，修改会锁住整个HashTable

##### Properties

配置文件类，key和value都是String类型



#### ConcurrentHashMap

是J.U.C(`java.util.concurrent`包)的重要成员，它是HashMap的一个**线程安全的**、**支持高效并发**的版本，***`ConcurrentHashMap`可以支持16个线程执行并发写操作及任意数量线程的读操作***。

##### 概述

`HashMap`不是线程安全的，多线程环境下，操作HashMap可能会出现线程安全问题

`ConcurrentHashMap`本质上是一个Segment数组，而一个Segment实例又包含若干个桶，每个桶中都包含一条由若干个 HashEntry 对象链接起来的链表。**总的来说，是才有分段的数组+链表实现，线程安全的**

`ConcurrentHashMap`是`HashTable`的替代者，有更好的拓展性

![](ConcurrentHashMap.jpg)

`ConcurrentHashMap`是Java5中推出的支持高并发高吞吐量的集合类，`Segment`数组扮演锁的机制，是一个可重入锁，采用的锁分段将数据分成一段一段的，每一段数据都有一把锁，在访问其中一段数据时该数据段被锁，其他的数据段也能被其他的线程访问

`ConcurrentHashMap`是采用分段锁，一次锁住一个桶，`HashTable`是将整个Hash表锁住

`ConcurrentHashMap`默认是分为16个桶，Map的操作都是指锁住需要的桶，相当于`ConcurrentHashMap`可以有16个线程执行



#### **线程安全(Thread-safe)的集合对象：**

- Vector 线程安全：
- HashTable 线程安全：
- StringBuffer 线程安全：

#### **非线程安全的集合对象：**

- ArrayList ：
- LinkedList：
- HashMap：
- HashSet：
- TreeMap：
- TreeSet：
- StringBulider：



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





### 反射

**Reflection** (反射)是被视为**动态语言**的关键，反射机制允许程序在**执行期间**借助于Reflection API取得任何类的内部信息，**并能直接操作任意对象的内部属性及方法**。

反射机制用来描述所有的类，所有的类都具有相同的特征，共同特征是每一个类都有属性，方法，构造方法，权限修饰符等

加载完类之后，在**堆内存的方法区**中就产生了一个**Class**类型的对象(一个类只有一个Class对象)，这个对象就包含了完整的类的结构信息。我们可以通过这个对象看到类的结构。这个对象就像一面镜子，透过这个镜子看到类的结构，所以，我们形象的称之为:**反射**。

反射机制使原本是静态语言的Java有了类似动态语言的特性，使编程更加的灵活，可以在**运行期间决定是用的哪个类的对象、**



#### 类和反射

![](/QQ截图20190924083007.png)

Class类也可以描述基本数据类型，因为基本数据类型也是一个类



#### 反射中的五大属性

Class：用来描述类本身

FieId：用来描述类中的属性

Method：用来描述类中的方法

Constroctor：用来描述类中的构造方法

Annotation：用来描述类中的注解@Override



#### 反射机制体统的功能

在运行时判断任意一个对象所属的类
在运行时构造任意一个类的对象
在运行时判断任意一个类所具有的成员变量和方法
在运行时获取泛型信息
在运行时调用任意一个对象的成员变量和方法
在运行时处理注解
生成**动态代理**（Spring的动态代理机制）

#### 反射的主要API

`java.lang.Class`:代表一个类
`java.lang.reflect.Method`:代表类的方法
`Java.lang.reflect.Field`:代表类的成员变量
`Java.lang.reflect.Constructor`:代表类的构造器、】



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



#### 关java. Lang. Class类的理解

##### 1.类的加载过程:

程序经过**javac.exe**命令以后，会生成一个或多个**字节码文件**(.class结尾)。
接着我们使用java. exe命令对某个字节码文件进行解释运行。相当于将某个字节码文件**加载到内存**中。**此过程就称为类的加载。**加载到内存中的类，我们称之为运行时类，是Class类的实例

Class类的实例对应着一个运行时类，不需要new创建，无论是自定义的类还是系统提供的类，都是可以作为Class的实例

加载到内存中的运行时类，会在内存中缓存一定的时间，期间可以用以下的方式来获取运行时类

##### 获取Class实例的方式

```java
//通过运行时类调用.class 属性获取类实例,Person类必须存在
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

**Class类的常用方法**

`getModifiers()`获取类的修饰符，返回的是一个整数，各个权限修饰符和特征修饰符都是用一个数字表示，两个权限修饰符返回的值会求和

```java
int modifiers = clazz. getModifiers() ;
//每一个修饰符用一个整数来进行表示
//0开始---01248163264128256512
//0--默认不写 1--public 2--private 4--protected
//8--static 
//16--final 32--synchronized 64volati le
//128--transient
```

`clazz.getSimpleName()和getName()`前者获取的仅仅是类名，后者是全路径名

`getPackage()`获取包名

`getSuperclass()`和`getInterface()`获取超类父类和父接口

`newInstance`调用Person类的无参构造方法

`getField()`和`getFields()`获取类中的属性，只能调用本类中的私有公有属性，包括获取父类的

`getDecalaredFileds()`和`getDecalaredFiled()` 获取类的全部属性，但不包括父类的

`getClasses()`获取内部类



反射可以获取操作私有属性，private关键字修饰的变量本质上是不允许外界修改的，但反射的强大之处可以体现在此处

`setAccessible(true)`：java 中私有属性是不能随意被修改的，Accessible设置为true表示该私有属性可以被修改



**Filed类中的常用方法**
`getModifiers()`获取属性修饰符(权限+特征)

`getType()`获取属性的类型对应的那个class

`getName` 获取属性的名字，操作属性

set(对象,值);给属性赋值

Object = get(对象)从某个对象内取得属性的值

`setAccessable()`可以设置私有变量可以修改

**操作方法**

clazz.getMethod();	//获取方法

int mm = m.getModifiers();//获取方 法的修饰符(权限+特征)

Class mrt = m.getReturnType();//获取返回值数据类型

String mn = m.getName();//获取方法的名字

Class[] mpts = m.getParameterTypes();//获取方法参数列表的类型

Class[] mets = m.getExceptionTypes();//获取方法抛出异常的类型

setAccessable(true);//如果方法是私有的，设置为true的可以操作私有方法



**操作构造方法**（和操作方法大致相同）

Constructor<Person> constructor = clazz.getConstructor();	//获取构造方法

con.getModifiers();

con.getName();

con.getParameterTypes();

con.getExceptionTypes();

操作构造方法，执行一-次创建对象

object = newInstance(执行构造方法时的所有参数

#### 反射的技术应用

反射应用应用层的开发和功能实现可能效果不是很理想，但是应用于一些小框架的封装和对象的管理效果很好

反射有四种加载类的方式，已知类.class（Person.class）、已知类.getClass(Person.getClass)、类加载器(Person.class.getClassLoader)、Class.forName(Class.forName(com.sunny.Person)

其中`Class.forName`可以根据字符串String生成一个实例类，在做一些底层的开发中，可以根据包含类信息的字符串文件生成大批量的对象，

##### 动态代理

代理模式的原理：使用一个代理将对家包装起来，然后用该代理取代原始对象。仕何对原始对象的							调用都要通过代理。代理对象决定是否以及何时将方法调用转到原始对象上

实际场景：辩护人的律师，明星的经纪人

静态代理是一个代理类对应一个接口，只能为一个接口服务，如果需要代理的对象很多，相应的代理的的代理类也会很多，**最好是能有一个代理类完成全部的代理功能——动态代理**

动态代理通过一个代理类来调用其他对象的方法，在运行期间动态的创建目标代理对象

一个代理就可以完成所有代理类的功能

1. 如何动态的创建代理类和对象
2. 如何动态的调用被代理类的同名方法



### 多线程

**什么是线程安全？**

线程安全是编程中的术语，指某个函数、函数库在并发环境中被调用时，能够正确地处理多个线程之间的**共享变量**，使程序功能正确完成。即在多线程场景下，不发生有序性、原子性以及可见性问题。

**如何保证线程安全？**

Java中主要通过加锁来实现线程安全。通常使用`synchronized`和`Lock`



**什么是锁？死锁？**

死锁是指两个或两个以上的进程在执行过程中，由于**竞争资源**或者由于**彼此通信**而造成的一种阻塞的现象，若无外力作用，它们都将无法推进下去。此时称系统处于死锁状态或系统产生了死锁，这些永远在互相等待的进程称为死锁进程。

死锁四个必要条件：**互斥条件、请求和保持条件、不剥夺条件、环路等待条件**

***死锁的解决办法就是破坏以上四种必备条件中的一个或者多个。***

产生死锁的**四个必要条件**：

（1） **互斥条件**：一个资源每次只能被一个进程使用。

（2） **占有且等待**：一个进程因请求资源而阻塞时，对已获得的资源保持不放。

（3）**不可强行占有**:进程已获得的资源，在末使用完之前，不能强行剥夺。

（4） **循环等待条件**:若干进程之间形成一种头尾相接的循环等待资源关系。

***这四个条件是死锁的必要条件***，只要系统发生死锁，这些条件必然成立，而只要上述条件之一不满足，就不会发生死锁。



##### 涉及到线程

线程安全：StringBuffer、Vector、HashTable

线程不安全：StringBuilder、ArrayList、HashMap

##### 多线程的场景

在播放器播放视频的时候，可以同时操作声音或是进度条，画面不会受到影响，实际上一个播放页面有多条线程执行，调节音量或进度条对应这一个线程

程序是一组静态的代码，进程是正在运行的播放器（静态的代码运行起来），线程是正在执行的小单元（调节音量进度条），线程之间是互不影响

1. 主线程 系统线程（JVM）

2. 用户线程 main方法（用户创建的程序入口）

3. 守护线程 GC垃圾回线程

   线程的操作线程运行级别很大程度上是由CPU决定的，***CPU决定线程的执行顺序***

##### 线程的五种状态

线程创建`new()`、就绪状态`start()`、执行状态`notify()/notifyAll()`、等待/挂起`wait()`、异常/死亡`over/exception`

##### run()和start()

run()方法会根据前后顺序执行，start()让线程进行就绪状态，并由CPU调度执行



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

对于



**同步方法**，JVM采用`ACC_SYNCHRONIZED`标记符来实现同步，同步方法的常量池中会有一个`ACC_SYNCHRONIZED`标志。当某个线程要访问某个方法的时候，会检查是否有`ACC_SYNCHRONIZED`，如果有设置，则需要先获得监视器锁，然后开始执行方法，方法执行之后再释放监视器锁。这时如果其他线程来请求执行方法，会因为无法获得监视器锁而被阻断住，*如果在方法执行过程中，发生了异常，并且方法内部并没有处理该异常，那么在异常被抛到方法外面之前监视器锁会被自动释放。*

对于**同步代码块**。JVM采用`monitorenter`、`monitorexit`两个指令来实现同步，执行`monitorenter`指令理解为加锁，执行`monitorexit`理解为释放锁。 每个对象维护着一个记录着被锁次数的计数器，同一个线程访问锁会多次递增，当计数器为0释放所并可以被其他线程获取



#### 程序、进程和线程的概念

● **程序(program)是为完成特定任务**、用某种语言编写的**一组指令的集合**。即指一段**静态的代码**，静态对象。

● **进程(process)是程序的一次执行过程**， 或是正在运行的一个程序。是一个动态的过程:有它自身的**产生**、**存在**和**消亡**的过程。

生命周期 ➢如:运行中的QQ,运行中的MP3播放器 ➢程序是**静态**的，进程是**动态**的 

➢进程作为**资源分配的单位**，系统在运行时会为每个进程分配不同的内存区域

● **线程(thread)**， **进程可进一步细化为线程**，是一个程序内部的**一条执行路径**。 

➢若一个进程同一时间并行执行多个线程，就是支持多线程的 ➢线程作为调度和执行的单位，每个线程拥有独立的运行栈和程序计数器(pc)，线程切换的开 销小 

➢一个进程中的多个线程共享相同的内存单元/内存地址空间→它们从同一堆中分配对象，可以 访问相同的变量和对象。这就使得线程间通信更简便、高效。***但多个线程操作共享的系统资*** ***源可能就会带来安全的隐患。***

Java中一个main方法其实就是对应一个线程

![img](QQ截图20190902214736.png)

虚拟机栈和程序计数器每一个线程都各自具备一个，方法区和堆是一个进程一个，进程下的多个线程共享方法区和堆



##### 从JVM角度说一下线程和进程的区别

一个进程下的多个线程，共享Java内存区域的堆和方法区（JDK1.8是元空间），每个线程有独立互不影响的程序计数器，虚拟机栈和本地方法栈，因此线程之间是会互相影响的



##### 单核CPU和多核CPU的理解

**➢单核CPU**, 其实是一种**假的多线程**，因为在一一个时间单元内，也只能执行一个线程的任务。例如:虽然有多车道，但是收费站只有一一个工作人员在收费，只有收了费才能通过，那么CPU就好比收费人员。如果有某个人不想交钱，那么收费人员可以把他**“挂起”**(晾着他， 等他想通了，准备好了钱，再去收费)。***但是因为CPU时间单元特别短，因此感觉不出来***。

➢如果是多核的话， 才能更好的发挥多线程的效率。(**现在的服务器都是多核的**)

➢一个Java应用程序Java.exe，其实至少有三个线程: main()主线程，GC()垃圾回收线程，异常处理线程。当然如果发生异常，会影响主线程。

● **并行与并发**

➢**并行**:**多个CPU同时执行多个任务**。比如:多个人同时做不同的事。 

➢**并发**:一个CPU(采用时间片)**同时执行多个任务**。比如:秒杀、多个人做同一件事，会设计到多个线程访问一个共享资源

Java程序在执行的时候，至少会执行三个线程，**main方法、主方法，垃圾回收机制线程**，



##### 单核多线程的用意

背景: 以单核CPU为例，只使用单个线程先后完成多个任务(调用多个方法)，肯定比用多个线程来完成用的时间更短，为何仍需多线程呢? **多线程程序的优点**:

1.提高应用程序的响应。对图形化界面更有意义，可增强用户体验。 2.提高计算机系统CPU的利用率 3.改善程序结构。将既长又复杂的进程分为多个线程，独立运行，利于理解和修改

执行的背景

● 程序需要同时执行两个或多个任务。 ● 程序需要实现一些需要等待的任务时，如用户输入、文件读写操作、网络操作、搜索等。 ● 需要一些后台运行的程序时。



##### 多线程的创建

###### 方式一

1. 继承`Thread`类，创建一个继承Thread类的子类
2. 重写`run（）`方法的子类 ，线程执行的操作写在run（）方法中
3. 创建`Thread`类的子类对象
4. 调用`start（）`执行当前线程，和调用当前线程的run方法

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

多线程的创建，方式一: 继承于Thread类

1.创建-一个实现`Runnable`类的子类

2.重写`Thread`类的run() --> 将此线程	执行的操作声明在run()中

3.创`Thread`类的子类的对象

1. 通过此对象调用start()

两种方式对比，实现接口的方式多态性更强，更灵活的实现方式，例如，根据java的特性，extends单继承的局限性，实现的方式更适合有多个线程共享数据的时候

Thread类本身也实现了`Runnable`接口，两种方式都需要重写Run（）方法



***优先选择实现Runnable***

##### 线程的调度

● 调度策略

➢时间片

➢抢占式：高优先级的线程抢占CPU

● Java的调度方法 ➢ 同优先级线程组成先进先出队列(先到先服务)，使用时间片策略? ➢ 对高优先级，使用优先调度的抢占式策略

##### 线程的优先级

1. 线程的优先级:

- MAX PRIORITY: 10

- MIN PRIORITY: 1

- NORM PRIORITY: 5

  2.如何获取和设置当前线程的优先级: getPriority():获取线程的优先级 setPriority(int p): 设置线程的

- 线程优先级高的线程被CPU执行的概率更高，但是并不是说，执行级别高的会优先执行，而低优先级的线程就不会被执行



##### 线程的分类

**守护线程（GC垃圾回收线程 ）和用户线程（main方法，主线程）**

线程的五种状态

- **新建:**当一个Thread类或其子类的对象被声明并创建时，新生的线程对象处于新建状态
- **就绪**:处于新建状态的线程被start()后，将进入线程队列等待CPU时间片，此时它已具备了运行的条件，只是没分配到CPU资源
- **运行**:当就绪的线程被调度并获得CPU资源时,便进入运行状态，run()方法定义了 线程的操作和功能
- **阻塞**:在某种特殊情况下，被人为挂起或执行输入输出操作时，让出CPU并临时中止自己的执行，进入阻塞状态
- **死亡**:线程完成了它的全部工作或线程被提前强制性地中止或出现异常导致结束

***线程最终会走向死亡***



![](QQ截图20190905080108.png)

##### 线程的同步

多个线程对同一共享资源的操作要具有同步性，当某个线程在操作共享数据中尚未完成时，其他线程参与进来对共享资源进行操作，就可能会发生多个线程对一共享资源访问但是返回了不一致的结果

**解决方法：**

当一个线程在操作共享数据的时候，其他线程不能参与进来，直到当前线程操作完成退出时，就算当前线程是存在阻塞状况，其他线程也不能参与到对共享资源的访问，当前线程访问共享资源如果对资源进行了修改，修改后的资源才是其他线程访问的共享资源

关键字：线程锁、同步机制



###### 方法一： 同步代码块

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

##### 线程死锁

➢不同的线程分别占用对方需要的同步资源不放弃，都在等待对方放弃自己需要的同步资源，就形成了线程的死锁 ➢出现死锁后，不会出现异常，不会出现提示，只是所有的线程都处于阻塞状态，无法继续

**线程死锁的解决方法**

破坏产生死锁的四个条件就可以

- 互斥条件
- 请求和 保持条件
- 不剥夺条件
- 循环等待条件



#### 线程池

new Thread频繁创建比较消耗性能，线程之间也缺乏统一的管理

线程缺乏统一的调度和管理，可能会存在竞争的关系

##### Java提供的四种线程池

重用已经存在的线程，减少Thread对象的创建、销毁等的性能开销

可以控制线程数量，提高资源的使用率

提供定时执行、定期执行、单线程、并发数控制等功能。

Java通过`Executors`提供四种线程池，分别为：

`newCachedThreadPool`创建一个**可缓存线程池**，如果线程池长度超过处理需要，可**灵活回收空闲线程**，若无可回收，则新建线程。





### 异常处理

**Error和RuntimeException**这一类的异常运行时javac编译的时候不检测，不需要主动添加处理异常的手段当然我们愿意的话也可以添加除了.上述以外其他的异常都需要做检测要求我们必须添加处理异常的手段编译不过去

**Final**（修饰符，修饰变量，方法，或者类本身） **finally**（try catch后的最终执行代码块） **finalize**（Object中的一个方法，在对象被回收的时候使用）

**throws**

1. 只能在方法和构造方法结构上存在
2. 谁调用这个方法，谁处理异常
3. 抛出异常也可以有多个

#### Throwable和Exception的区别

所有需要throw抛出的异常都是需要Throwable派生而来，是所有异常子类的超类父类。

有的情况需要使用自定义的异常，而自定义的异常也是Exception派生而来

**Throwable是java.lang包中一个专门用来处理异常的类。它有两个子类，即Error 和Exception，它们分别用来处理两组异常。**

Exception的两个子类的区别

- Exception类表示程序可以处理的异常，可以捕获且可能恢复。遇到这类异常，应该尽可能处理异常，使程序恢复运行，而不应该随意终止异常
- Exception类又分为运行时异常（Runtime Exception）和受检查的异常(Checked Exception )，运行时异常;ArithmaticException,IllegalArgumentException，编译能通过，但是一运行就终止了，程序不会处理运行时异常，出现这类异常，程序会终止。而受检查的异常，要么用try。。。catch捕获，要么用throws字句声明抛出，交给它的父类处理，否则编译不会通过。。
- Error类一般是指与虚拟机相关的问题，如系统崩溃，虚拟机错误，内存空间不足，方法调用栈溢等。对于这类错误的导致的应用程序中断，仅靠程序本身无法恢复和和预防，遇到这样的错误，建议让程序终止。



#### throw和throws

throw是在方法内部捕获，throws是声明在方法上



### I/O输入输出流

数据流动的方向 **读数据(输入Input)**、**写数据(输出output)** 文件流、字符流、数据流、对象流、网络流

#### 文件，文件流

文件：一种电脑的存储形式：.txt .doc .jar

使用File对象来操作电脑上的文件和文件夹（目录路径），是文件会或目录文件名的抽象表示形式，与真实硬盘的文件和目录是不一样的，File是内存中的一个对象，和真实文件形成映射关系

文件夹是不占用大小的，取决于文件夹中的文件的数量和大小

#### 绝对路径和相对路径

**绝对路径**： 绝对路径是指文件在硬盘上真正存在的路径。（在实际开发中不推荐使用）

**相对路径**： 所谓相对路径，就是相对于自己的目标文件位置。当前项目的所在位置

createNewFile:创建一个新的文件

mkdirs：创建包含文件的文件夹

mkdir：创建单个文件夹

String[] names = list();	//获取当前文件的所有子文件或目录的名字

File[] files = listFiles();	//获取当前当前文件的所有子文件或目录的对象

delete();	//删除后的文件永久删除，文件夹中都没有

#### 文件流

操作文件中的内容

**文件输入输出流、字节字符输入输出流**

字节型文件流（**1字节**）：FileInputStream/FileOutputStream

字符型文件流（**2字节/一字符**）：FileReader/FileWriter

流是内存和硬盘之间的管道

**存储**

**变量**：只能存储一个

**数组**：存放多个，数据类型统一大小固定

**集合**：存储多个，存储大小可变自增

**泛型**：数据类型统一

以上都是java的存储对象，存储在内存区域中，程序执行完毕就会像销毁，**临时性存储**

文件：存储多个文件

文件是存储在硬盘上，永久保存，对文件数据进行操作需要通过IO

**int code = is.read()**；每次在流管道中读取一个字节，返回的字节的code码。

**int code = is.read(byte[])**每次从流管道中读取若干个字节，存入byte数组后返回的是数组大小，也字节文件的个数

**int count = is.available()**；返回流管管道中还有多少缓存的数字节数

**对文件的操作**

```java
/**
 * 文件的复制
 */
public void copyFile(File file, String path) {
    FileInputStream inputStream = null;
    FileOutputStream outputStream = null;
    try {
        //创建一个流对象读取文件数据（复制文件先要使用输入流读取获得文件中的数据，
        // 然后通过输出流对象将数据写入到新文件中）
        inputStream = new FileInputStream(file);
        //复制完成后的文件（路径名+文件名）
        File newFile = new File(path + "//" + file.getName());
        //文件输出流（将文件数据复制到新文件）
        outputStream = new FileOutputStream(newFile);
        //字节缓冲区数组（指定大小的值，若读取的值读不满，会有很大的空间浪费）
        byte[] bytes = new byte[1024];
        //将输入流对象中的数据放入到缓冲区(读取的是第一个字节)
        int read = inputStream.read(bytes);
        while (read != -1) {
            //读取指定偏移量的有效字节
            outputStream.write(bytes, 0, read);
            outputStream.flush();
            //循环读取第二个和接下来的数据
            read = inputStream.read();
        }
        System.out.println("复制完毕");

    } catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }finally {
        if (inputStream != null) {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

/**
 * 复制文件夹
 */
public void superCopyFile(File file, String newPath) {
    String oldFilePath = file.getAbsolutePath();
    //截取文件绝对路径名：后面的路径，索引值为0表示盘根路径
    String newFilePath = newPath + oldFilePath.split(":")[1];
    File newFile = new File(newFilePath);
    //如果数组子元素不等于null说明文件下还有文件，是个文件夹
    File[] files = file.listFiles();
    //判断是否是文件夹
    if (files != null) {
        newFile.mkdir();
        System.out.println(newFile.getName() + "复制完毕");
        //递归复制文件夹下的内容
        if (files.length != 0) {
            for (File f : files) {
                this.superCopyFile(f, newPath);
            }
        }
    } else {
        //输入输出流操作文件
        FileInputStream is = null;
        FileOutputStream os = null;
        try {
            is = new FileInputStream(file);
            os = new FileOutputStream(newFile);
            byte[] bytes = new byte[1024];
            int count = is.read();
            while (count != -1) {
                os.write(bytes);
                os.flush();
                count = is.read();
            }
            System.out.println(newFile.getName() + "复制完毕");
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
            	....
            } catch (IOException e) {
               	....
            }
        }
    }
}

public static void main(String[] args) {
    OperateFile operateFile = new OperateFile();
    operateFile.superCopyFile(new File("C://test"),"D://test");
//        operateFile.copyFile(new File("C://Users//Administrator//Desktop//知乎静文.txt"),"D://test");
}
```

**字节型文件流**可以操作**所有类型**的文件，音频文本都可以，是一个字节一个字节读取写入，所以一般会用到while等循环操作，字节型可能对中文可能会产生乱码错误

**字符型文件流**只能操作纯文本文件（txt.html.jsp），所谓纯文本文件就是可以右键记事本直接打开不会乱码的文件

字节流的缓冲区是byte数组，字符流的缓冲区是char数组

**FileReader**

read();	read(char[])

**FileWriter**

writer(code);	writer(char[]);	writer(String);	flush();	close();

字符（**character**）文字和**符号的总称**，在操作纯文本的文件，不需要改变开发运行环境的编码格式，推荐改变文本文件的编码格式为**utf-8**

#### 流总结

**文件流**：**FileInputStream/FileOutputStream	FileReader/FileWriter**

**缓冲流：**为了在流管道中增加缓冲的数据，使读取数据的时候更加的流畅，缓冲流本质还是FIleInputStream，多了一个缓冲区，属于高级流，创建低级流升级为高级流

**BufferdInpuStream/BufferdOutPutStream	BufferedReader/BufferedWriter**

**BufferedRead**中有一个独特的方法.**readLine()**读取一行记录

```java
try {
    File file = new File("D://test//知乎静文.txt");
    FileInputStream fileInputStream = new FileInputStream(file);
    //从缓冲中取出数据。底层还是普通的流，使用和基本流没有什么区别，但性能有很大的提升
    BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);
} catch (IOException e) {
    e.printStackTrace();
}
```

**数组流**：byte数组	ByteArrayInputStream	ByteArrayOutputStream

​	char数组	CharArrayReader CharArrayWriter

**对象流：**ObjectInputStream	ObjectOutputStream对象的序列化和反序列化（需要实现serialiazable接口）

将对象直接拆分为字节码，直接写入到文件中

#### IO小练习

实现一个银行系统，基本的登录查询存取退出等功能

##### 登录功能

```java
/**
 * 以IO流的方式读取文件的信息，都需要创建一个内存到硬盘的的流管道，
 * 业务需求增大的时候，频繁的开辟新的流和读取操作会消耗一定的性能
 * 采用缓存机制
 * 在内存中创建一个缓存区，存放所有读取的文件数据信息，都存放进缓存区中
 * 优先使用Map集合
 * 一行记录，有不同的字段属性，可以创建一个新的对象，java对对象的操作是比较自由的
 */
private HashMap<String, User> userHashMap = new HashMap<>();

//程序块的作用是在对象创建之前 给集合进行复制操作
{
    //读取用户密码文件的流对象
    File file = new File("src\\test\\user.txt");
    FileReader fileReader = null;
    BufferedReader bufferedReader = null;
    try {
        fileReader = new FileReader(file);
        bufferedReader = new BufferedReader(fileReader);
        String value = bufferedReader.readLine();
        while (value != null) {
            String[] userValue = value.split("-");
            User user = new User(userValue[0], userValue[1], Float.parseFloat(userValue[2]));
            userHashMap.put(user.getUsername(), user);
            value = bufferedReader.readLine();
        }

    } catch (IOException e) {
        e.printStackTrace();
    }finally {
        //关闭IO流释放内存
        .....
```

Map集合充当提供执行性能的缓存区，也是作为修改数据的承载体，修改数据先是将集合中的数据修改，然后将集合中的数据全部写入覆盖文件（有个缺陷就是当数据量变大的时候，重复的全部覆盖读写，会造成不必要的性能浪费）

##### 操作流将数据写入文件

```java
/**
 * 将集合中的的临时数据永久写入到文件中
 */
public void commit(){

    FileWriter fileWriter = null;
    BufferedWriter bufferedWriter = null;
    try {
        File file = new File("");
        fileWriter = new FileWriter(file);
        bufferedWriter = new BufferedWriter(fileWriter);
        //通过keySet遍历返回所有的Map键的Set集合
        Iterator<String> names = userHashMap.keySet().iterator();
        while (names.hasNext()) {
            String name = names.next();
            User user = userHashMap.get(name);
            //字符串拼接使用StringBuilder，非线程安全效率高，使用String对象（是不可变的字符序列），JVM会创建多个String对象
            StringBuilder stringBuilder = new StringBuilder(user.getUsername());
            stringBuilder.append("-");
            stringBuilder.append(user.getPassword());
            stringBuilder.append("-");
            stringBuilder.append(user.getAblance());
            bufferedWriter.write(stringBuilder.toString());
            //每次更新一个数据后要换行
            bufferedWriter.newLine();
            bufferedWriter.flush();
        }
    } catch (IOException e) {
        e.printStackTrace();
    }finally {
        //关闭流
      .....
}
```



### 网络编程

Java实现了全平台的网络库，有一个统一的编程环境

#### 计算机网络

把分布在不同地理区域的计算机与专门的外部设备用通信线路互连成一个规模大、功能强的网络系统，从而使众多的计算机可以方便地互相传递信息、共享硬件、软件、数据信息等资源。

**网络编程的目的**：直接或间接的和其他计算机实现数据传递或交换

**两个关注点**：1.如何准确地定位网络上一-台或多台主机;定位主机上的特定的应用

​					  2.找到主机后如何可靠高效地进行数据传输



##### 网络通信要素

IP和端口号

网络通讯协议

#### 计算机之间的通信

**通信双方**

ip：定位通信双方的主机地址，ip地址是唯一的，每个人都有独立的IP

端口号：定位主机上的应用程序

**网络通信协议**

OSI参考模型：过于理想化，应用范围不广泛

TCP/IP协议：国际标准

![](/QQ截图20190928215522.png)

##### 数据的拆装

![](/QQ截图20190928215651.png)



### 数据结构与算法

**常用排序算法分配**

交换排序：冒泡排序、快速排序

插入排序：直接插入排序、希尔排序

选择排序：简单排序、堆排序

归并排序

基数排序 

#### 冒泡排序

```java
public static void main(String[] args) {
    int[] arr = new int[]{4, 2, 8, 9, 3, 1, 7, 5, 6,};
    sort(arr);
}
/**
 * 一共需要比较arr.length-1次，因为起始位置不用再次和本身自己比较，或者末尾位置也不用和自己比较
 * 假设:先由第一个数和第二个数比较，大于前一位的往后移一位，小于后一位则位置保持不变，然后进入下一轮比较
 *     比较中最大的值会放在数组中的最后一位，最大值就不必和其他数进行比较
 */
public static void sort(int[] arr) {
    //循环多少轮比较
    for (int i = 0; i < arr.length - 1; i++) {
        //j表示比较的两个数的区间，当比较的次数i时，剩余比较的次数是数arr.length()-1-i
        for (int j = 0; j < arr.length - 1 - i; j++) {
            /**
             * 如果当前位置j的数组大于后一位，开始位置互换，直接互换是无法实现的
             * 于是创建一个临时int存储，将当前位置大的数取出，后一位的数替换j位置的数组，后一位j+1的的数由临时int数替代
             * 执行多次循环，越到后面比较的次数越少
             */
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
        System.out.println("第" + (i + 1) + "次排序结果");
        for (int a = 0; a < arr.length; a++) {
            System.out.print(arr[a] + "\t");
        }
        System.out.println();
    }
    System.out.println("最后一次排序的结果");
    for (int a = 0; a < arr.length; a++) {
        System.out.print(arr[a] + "\t");
    }
}
```

运行结果

```
第1次排序结果
2	4	8	3	1	7	5	6	9	
第2次排序结果
2	4	3	1	7	5	6	8	9	
......
......
第8次排序结果
1	2	3	4	5	6	7	8	9	
最后一次排序的结果
1	2	3	4	5	6	7	8	9	
```

#### 快速排序

将数组进行二分拆分，取一个随机数比较，比它大的放在右边，比他小的放在左边，之后再次取一个随机数，循环执行

假设对**6 1 2 7 9 3 4 5 10 8**这个 10 个数进行排序，随机找一个基准数为参照，比6大的放在右边，比6小的放在左边，首次比较会得出“3 1 2 5 4 **6** 9 7 10 8”



### SpringMVC

#### 工作流程

![](/1365825529_4693.png)

1. 用户向服务器发送请求，被`DispatcherServlet`分发器捕获到
2. `DispatcherServlet`处理请求URL，调用相应的`HandlerMapping`映射器获得相应的映射信息并将`Handler`返回
3. `DispatcherServlet`调用相应的处理器适配器`HandlerAdapter`，找到对应的`Controller`后端控制器
4. 根据请求的数据和配置，Spring会做一些事情：`HttpMessageConveter`、数据转换、数据格式化、数据验证
5. 数据处理完毕Controller执行结果，向`DispatcherServlet`返回一个`ModelAndView`对象
6. `ModelAndView`对象传递给指定的`ViewResolver`视图解析器
7. `ViewResolver`视图解析器将`Model`和`View`，来渲染视图
8. `DispatcherServlet`将最终的结果返回到用户的页面上

**SpringMVC的核心就是围绕着DispatcherServlet工作的**

`HttpMessageConveter`： 将请求消息（如Json、xml等数据）转换成一个对象，将对象转换为指定的响应信息

数据转换：对请求消息进行数据转换。如String转换成Integer、Double等

数据根式化：对请求消息进行数据格式化。 如将字符串转换成格式化数字或格式化日期等

数据验证： 验证数据的有效性（长度、格式等），验证结果存储到`BindingResul`t或`Error`中



### Spring

#### IOC实现

```java
public static void main(String[] args) {
    ApplicationContext context = new ClassPathXmlApplicationContext("classpath:applicationfile.xml");
}
```

最基本的启动IOC容器的方法，加载配置文件后启动一个Spring容器 

`ClassPathXmlApplicationContext`对象返回的是`ApplicationContext`接口对象，其中还会经历过多个接口和类的传递，最终返回一个IOC容器



#### BeanFactory工厂

生产Bean的工厂，Spring容器的作用就是生产Bean并为之添加依赖

![](/BeanFactory.png)

上图所知，`ApplicationContext`的最上层父级接口是`BeanFactory`，由此可知`ApplicationContext`就可以看做事一个Bean工厂

- `ListableBeanFactory`的获取多个Bean，继承`BeanFactory`单个Bean的基础上拓展可以变成获取多个
- `HierarchicalBeanFactory`将多个`BeanFactory`分层设置为父子关系
- `AutoWiredCapableBeanFactory`自动装配Bean，`ApplicationContext`接口并没有继承该接口，但是最后有一个方法`getAutowireCapableBeanFactory（）`方法调用了该接口
- `DefaultListableBeanFactory`的父类是左右两个，大致来说，这是最强大的Bean工厂的子类，具备了自动装载个ApplicationContext的功能

ApplicationContext的三个实现

1. `ClassPathXmlApplication`：把上下文文件当成类路径资源。
2. `FileSystemXmlApplication`：从文件系统中的 XML 文件载入上下文定义信息。
3. `XmlWebApplicationContext`：从Web系统中的XML文件载入上下文定义信息。

#### IOC启动过程分析

##### ClassPathXmlApplicationContext

有多达七种构造方法，以应对不同的场景

```java
public class ClassPathXmlApplicationContext extends AbstractXmlApplicationContext {
  private Resource[] configResources;

  // 如果已经有 ApplicationContext 并需要配置成父子关系，那么调用这个构造方法（容器已存在时候只需要配置依赖关系）
  public ClassPathXmlApplicationContext(ApplicationContext parent) {
    super(parent);
  }
  ...
  /**
   * configLocations 读取配置文件的路径，可能存在多个，返回的是String类型的数组，保留的都是配置文件的路径名
   * refresh 是否需要刷新	
   * parent 已存在容器，就继承已存在容器
   */
  public ClassPathXmlApplicationContext(String[] configLocations, boolean refresh, ApplicationContext parent)
      throws BeansException {

    super(parent);
    // 根据提供的路径，处理成配置文件数组(以分号、逗号、空格、tab、换行符分割)
    setConfigLocations(configLocations);
    if (refresh) {
      refresh(); // 核心方法
    }
  }
```

#####  refresh()方法详解

```java
@Override
public void refresh() throws BeansException, IllegalStateException {
   // 来个锁，不然 refresh() 还没结束，你又来个启动或销毁容器的操作，那不就乱套了嘛
   synchronized (this.startupShutdownMonitor) {
      // 准备工作，记录下容器的启动时间、标记“已启动”状态、处理配置文件中的占位符
      prepareRefresh();

      // 这步比较关键，这步完成后，配置文件就会解析成一个个 Bean 定义，注册到 BeanFactory 中，
      // 当然，这里说的 Bean 还没有初始化，只是配置信息都提取出来了，
      // 注册也只是将这些信息都保存到了注册中心(说到底核心是一个 beanName-> beanDefinition 的 map)
      ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();
 // 设置 BeanFactory 的类加载器，添加几个 BeanPostProcessor，手动注册几个特殊的 bean
      // 这块待会会展开说
      prepareBeanFactory(beanFactory);

      try {
         // 【这里需要知道 BeanFactoryPostProcessor 这个知识点，Bean 如果实现了此接口，
         // 那么在容器初始化以后，Spring 会负责调用里面的 postProcessBeanFactory 方法。】

         // 这里是提供给子类的扩展点，到这里的时候，所有的 Bean 都加载、注册完成了，但是都还没有初始化
         // 具体的子类可以在这步的时候添加一些特殊的 BeanFactoryPostProcessor 的实现类或做点什么事
         postProcessBeanFactory(beanFactory);
         // 调用 BeanFactoryPostProcessor 各个实现类的 postProcessBeanFactory(factory) 方法
         invokeBeanFactoryPostProcessors(beanFactory);
       	 ......
         //注册一些IOC容器需要的相关组件,监听器、广播器等
         ......
```



#### 将一个类声明为Spring的 bean 的注解

我们一般使用 `@Autowired` 注解自动装配 bean，要想把类标识成可用于 `@Autowired` 注解自动装配的 bean 的类,采用以下注解可实现：

- `@Component` ：通用的注解，可标注任意类为 `Spring` 组件。如果一个Bean不知道属于哪个层，可以使用`@Component` 注解标注。
- `@Repository` : 对应持久层即 Dao 层，主要用于数据库相关操作。
- `@Service` : 对应服务层，主要涉及一些复杂的逻辑，需要用到 Dao层。
- `@Controller` : 对应 Spring MVC 控制层，主要用于接受用户请求并调用 Service 层返回数据给前端页面。



#### Spring 事务中的隔离级别有哪几种?

- **TransactionDefinition.ISOLATION_DEFAULT:** 使用后端数据库**默认的隔离级别**，Mysql 默认采用的 REPEATABLE_READ隔离级别 Oracle 默认采用的 READ_COMMITTED隔离级别.
- **TransactionDefinition.ISOLATION_READ_UNCOMMITTED:** 最低的隔离级别（读未提交），允许读取尚未提交的数据变更，**可能会导致脏读、幻读或不可重复读**
- **TransactionDefinition.ISOLATION_READ_COMMITTED:** 允许读取并发事务已经提交的数据（读已提交），**可以阻止脏读，但是幻读或不可重复读仍有可能发生**
- **TransactionDefinition.ISOLATION_REPEATABLE_READ:** 对同一字段的多次读取结果都是一致的（可重复读），除非数据是被本身事务自己所修改，**可以阻止脏读和不可重复读，但幻读仍有可能发生。**
- **TransactionDefinition.ISOLATION_SERIALIZABLE:** 最高的隔离级别（可序列化），完全服从ACID的隔离级别。所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，**该级别可以防止脏读、不可重复读以及幻读**。但是这将严重影响程序的性能。通常情况下也不会用到该级别。



#### Spring事务

##### 1. 编程式事务管理

写在代码中硬编码的，可以作用到代码块，是侵入式的

##### 2.声明式事务管理

声明在配置文件中，对代码无侵入性，只能作用到方法级别，是建立在切面上的，声明式事务又分为基于XML和注解式



#### Spring读取配置文件方式

1.  `@Value("${property}")`的方式读取	（不推荐）

2. `@ConfigurationProperties`读取Bean名字

   ```yml
   library:
     location: 湖北武汉加油中国加油
     books:
       - name: 天才基本法
         description: 二十二岁的林朝夕在父亲确诊阿尔茨海默病这天，得知自己暗恋多年的校园男神裴之即将出国深造的消息——对方考取的学校，恰是父亲当年为她放弃的那所。
       - name: 时间的秩序
         description: 为什么我们记得过去，而非未来？时间“流逝”意味着什么？是我们存在于时间之内，还是时间存在于我们之中？卡洛·罗韦利用诗意的文字，邀请我们思考这一亘古难题——时间的本质。
       - name: 了不起的我
         description: 如何养成一个新习惯？如何让心智变得更成熟？如何拥有高质量的关系？ 如何走出人生的艰难时刻？
   ```

   ```java
   @Component
   @ConfigurationProperties(prefix = "library")	// yml中配置的Bean的名字
   @Setter
   @Getter
   @ToString
   class LibraryProperties {
       private String location;
       private List<Book> books;
       static class Book {
           String name;
           String description;
       }
   }
   ```

   这时候就可以是当做Spring的Bean交由IOC容器管理

3. `@PropertySource`读取的指定的配置文件，@PropertySource("classpath:website.properties")



#### SpringBoot读取配置文件顺序

![](67.jpg)



#### SpringBoot异常处理

加上`@ControllerAdvice`或`@RestControllerAdvice`注解这个类就成为了全局异常处理类

```java
@ControllerAdvice(assignableTypes = {ExceptionController.class})
@ResponseBody
public class GlobalExceptionHandler {

    ErrorResponse illegalArgumentResponse = new ErrorResponse(new IllegalArgumentException("参数错误!"));
    ErrorResponse resourseNotFoundResponse = new ErrorResponse(new ResourceNotFoundException("Sorry, the resourse not found!"));

    @ExceptionHandler(value = Exception.class)// 拦截所有异常, 这里只是为了演示，一般情况下一个方法特定处理一种异常
    public ResponseEntity<ErrorResponse> exceptionHandler(Exception e) {

        if (e instanceof IllegalArgumentException) {
            return ResponseEntity.status(400).body(illegalArgumentResponse);
        } else if (e instanceof ResourceNotFoundException) {
            return ResponseEntity.status(404).body(resourseNotFoundResponse);
        }
        return null;
    }
}
```

RestFul风格的

```java
/**
 * 处理Shiro相关异常
 *
 * @param e
 * @return
 */
@ResponseStatus(HttpStatus.UNAUTHORIZED)
@ExceptionHandler(value = ShiroException.class)
public String handle(ShiroException e) {
    log.error("授权认证异常---------{}");
    return ResultUtil.error("401", e.getMessage());
}
```



#### SpringBoot拦截器和过滤器

拦截器和过滤器在项目都是面向AOP切面编程 的体现

- 过滤器（Filter）：当你有一堆东西的时候，你只希望选择符合你要求的某一些东西。定义这些要求的工具，就是过滤器。
- 拦截器（Interceptor）：在一个流程正在进行的时候，你希望干预它的进展，甚至终止它进行，这是拦截器做的事情。

拦截器：需要实现 `javax.Servlet.Filter` 接口，然后重写里面的 3 个方法

拦截的主要业务逻辑是写在doFilter中

```java
public interface Filter {
  
   //初始化过滤器后执行的操作
    default void init(FilterConfig filterConfig) throws ServletException {
    }
   // 对请求进行过滤
    void doFilter(ServletRequest var1, ServletResponse var2, FilterChain var3) throws IOException, ServletException;
   // 销毁过滤器后执行的操作，主要用户对某些资源的回收
    default void destroy() {
    }
}
```

过滤器：实现 **org.springframework.web.servlet.HandlerInterceptor**接口或继承

比较常用的：**HandlerInterceptorAdapter**

```java
public abstract class HandlerInterceptorAdapter implements AsyncHandlerInterceptor {
    public HandlerInterceptorAdapter() {
    }

    // 处理前回调方法，如登录校验，打印日志，handler一般为相应的处理器或拦截器，true继续流程，false会终端执行
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }

    // 后处理回到方法，但在渲染视图之前
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }

    // 请求处理完毕后执行，视图渲染完毕后回调，性能监控计算执行时间，
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }

    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    }
}
```

在SpringBoot工程中默认是会拦截所有资源的，Spring工程需要配置视图解析器，`WebMvcConfigurer `是SpringBoot工程中的过滤器，可以用于放行静态资源和对指定资源进行过滤



#### SpringBoot常用注解

- @SpringBootApplication启动器类
- `@EnableAutoConfiguration`：启用 SpringBoot 的自动配置机制
- `@ComponentScan`： 扫描被`@Component` (`@Service`,`@Controller`)注解的 bean，注解默认会扫描该类所在的包下所有的类。
- `@Configuration`：允许在 Spring 上下文中注册额外的 bean 或导入其他配置类
- `@Component`：放在类上，把普通类实例化到spring容器中。
- `@ConfigurationProperties`读取配置文件
- `@Value`读取配置文件中的参数的值



#### Spring涉及的几种设计模式

- 工厂模式： IOC容器可以理解是一个Bean工厂，不必知道工厂是如何创建对象，工厂代工生产，只需要对齐进行相关配置即可  
- 单例模式：线程池，连接池，日志对象等，只需要一个实例对象，完成都是相同的事情
- 代理模式：AOP是基于动态代理
- 适配器模式：把一个接口变成客户需要的另一个接口



### Mybatis

#### #{}和${}

#{}是变量占位符，字符串替换， ${}是参数占位符，Mybatis 会将 sql 中的`#{}`替换为?号，在 sql 执行前会使用 PreparedStatement 的参数设置方法，按序给 sql 的?号占位符设置参数值

#### xml常用标签

 select|insert|updae|delete 

`<resultMap>`、`<parameterMap>`、`<sql>`、`<include>`、`<selectKey>`

`trim|where|set|foreach|if|choose|when|otherwise|bind`等



Mybatis的Sql封装对象方式

第一种是使用`<resultMap>`标签，逐一定义列名和对象属性名之间的映射关系

第二种是使用 sql 列的别名功能，将列别名书写为对象属性名，比如 T_NAME AS NAME，对象属性名一般是 name，小写，但是列名不区分大小写

#### Mybatis一对一

第一种方式：嵌套结果集，resultMap中的association包含另一个实体对象

```xml
   <!--
           方式一：嵌套结果：使用嵌套结果映射来处理重复的联合结果的子集
                   封装联表查询的数据(去除重复的数据)
           select * from classes c, teacher t where c.tid=t.tid and c.tid=#{tid}
       -->
      <select id=  "getClasses"` `resultMap=  "getClassesMap"` `parameterType=  "int"  >
          select * from classes c ,teacher t
              where c.tid=t.tid and c.tid=#{tid}
      </select>
      <resultMap type=  "one.to.one.Classes"` `id=  "getClassesMap"  >
          <id column=  "cid"` `property=  "cid"  />
          <result column=  "cname"` `property=  "cname"  />
          <association property=  "teacher"` `javaType=  "one.to.one.Teacher"  >
              <id column=  "tid"` `property=  "tid"  ></id>
              <result column=  "tname"` `property=  "tname"  />
          </association>
      </resultMap>
```

第二种方式：在resultMap的collection中用select标签执行一个查询

```xml
<resultMap type=  "one.to.one.Classes"` `id=  "getClassesMap2"  >
          <id column=  "cid"` `property=  "cid"  />
          <result column=  "cname"` `property=  "cname"  />
          <collection property=  "teacher"` `column=  "tid"` `select=  "getTeacherCollection"  >
          </collection>
      </resultMap>
      <select id=  "getTeacherCollection"` `resultType=  "one.to.one.Teacher"  >
          select tid tid,tname tname from teacher where tid=#{tid}
      </select>
```





### MySQL

#### 索引

索引是提高数据库性能的常用方法，它可以令数据库服务器以比没有索引快得多的速度检索特定的行，尤其是在查询语句当中包含有`MAX(), MIN()和ORDERBY`这些命令的时候，性能提高更为明显

索引是依靠某些**数据结构**和**算法**来组织数据，最终引导用户快速检索出所需要的数据。

##### 索引的本质

**通过不断地缩小想要获取`数据的范围`来筛选出最终想要的结果，同时把`随机`的事件变成`顺序`的事件，也就是说，有了这种索引机制，我们可以总是用同一种查找方式来锁定数据。**

##### MySQL中的页

mysql中和磁盘交互的最小单位称为页，页是mysql内部定义的一种**数据结构**，默认为16kb，相当于4个磁盘块，也就是说mysql**每次从磁盘中读取一次数据是16KB，要么不读取，要读取就是16KB，此值可以修改的**



##### 数据检索过程

MySQL从磁盘读取IO次数需要性能开销和时间，需要良好的数据结构和检索算法来提高mysql的查询速度

1. 需要一种**数据存储结构**：当从磁盘中检索数据的时候能，够减少磁盘的io次数，最好能够降低到一个稳定的常量值
2. 需要一种**检索算法**：当从磁盘中读取磁盘块的数据之后，这些块中可能包含多条记录，这些记录被加载到内存中，那么需要一种算法能够快速从内存多条记录中快速检索出目标数据

  ##### 有以下几种算法

- 循环遍历查找

  从一组无序的数组中查找结果，从头遍历到尾， n条数据，时间复杂度为O(n)，最快需要1次，最坏的情况需要n次，查询效率不稳定 

- 二分查找法

  也叫拆半查找法，从一个有序的数组中快速定义一个需要查找的数据

  [1,2,3,4,5,6,7,8,9]

  第1次查找：[1,2,3,4,5,6,7,8,9]中间位置值为5，9>5，将查找范围缩小至5右边的部分：[6、7、8、9]

  第2次查找：[6、7、8、9]中间值为8，9>8 ，将范围缩小至8右边部分：[9]

  第3次查找：在[9]中查找9，找到了。

  这样三次就确定了数据的位置，循环遍历的话则需要9次





1. ##### 普通索引

    普通索引(由关键字KEY或INDEX定义的索引)的唯一任务是加快对数据的访问速度。因此，应该只为那些最经常出现在查询条件(WHERE column = …)或排序条件(ORDER BY column)中的数据列创建索引。只要有可能，就应该选择一个数据最整齐、最紧凑的数据列(如一个整数类型的数据列)来创建索引

   普通索引可能会存在相同的值

2. ##### 唯一索引

   如果能确定某个数据列将只包含彼此**各不相同**的值，在为这个数据列创建索引的时候就应该用关键字`UNIQUE`把它定义为一个**唯一索引**，好处：是唯一不重复的值的索引，MySQL简化了这个索引之间的工作，当插入新的数据的时候存在重复，就不执行插入操作

3. ##### 主索引

   为主键字段创建索引，关键字是`PRIMARY`

4. ##### 外键索引

   外键字段定义一个，外键约束条件，MySQL就会定义一个内部索引来帮助自己以最有效率的方式去管理和使用外键约束条件

5. ##### 复合索引

   索引可以覆盖多个数据列，如像`INDEX(columnA, columnB)`索引

```mysql
/*根据Id创建索引的两种方式*/
create index idx1 on test1 (id);

create unique index idx2 on test1(name);

/* 查看索引 */
show index from test1;

/*删除索引*/
drop index idx1 on test1;
```





#### 表锁

 **MyISAM 和 InnoDB 实现的锁机制不一样！ MyISAM 使用的是表锁， 而 InnoDB实现的是行锁。**

由于MyISAM写进程优先获得锁，使得读锁请求靠后等待队列。不仅如此，即使读请求先到锁等待队列，写请求后 到，写锁也会插到读锁请求之前！**这是因为MySQL认为写请求一般比读请求要重要**。

**INNODB的行锁是基于索引实现**，如果不通过索引访问数据，Innodb会使用表锁

表级锁更适合以**查询**为主，只有少量按索引条件更新数据的应用。

行级锁更适合于有**大量按索引条件**并发**更新少量不同数据**，同时**又并发查询**。因为只锁定要操作的行， 所以可以多个线程同时操作不同的行（只要不操作其他线程已经锁定的行）。



#### delimiter 

告诉mysql解释器，该段命令是否已经结束了，mysql是否可以执行了。默认情况下，**delimiter**是分号;。在命令行客户端中，如果有一行命令以分号结束，那么回车后，mysql将会执行该命令

其中DELIMITER 定好结束符为"$$", 然后最后又定义为";", MYSQL的默认结束符为";". 

```mysql

mysql> delimiter // 
mysql> CREATE PROCEDURE simpleproc (OUT param1 INT) 
-> BEGIN 
-> SELECT COUNT(*) INTO param1 FROM t; 
-> END; 
-> // 
Query OK, 0 rows affected (0.00 sec) 
```



#### 事务

#### ADID

1. **原子性（Atomicity）：** 事务是最小的执行单位，不允许分割。事务的原子性确保动作要么全部完成，要么完全不起作用；
2. **一致性（Consistency）：** 执行事务后，数据库从一个正确的状态变化到另一个正确的状态；
3. **隔离性（Isolation）：** 并发访问数据库时，一个用户的事务不被其他事务所干扰，各并发事务之间数据库是独立的；
4. **持久性（Durability）：** 一个事务被提交之后。它对数据库中数据的改变是持久的，即使数据库发生故障也不应该对其有任何影响。

#### 并发事务的问题

1. **脏读**：事务A修改了共享数据但未提交到数据库，事务B读取共享数据未提交的数据，但实际上事务B读取的数据结果和数据库中的结果不一致，这个数据就是“脏数据”

2. **丢失已修改**：事务A修改共享数据，事务B同时也对共享数据修改，这时候事务A的结果不存在，最终结果是事务B的结果，

   A = 10+1； B = 10-1，最终结果是9 A的事务无效

3. **不可重复读**：事务A多次读取同一个数据，同时事务B对该数据进行了修改，导致A读取的多个结果会不一致 （**重点是修改**）

4. **幻读**：事务A读取指定行数的数据，事务B在该行数间插入了新的数据，事务A读取的数据查询出原本不存在的数据，似乎凭空幻觉出现的一样（重点是新增）

#### 数据库隔离级别

针对并发事务的问题，数据库有对应的隔离级别

 **SQL 标准定义了四个隔离级别：**

- **READ-UNCOMMITTED(读取未提交)：** 最低的隔离级别，允许读取尚未提交的数据变更，**可能会导致脏读、幻读或不可重复读**。
- **READ-COMMITTED(读取已提交)：** 允许读取并发事务已经提交的数据，**可以阻止脏读，但是幻读或不可重复读仍有可能发生**。
- **REPEATABLE-READ(可重复读)：** 对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，**可以阻止脏读和不可重复读，但幻读仍有可能发生**。
- **SERIALIZABLE(可串行化)：** 最高的隔离级别，完全服从ACID的隔离级别。所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，**该级别可以防止脏读、不可重复读以及幻读**。

------

| 隔离级别         | 脏读 | 不可重复读 | 幻影读 |
| ---------------- | ---- | ---------- | ------ |
| READ-UNCOMMITTED | √    | √          | √      |
| READ-COMMITTED   | ×    | √          | √      |
| REPEATABLE-READ  | ×    | ×          | √      |
| SERIALIZABLE     | ×    | ×          | ×      |





#### PROCEDURE 

创建一个存储过程





### 通用mapper

#### 1. 前言

​	使用MyBatis的开发者，大多数都会遇到一个问题，就是要写大量的SQL在xml文件中，除了特殊的业务逻辑SQL之外，还有大量结构类似的增删改查SQL。而且，当数据库表结构改动时，对应的所有SQL以及实体类都需要更改

#### 2. 通用mapper简介

​	通用Mapper就是为了解决单表增删改查，基于Mybatis的插件。开发人员不需要编写SQL，不需要在DAO中增加方法，只要写好实体类，就能支持相应的增删改查方法。

使用原生Mybatis的一些痛点：

1. mapper.xml文件里有大量的sql,当数据库表字段变动，配置文件就要修改
2. **需要自己实现sq|分页**，`select * from table where... limit 1,3`自己手写分页，除了传参page、pageSize, 还需要返回条目总数count.
3. **数据库可移植性差**:如果项目更换数据库，比如oracle-->mysql, mapper.xml中的sql要重新写， 因为Orace的PLSQL和mysg!支持的函数是不同的。
4. **生成的代码量过大。**
5. **批量操作，批量插入，批量更新，需要自写。**



####  

#### 3. 通用mapper

Spring作为时下最流行的Java框架，大多数框架都可以和或者都应该和他进行集成整合，通用mapper的三种使用方式：纯Java的方式、Spring集成、SpringBoot集成

原生Mybatis和Spring集成的时候，需要有多个依赖：Mybatis、Mybatis-Spring整合包、Spring-context、Spring-jdbc、Spring-tx包

当使用通用mapper的时候，需要引入这个依赖

```xml
<dependency>
    <groupId>tk.mybatis</groupId>
    <artifactId>mapper</artifactId>
    <version>4.1.4</version>
</dependency>
```

Mybatis和Spring整合，需要扫描Dao层的Mapper类，只需要改变一下配置文件中的`org`为`tk.`使用通用Mapper文件的扫描方式





### HttpServletRequest和HttpServletResponse详解

Web服务器收到一个http请求，会针对每个请求创建一个`HttpServletRequest`和`HttpServletResponse`对象，向客户端发送数据找`HttpServletResponse`,从客户端取数据找`HttpServletRequest.`

#### HttpServletRequest

继承自`ServletRequest`客户端浏览器发出的请求被封装成为一个`HttpServletRequest`对象。所有的信息包括**请求的地址，请求的参数，提交的数据，上传的文件客户端的ip甚至客户端操作系统等信息**都包含在其内。

一个 HTTP 请求包含以下三部分：

**a.**请求地址(URL)

**b.请求头**(Request headers)

**c.实体数据**(Entity body)

```properties
POST /examples/default.jsp HTTP/1.1	
Accept: text/plain; text/html
Accept-Language: en-gb
Connection: Keep-Alive
Host: localhost
User-Agent: Mozilla/4.0 (compatible; MSIE 4.01; Windows 98)
Content-Length: 33
Content-Type: application/x-www-form-urlencoded
Accept-Encoding: gzip, deflate
lastName=Franks&firstName=Michael
```

 HTTP 支持的方法包括，GET、POST、HEAD、OPTIONS、PUT、DELETE 和 TRACE。互联网应用中最常用的是 GET 和 POST

##### 常用方法

**1.获得客户机信息**

getRequestURL	方法返回客户端发出请求时的完整URL。

getRequestURI	 方法返回请求行中的资源名部分。

getQueryString 	方法返回请求行中的参数部分。

getRemoteAddr	方法返回发出请求的客户机的IP地址

getRemoteHost	方法返回发出请求的客户机的完整主机名

getRemotePort	 方法返回客户机所使用的网络端口号

getLocalAddr	    方法返回WEB服务器的IP地址。

getLocalName	  方法返回WEB服务器的主机名

getMethod			得到客户机请求方式	

getServerPath	获取请求的文件的路径

 **2.获得客户机请求头**

getHeader(string name)方法 
getHeaders(String name)方法 
getHeaderNames方法 

**3. 获得客户机请求参数(客户端提交的数据)**
getParameter(name)方法 									获取请求中的参数，该参数是由name指定的
getParameterValues（String name）方法 		获取指定名称参数的所有值数组。它适用于一个参数名对应多个值的情

​																			 况。如**页面表单中的复选框，多选列表提交的值**。

getParameterNames方法 									返回一个包含请求消息中的所有参数名的**Enumeration																			**对象。通过遍历这个**Enumeration**对象，就可以获取请求消息中所有的参数名。

getCharacterEncoding()										返回请求的字符编码方式

getAttributeNames()											 返回当前请求的所有属性的名字集合赋值:setAttribute()

getAttribute(String name) 								   返回name指定的属性值

getsession()															返回和客户端相关的session，如果没有给客户端分配session，则返回

​																				 null

getParameterMap():											 返回一个保存了请求消息中的所有参数名和值的Map对象。Map对象的

​																				key是字符串类型的参数名，value是这个参数所对应的Object类型的值数

​																				组

RequestDispatcher.forward 							方法的请求转发过程结束后，浏览器地址栏保持初始的**URL地址不变**。方

​																			  法在服务器端内部将请求转发给另外一个资源，**浏览器只知道发出了请求**

​																			  **并得到了响应结果，并不知道在服务器程序内部发生了转发行为**。

request.setCharacterEncoding("utf-8");		 设置请求的编码格式为UTF-8

getReader() 														获取请求体的数据流

getInputStream() 											  获取请求的输入流中的数据



#### HttpServletResponse

继承了`ServletResponse`接口，主要功能是设置[HTTP状态码](http://baike.baidu.com/view/1790469.htm)和管理Cookie。`HttpServletResponse`对象代表服务器的响应。这个对象中封装了**向客户端发送数据、发送响应头，发送响应状态码**的方法

HttpServletResponse对象可以向客户端发送三种类型的数据:

**a**.**响应头(**Response headers**)

**b.状态码**(**Protocol—Status code—Description**)**

**c.实体数据**(**Entity body **)

```properties
HTTP/1.1 200 OK
Server: Microsoft-IIS/4.0
Date: Mon, 5 Jan 2004 13:13:33 GMT
Content-Type: text/html
Last-Modified: Mon, 5 Jan 2004 13:13:12 GMT
Content-Length: 112
<html><head><title>HTTP Response Example</title></head>....</html>
```

##### 常用方法

addHeader(String name,String value)  		将指定的名字和值加入到响应的头信息中

encodeURL(String url)  									编码指定的URL

sendError(int sc)  											 使用指定状态码发送一个错误到客户端

setDateHeader(String name,long date )	  将给出的名字和日期设置响应的头部

setHeader(String name,String value) 		  将给出的名字和值设置响应的头部

setStatus(int sc) 											   给当前响应设置状态码

HttpServletResponse.sendRedirect 			 方法对浏览器的请求直接作出响应，响应的结果就是告诉浏览器去重新发出对另外一个URL的访问请求；方法调用者与被调用者使用各自的request对象和response对象，它们属于两个独立的访问请求和响应过程。



### EhCache 

EhCache 是一个`纯Java`的进程内`缓存框架`，具有`内存`和`磁盘`存储，缓存加载器,缓存扩展,缓存异常处理程序,一个gzip缓存servlet过滤器,支持REST和SOAP api等特点。

#### 特性

- 快速、简单
- 多种`缓存策略` 
- 缓存数据有两级：`内存和磁盘`，因此无需担心`容量问题` 
- 缓存数据会在虚拟机`重启`的过程中`写入磁盘` 

- 可以通过`RMI`、可插入API等方式进行`分布式缓存` 

- 具有缓存和缓存管理器的侦听接口

- 支持`多`缓存管理器`实例`，以及一个实例的`多个缓存区域` 

- 提供`Hibernate`的缓存实现

#### 集成

Ehcache对分布式缓存的支持性不太好，因此需要经常是搭配Redis一起使用，可以和Mybatis和shiro集成

#### 持久化

遇到重启的时候，持久化到磁盘的存储可以`复原数据`，根据需要将缓存刷到磁盘。将缓存条目`刷到磁盘`的操作可以通过`cache.fiush`方法执行,这大大方便了ehcache的使用

#### 和redis的比较

ehcache直接在jvm虚拟机中缓存，`速度快`，效率高；但是缓存`共享麻烦`，集群分布式应用不方便。

redis是通过socket访问到缓存服务，效率比ecache低，比数据库要快很多，
 处理集群和分布式缓存方便，有成熟的方案。如果是`单个应用`或者对`缓存访问要求很高`的应用，用ehcache。如果是大型系统，存在缓存共享、分布式部署、`缓存内容很大`的，建议用redis。



#### Maven依赖

```xml
<dependency>
    <groupId>net.sf.ehcache</groupId>
    <artifactId>ehcache</artifactId>
    <version>2.10.2</version>
</dependency>
```

#### 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ehcache name="jyr">
    <!-- 磁盘缓存位置 -->
    <diskStore path="java.io.tmpdir"/>
    <!-- 默认缓存 -->
    <defaultCache
            maxEntriesLocalHeap="1000"
            eternal="false"
            timeToIdleSeconds="3600"
            timeToLiveSeconds="3600"
            overflowToDisk="false">
    </defaultCache>
</ehcache>
   
```



### Socket网络编程

二进制+ip+端口通讯的一种方式

几乎所有的编程语言都有Socket网络编程，之间也是可以互通的，我们所说的网络编程一班是指的是**TCP**协议

**tcp**---面向连接，三次握手成功才能通讯，字节流进行传输，效率低于udp但是可靠
**udp**----无连接，不管你在不在，都给你发请求，不会建立连接，不可靠，限制64K

Http协议就是基于TCP协议



#### TCP三次握手

简单理解

![](/QQ截图20200413133240.png)

UDP是面向无连接的，不管有没有接受端，都会发出去，数据的大小有64k的限制，是不安全的

TCP是面向连接的，必须客户端和服务器建立起连接，有三次握手和四次分手的协议，是相对比较安全的数据传输协议，在涉及到传输的数据安全的时候，应使用TCP，TCP的传输大小没有限制，效率相对UDP较慢	



#### Demo

UDPServer 端

关键字ServerSocket，byte[]缓冲区，涉及到文件流的传输InputStream，OutputStream

```java
public class SocketServer {
    public static void main(String[] args) throws IOException {
        System.err.println("TCP服务启动了");
        // 服务端ServerSocket
        ServerSocket socket = new ServerSocket(8080);
        try {
            // 消息阻塞
            Socket accept = socket.accept();
            // 从输入流中读取内容
            InputStream stream = accept.getInputStream();
            byte[] bytes = new byte[1024];
            int length = stream.read(bytes);
            String result = new String(bytes, 0, length);
            System.err.println("服务端接收到客户端的消息了：->" + result);

            // 响应给客户端的消息
            OutputStream outputStream = accept.getOutputStream();
            PrintWriter printWriter = new PrintWriter(outputStream);
            printWriter.print("服务器已经接受到信息了");
            printWriter.flush();

            // 关闭输出流
            accept.shutdownOutput();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            socket.close();
        }
    }
}

```

**UDPClient**

客户端对应的是Socket

```java
public class Client {
    public static void main(String[] args) throws IOException {
        // 服务端对应的是Socket
        Socket socket = new Socket("127.0.0.1", 8080);
        try {
            // 客户端要想服务器发送请求，需要输出流
            OutputStream outputStream = socket.getOutputStream();
            String msg = "哈哈哈哈哈";
            outputStream.write(msg.getBytes());
            System.err.println("客户端发送消息完毕");

            // 读取服务器的反馈
            InputStream inputStream = socket.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String result = reader.readLine();
            System.out.println("服务器的响应结果是：-->" + result);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            socket.close();
        }
    }
}
```



### NIO和BIO

Java中的IO都是依赖操作系统内核进行的，我们程序中的IO读写其实调用的是操作系统内核中的read&write两大系统调用。

BIO中需要多线程才能进行并发操作，在并发环境下，这意味着一个请求要对应一个线程，对服务端是极大的性能损耗，开启一个闲置的线程等待客户端发送请求，如果客户端

```java
public class BIOMysqlServer {
    static byte[] bs = new byte[1024];
    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(8080);
            while (true) {
                System.out.println("Ready to conn");
                // 阻塞，程序放弃CPU，不会继续执行下去，accept阻塞了，线程会一直等待
                // accept()会阻塞，read()也会阻塞
                // BIO会将当前服务端Socket阻塞，只有对应的一个客户端能连接，其他的请求都不能访问——不支持高并发
                // 改造：将当前执行的程序放入到线程中，在阻塞的时候只阻塞当前线程，其他的请求可以正常访问————并发需要多线程支持
                Socket clientSocket = serverSocket.accept();
                System.out.println("conn successful");

                clientSocket.getInputStream().read(bs);
                System.out.println("this is data from client: ->" + new String(bs));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

 

#### NIO

Redis是单线程的，单线程处理高并发，可以说Redis是基于NIO的，



#### Java的Future机制

创建线程的方式，继承Thread，实现Runable

这两种方式都有一个缺陷就是：**在执行完任务之后无法获取执行结果。**

**5个方法**：

![](QQ截图20200727194542.png)

`get()`方法用户返回计算结果，如果计算还没有完成，则在get的时候会进行阻塞，直到获取到结果为止。

`get(long timeout, TimeUnit unit)`方法的耐心是有限的，如果在指定时间内没有完成计算，则会抛出`TimeoutException`.

```java
.get(2, TimeUnit.SECONDS)
```

`isDone()`方法用于判断当前Future是否执行完成。

`cancel`取消当前线程的执行。参数表示是否在线程执行的过程中阻断。

`isCancelled()`判断当前task是否被取消。



### 文件上传案例

![](QQ截图20200913121121.png)



- 