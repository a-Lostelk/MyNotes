---
typora-root-url: images
---

# Mybatis plus

### 内置接口方法

MP在一个枚举类中定义了所有的已封装好的接口方法

![](/QQ截图20200331142645.png)

### 核心依赖

```xml
 <!-- spring -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>4.3.14.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-orm</artifactId>
    <version>4.3.14.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>4.3.14.RELEASE</version>
    <scope>test</scope>
</dependency>
<!-- mp 依赖 -->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus</artifactId>
    <version>2.3</version>
</dependency>
```