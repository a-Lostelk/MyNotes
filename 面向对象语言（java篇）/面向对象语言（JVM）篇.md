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

#### 堆

堆是Java内存中最大的区域

#### 程序计数器

字节码解释器通过程序计数器中来决定需要执行的字节码、分支、循环、跳转和异常处理等功能，作用于线程之中是每次线程之间切换之后能恢复到之前执行的位置

**另外，程序计数器是唯一一个不会内存溢出的区域**

#### Java虚拟机栈



