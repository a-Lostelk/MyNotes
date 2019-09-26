---
typora-root-url: images
---

## 				Java设计模式

#### 单例模式

**单例模式（Singleton Pattern）**是 Java 中最简单的设计模式之一。这种类型的设计模式属于**创建型模式**，它提供了一种创建对象的最佳方式。

这种模式涉及到一个单一的类，该类负责创建自己的对象，同时确保只有单个对象被创建。这个类提供了一种访问其唯一的对象的方式，可以直接访问，不需要实例化该类的对象

**注意：**

- ***1、单例类只能有一个实例。***
- ***2、单例类必须自己创建自己的唯一实例。***
- ***3、单例类必须给所有其他对象提供这一实例。***

##### 单例模式的几种实现方式

**懒汉式线程安全**

```java
/**
 * 懒汉式线程安全
 * 不推荐使用，严格意义上说并不是一个单例模式
 */
public static SingleTon instance;
private SingleTon(){
}

private static SingleTon getInstance() {
    if (instance == null) {
        instance = new SingleTon();
    }
    return instance;
}
```

**懒汉式线程安全**

```java
/**
 * 懒汉式线程安全
 * 优点能够在多线程环境下有较好的发挥，在第一次调用的时候才会实例化，
 * 缺点是效率低，加锁同步在大部分非线程安全的环境下，效率不乐观
 */
public static SingleTon2 instance;
private SingleTon2(){
}

public static synchronized SingleTon2 getInstance() {
    if (instance == null) {
        instance = new SingleTon2();
    }
    return instance;
}
```

**静态内部类**

```java
/**
 * 静态内部类
 * 推荐使用，静态域延迟初始化
 */
private static class SinleTonHolder {
    private static final SingleTon3 instance = new SingleTon3();
}

private static final SingleTon3 getInstance() {
    return SinleTonHolder.instance;
}
```

**双重校验锁**

```java
/**
 * 双重校验锁
 * 采用双锁机制，在一些多线程的环境下也能保持高性能状态
 */
private volatile static SingleTon4 instance;
private SingleTon4(){
}
public static SingleTon4 getInstance() {
    if (instance == null) {
        synchronized (SingleTon4.class) {
            if (instance == null) {
                instance = new SingleTon4();
            }
        }
    }
    return instance;
}
```



#### 工厂模式

定义一个创建对象的接口，让其子类自己决定实例化哪一个工厂类，工厂模式使其创建过程延迟到子类进行。

优点：调用者需要哪种实例，调用该类的工厂方法，不需要知道是如何实现的，最终会得到一个实例结果		

​	拓展性高，可以添加多个工厂方法，就有多个工厂实例

缺点：新增一个实例，就要对于的接口和工厂方法，业务量成倍添加，增加系统难度

![](/factory_pattern_uml_diagram.jpg)



##### 简单工厂

产品类有一个共同接口，不同的产品类实现同一个接口，在工厂方法中添加相对应的逻辑（单继承、多实现），有一个很大的缺点



##### 抽象工厂模式

抽象工厂模式（Abstract Factory Pattern）是围绕一个超级工厂创建其他工厂。该超级工厂又称为其他工厂的工厂。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

在抽象工厂模式中，接口是负责创建一个相关对象的工厂，不需要显式指定它们的类。每个生成的工厂都能按照工厂模式提供对象

提供一个创建一系列相关或相互依赖的接口，无需指定特定的类去实现实例





