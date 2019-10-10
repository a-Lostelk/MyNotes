---
typora-root-url: images
---

## 					面向对象语言（JVM）篇

### JVM中Long和double的原子性

java中基本类型中，long和double的长度都是8个字节，32位（4字节）处理器对其读写操作无法一次完成

```java
public class LongAtomTest implements Runnable {
    private static long field = 0;
    private volatile long value;
    public long getValue() {
        return value;
    }
    public void setValue(long value) {
        this.value = value;
    }
    //传入的值赋值给LongAtom对象本身
    public LongAtomTest(long value) {
        this.setValue(value);
    }

    //执行赋值操作
    @Override
    public void run() {
        int i = 0;
        while (i < 100000) {
            LongAtomTest.field = this.getValue();
            i++;
            long temp = LongAtomTest.field;
            if (temp != 1L && temp != -1L) {
                System.out.println("出现错误结果" + temp);
                System.exit(0);
            }
        }
        System.out.println("运行正确");
    }

    public static void main(String[] args) throws InterruptedException {
        // 获取并打印当前JVM是32位还是64位的
        String arch = System.getProperty("sun.arch.data.model");
        System.out.println(arch+"-bit");
        //如果是原子性操作，不断进行+1和-1操作，fieled的值应该是+1 或是 -1
        LongAtomTest t1 = new LongAtomTest(1);
        LongAtomTest t2 = new LongAtomTest(-1);
        Thread T1 = new Thread(t1);
        Thread T2 = new Thread(t2);
        T1.start();
        T2.start();
        T1.join();
        T2.join();
    }
}
```

***在32位虚拟机机器侠，JVM对long的操作非原子操作***

***而在64位的虚拟机下，操作是原子性的***



#### JVM内存模型中的原子操作

1. lock:将一个变量标识为被一个线程独占状态

2. unclock:将一个变量从独占状态释放出来，
3. 释放后的变量才可以被其他线程锁定
4. read:将一个变量的值从主内存传输到工作内存中，以便随后的load操作
5. load:把read操作从主内存中得到的变量值放入工作内存的变量的副本中
6. use:把工作内存中的一个变量的值传给执行引擎，每当虚拟机遇到一个使用到变量的指令时都会使用该指令
7. assign:把一个从执行引擎接收到的值赋给工作内存中的变量，每当虚拟机遇到一个给变量赋值的指令时，都要使用该操作
8. store:把工作内存中的一个变量的值传递给主内存，以便随后的write操作
9. write:把store操作从工作内存中得到的变量的值写到主内存中的变量

*****

对于32位操作系统来说，单次次操作能处理的最长长度为32bit，而long类型8字节64bit，所以对long的读写都要两条指令才能完成（即每次读写64bit中的32bit）





### Java内存区域

根据 JVM 规范，JVM 内存共分为**虚拟机栈、堆、方法区、程序计数器、本地方法栈**五个部分。

![](/820406-20160326200119386-756216654.png)

#### 堆

堆是Java虚拟机内存中最大的区域，进程中的线程共享该进程的堆内存，堆中主要存放的是对象实例，垃圾回收GC主要回收的也是堆中的实例，对象和数组等分配的内存地址都是在对内存中

GC垃圾回收机制采取的是**分代垃圾回收算法**，堆内存中的对象分为新生代老年代，1.7之前永久代在之后被**元空间**替代，元空间是使用的物理内存，受本机物理内存影响 ，元空间不在虚拟机中，直接在物理内存中



#### 程序计数器（PC寄存器 ）

**线程私有的**，字节码解释器通过程序计数器中来决定需要执行的字节码、分支、循环、跳转和异常处理等功能，作用于线程之中是每次线程之间切换之后能恢复到之前执行的位置

**另外，程序计数器是唯一一个不会内存溢出的区域**



#### Java虚拟机栈

**线程私有的**，Java内存可以这样划分：堆内存（heap）和栈内存（Stack），栈就是虚拟机栈，虚拟机栈是由一个个栈帧组成的，每个栈帧中都拥有：局部变量表、操作数栈、动态链接、方法出口信息。	

每个线程都有对应的Java虚拟机栈，生命周期是和线程一样的

**栈帧：**自适应大小，超出了JVM允许的范围会跑出异常，栈帧中包含**局部变量表**（基本数据类型和对象引用），操作数栈



#### 本地方法栈

**虚拟机栈为虚拟机执行 Java 方法 （也就是字节码）服务，而本地方法栈则为虚拟机使用到的 Native 方法服务。** 在 HotSpot 虚拟机中和 Java 虚拟机栈合二为一（一般不需要关注本地方法栈）



#### 方法区

和堆一样是各个线程共享的内存区域，**存储的已被Java虚拟机加载的类信息、静态变量、常量、编译器编译的即时数据（类的接口、版本，类信息等），JVM规范中将方法区和堆内存区分开来**，在Java类运行的时候进入到方法区的对象一般不会被GC垃圾回收机制回收（已经加载的完整项目被回收部分对象会发生不可预期错误），但也不是说永久保存

##### 常量池

JDK7之前是放在方法区中，之后将常量池从方法区中移出来，**在虚拟机堆内存中开辟了一块区域专门用来存放常量池**，

String str = "abc";	//此时的str对象就是存放在常量池中，在下次调用的时候就直接从常量池中取出不用再次new出对象

![](/JVM常量池中的内容.jpg)



#### 直接内存

并不是虚拟机运行时所管理控制的区域，配合jdk1.4中引入的**NIO**使用，NIO是基于**通道**和**缓冲区**的IO方式，在使用中可能会随之实际情况需要使用的内存会随之改变，直接内存由真实机的总内存大小和处理器来决定，直接内存的分配不会受到虚拟机中Java堆的限制

