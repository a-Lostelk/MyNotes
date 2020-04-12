---
typora-root-url: images
---

## 									MySQL数据库修炼之路



### DB

database：存储数据的仓库，存储一系列有组织的数据库

### DBMS

数据库管理系统（DataBase Manager System），数据库是通过DBMS操作的容器，我们常见的MySQL、Oracel就是数据管理系统

### SQL

结构化查询语言（Stucture Query Lanauage）:专门用来于数据库通信的语言

不是某个数据库供应商专有的语言，基本上的DBMS都支持SQL



### MySQL的四大特性

#### 原子性

事务所包含的所有操作，要么全部成功，要么全部失败回滚。

#### 一致性

事务在执行的前后要保持数据的一致性

A给B转账，两人的钱加起来是2000，两人无论经历过多少次的转账，最终加起来的钱还是2000 

#### 隔离性

事务在执行的过程中，不能被别的事务干扰，A执行的事务不会影响B事务的执行

#### 持久性

事务被提交后，会永久的保存在数据库中



### MySQL数据库的四种隔离级别

1、 Serializable (串行化)：可避免脏读、不可重读读、幻读的发生

2、 Repeatable read (可重复读)：可避免脏读、不可重复读的发生。

3、 Read committed (读已提交)：可避免脏读的发生。

4、 Read uncommitted (读未提交)：最低级别，任何情况都无法保证。

**最高的Serializable，最低的是Read uncommitted，级别越高，虽然安全级别越高，但是执行的效率就越低**

MySQL中默认的隔离级别是:Repeatable read(可重复读)，oracle默认的隔离级别是：Read committed(读已提交)。



### 常见的SQL优化

- **不使用子查询**

  **`SELECT * FROM t1 WHERE id (SELECT id FROM t2 WHERE name='hechunyang');`**

  子查询在MySQL5.5版本里，内部执行计划器是这样执行的：先查外表再匹配内表，而不是先查内表t2，当外表的数据很大时，查询速度会非常慢。

- **避免函数索引**

  **`SELECT * FROM t WHERE YEAR(d) >= 2016;	——>	SELECT * FROM t WHERE d >= '2016-01-01';`**

  由于MySQL不像Oracle那样支持函数索引，即使d字段有索引，也会直接全表扫描。

- **使用in代替or**

  **`SELECT * FROM t WHERE LOC_ID = 10 OR LOC_ID = 20 OR LOC_ID = 30;`**

  替换为

  **`SELECT * FROM t WHERE LOC_IN IN (10,20,30);`**

- **like后不能双百分号**

  **`SELECT * FROM t WHERE name LIKE '%de%';`**
  ----->
  **`SELECT * FROM t WHERE name LIKE 'de%';`**

- **limit读取适当的记录**

  **`SELECT * FROM t WHERE 1 LIMIT 10;`**



### 查询语句元素的执行顺序

**执行顺序 ：from > on > where > group by > having > select > distinct > order by > top**

**表级属性大于字段，优先执行表的查询元素**

FROM：在多表查询的时候，去除笛卡尔积，会生成一个虚拟表，优先选择从哪些表中获取数据

ON：ON筛选器，一班ON指定多表之间的id匹配，因此也很重要

JOIN：联表查询左保留表和右保留表组成一个虚拟表

WHERE：WHERE筛选器，指定的条件

GROUP BY：分组查询 







### MySQL的存储过程

Sql语句是先编译后执行

#### 存储过程(Stored Procedure)：

一组可编程的函数，是为了完成特定功能的SQL语句集，经编译创建并保持在数据库中，用户可指定存储过程的名字并给定参数来调用执行

存储过程的有点：

1. 将重复性很高的一些操作，封装到存储过程中，简化了对SQL语句的调用
2. 批量处理：SQL+循环，减少流量
3. 统一接口，保证数据的安全

#### 存储过程的创建和调用

1. 存储过程就是一段具有名字的一段代码，用来完成一个特定的功能
2. 创建的存储过程存储在MySQL数据库中的数据字典中





### MySQL的存储引擎

引擎（Engine）是电子平台上开发程序或系统的核心组件。利用引擎，开发者可迅速建立、铺设程序所需的功能，或利用其辅助程序的运转。一般而言，**引擎是一个程序或一套系统的支持部分**。常见的程序引擎有游戏引擎，搜索引擎，杀毒引擎等。

简单来说，存储引擎就是指**表的类型以及表在计算机上的存储方式**。

- InnoDB给MySQL的表提供了**事务处理**、**回滚**、**崩溃修复能力**和**多版本并发控制**的事务安全
- InnoDB存储引擎总支持**AUTO_INCREMENT**，自动增长列的值不能为空，并且值必须唯一
- InnoDB还支持**外键（FOREIGN KEY）**

MyISAM的优势在于占用空间小，处理速度快。缺点是不支持事务的完整性和并发性。

MEMORY是MySQL中一类特殊的存储引擎。它使用存储在内存中的内容来创建表，而且**数据全部放在内存中**。这些特性与前面的两个很不同。



### MySQL锁

不同的存储引擎支持不同的锁机制

![](/QQ截图20191109230436.png)

- 表级锁：开销小，加锁快；不会出现死锁；锁定粒度大，发生锁冲突的概率最高，并发度最低。
- 行级锁：开销大，加锁慢；会出现死锁；锁定粒度最小，发生锁冲突的概率最低，并发度也最高。
- 页面锁：开销和加锁时间界于表锁和行锁之间；会出现死锁；锁定粒度界于表锁和行锁之间，并发度一般

#### 表级锁

表共享锁（Table Read Lock）和表独占写锁（Table Write Lock）

- 对MyISAM的读操作，不会阻塞其他用户对同一表读请求，但会阻塞对同一表的写请求；

- 对MyISAM的写操作，则会阻塞其他用户对同一表的读和写操作；

- MyISAM表的读操作和写操作之间，以及写操作之间是串行的。

  当一个线程获得对一个表的写锁后，只有持有锁线程可以对表进行更新操作。其他线程的读、写操作都会等待，直到锁被释放为止





## 									Oracle数据库修炼之路

### 什么是数据库

- 数据库是数据的仓库。
- 与普通的“数据仓库”不同的是，数据库依据“**数据结构**”来组织数据，因为“数据结构”，所以我们看到的数据是比较“条理化”的（比如不会跟以前的普通文件存储式存储成一个文件那么不条理化，我们的数据库分成一个个库，分成一个个表，分成一条条记录，这些记录是多么分明）
- 与普通的文件系统对比，数据库有其**数据结构**，所以有特定的查找方法
- 常说的Oracle数据库，其实应该说是**数据库管理系统**

#### 关系型数据库和非关系型数据库

- 关系型数据库是依据**关系模型**来创建的数据库。
- 所谓关系模型就是**“一对一、一对多、多对多”**等关系模型，关系模型就是指**二维表格模型**,因而一个关系型数据库就是由二维表及其之间的联系组成的一个数据组织。
- 关系型数据可以很好地存储一些关系模型的数据，比如一个老师对应多个学生的数据（“**多对多**”），一本书对应多个作者（“**一对多**”），一本书对应一个出版日期（“**一对一**”）
- 关系模型是我们生活中能经常遇见的模型，存储这类数据一般用关系型数据库
- 关系模型包括**数据结构**（数据存储的问题，二维表）、**操作指令集合**（SQL语句）、**完整性约束(**表内数据约束、表与表之间的约束)。

特点

安全（因为存储在磁盘中，不会说突然断电数据就没有了）、

容易理解（建立在关系模型上）、

但不节省空间（因为建立在关系模型上，就要遵循某些规则，好比数据中某字段值即使为空仍要分配空间）



- 非关系型数据库主要是基于“非关系模型”的数据库（由于关系型太大，所以一般用“非关系型”来表示其他类型的数据库）
- 非关系型模型比如有：
  1. 列模型：存储的数据是一列列的。关系型数据库以一行作为一个记录，列模型数据库以一列为一个记录。（这种模型，数据即索引，IO很快，主要是一些分布式数据库）、
  2. 键值对模型：存储的数据是一个个“键值对”，比如name:liming,那么name这个键里面存的值就是liming
  3. 文档类模型：以一个个文档来存储数据，有点类似“键值对”。



### Oracle简介

**Oracle**是殷墟出土的甲骨文(**oracle bone inscriptions**)的英文翻译的第一个单词

**Oracle**公司是全球最大的信息管理软件及服务供应商，成立于1977年，总部位于美国加州Redwood shore

**Oracle**公司因其复杂的**关系数据库**产品而闻名。Oracle的关系数据库是世界**第一个支持SQL语言的数据库**



Oracle数据库是网络数据库，就是你可以借助网络远程进行进行交互，在网络上支持多用户

Oracle的服务器和客户机是软件概念，同一台服务器可以充当客户机也可以充当服务器，或者说一台计算机只充当服务器或是客户机的作用



### Oracle数据库简介

平常所说的Oracle或Oracle数据库指的是**Oracle数据库管理系统**，Oracle数据库管理系统是**管理数据库访问的计算**
**机软件(Oracle database manager system)，**它由**Oracle数据库**和**Oracle实例(instance)**构成

Oracle数据库：存储在计算机中的文件的集合，文件组织在一起，形成一个逻辑整体，

Oracle存储和管理信息，必须和内存实例相结合，才能对外进行数据访问



#### Oracle安装

[Oracle安装教程W3Cschool](<https://www.w3cschool.cn/oraclejc/oraclejc-41xa2qqv.html>)

需要设置相应的多个数据库账户，默认数据库账户都已被锁定，需要将指定账户由锁定解锁

Oracle运行成功需要将这两个服务启动，第一个是TNS监听服务，确保能被客户端连接，第二个是oracle的运行主服务

![](/QQ截图20191103123521.png)

##### 修改口令管理

[Oracle11g 安装过程忘记在口令管理中解锁并设置SYS,SYSTEM,HR密码](<https://blog.csdn.net/ly510587/article/details/94887414>)

##### 完全卸载Oracle 11g

[完全卸载oracle11g步骤](<https://blog.csdn.net/machinecat0898/article/details/7792471>)





#### Oracle数据库体系结构简介

##### Oracle实例

位于物理内存的数据结构，由多个进程和共享的内存池，内存池可以被所有进程访问

- 要通过数据库实例来读取硬盘中的文件
- Oracle实例就是数据库服务service
- 一个数据库多个实例，多个实例之间是集群的关系（RAC ）

实例可以操作数据库，一个数据库实例只能与一个数据库关联（**一个网站对应一个账户**），同一个数据库可以被多个数据库实例访问（**淘宝能被千万个用户访问**）



#### Oracle的口令管理

SYS：超级管理员 change_on_install

system:普通管理员 manager

scott:普通用户	tiger 

Oracle默认有emp、dept等表



#### oracle中的nextval

sequence是序列号生成器，可以为表中的行自动生成序列号，一般用于生成主键值，在插入insert语句中引用，在插入的时候获取下一个序列号nextVal值，然后将该值作为下一行数据的主键

```sql
 create sequence INR_REQUIRMENT_SQUENCE  
  INCREMENT BY 1 -- 每次加几个
  START WITH 1 -- 从1开始计数
  NOMAXVALUE -- 不设置最大值
  NOCYCLE -- 一直累加，不循环
  CACHE	--一直累加不循环
  
  
  SELECT INR_REQUIRMENT_SQUENCE.CURRVAL FROM dual  --获取当前的sequence的值
```

nextval可以获取到下一个序列值，



#### Sql中的where 1= 1的意义

**1=1 永真， 1<>1 永假。** 

1<>1 的用处： 
用于只取结构不取数据的场合 

`create table table_temp tablespace tbs_temp as select * from table_ori where 1<>1 `

建成一个与table_ori 结构相同的表table_temp，但是不要table_ori 里的数据。

1=1的用处 ,用于动态SQL

SELECT paperid,papertitle from table where 1=1 and paperid like %||${paperid}||% ;

查询数据的同时也能进行模糊查询





#### Oracle语法

`select sysdate from dual;`			返回当前的系统时间



### oracle中的instr()函数

字符查找函数

instr( string1, string2 )    // instr(源字符串, 目标字符串)

instr( string1, string2 [, start_position [, nth_appearance ] ] )   

// instr(源字符串, 目标字符串, 起始位置, 匹配序号)



`select * from emp where instr(JOB,'C')>0;`和`select * from emp where job like '%C%';`是一样的效果



### dual表

- oracle中提供的最小的一张表，无论进行什么样的操作，最终都只会返回一条数据	
-  Dual表是oracle与数据字典一起自动创建的一个表，这个表只有1列：DUMMY，数据类型为VERCHAR2(1)，dual表中只有一个数据'X', Oracle有内部逻辑保证dual表中永远只有一条数据。
- Oracle中的dual表是一个单行单列的虚拟表



### varchar2和varchar的区别

- `varchar`2把所有字符都占两字节处理(一般情况下)，`varchar`只对汉字和全角等字符占两字节，数字，英文字符等都是一个字节
- `varchar2`把空串等同于null处理，而`varchar`仍按照空串处理；
- `varchar`字符要用几个字节存储，要看数据库使用的字符集





### Oracle的存储过程

#### 什么是存储过程、作用、优点

存储过程是为了完成特定功能的SQL集合，在创建的时候会在数据库中存储，



##### 优点：

- 减少网络通信量，存储过程在创建的时候数据库已经对其进行优化和编译，再次使用的时候不需要再在进行编译，面对大批量的SQL数据的时候



#### 存储过程的传参

存储过程的括号里，可以声明参数

语法是 ：`create procedure p（存储过程名）([in/out/inout] 参数名  参数类型 ..)`

in ：给参数传入值，定义的参数就得到了值

out：模式定义的参数只能在过程体内部赋值，表示该参数可以将某个值传递回调用他的过程（在存储过程内部，该参数初始值为 **null**，无论调用者是否给存储过程参数设置值）

inout：调用者还可以通过 inout 参数**传递值给存储过程**，也可以从**存储过程内部传值给调用者**



#### oracle中的mod()函数

可以用来判断是否有余数，`mod(i,2)`



#### PLSQL编程

PLSQL是对Oracle的SQL语言的过程化拓展

是在SQL命令语言中添加了过程处理语句，使SQL具有过程处理能力 

能够减少数据库和服务器之间的网络交互，也可以提高SQL的执行效率




#### PL/SQL的程序结构

PL/SQL可以分为三个部分：声明部分、可执行部分、异常处理部分

**注：**DBMS是Oracle中内置的数据包，在没有定义变量的时候，DECLARE是可以省略的

```plsql
DECLARE
	i integer；
	
BEGIN
	-- java: System.out.println()
	DBMS_output.put_line('hello world');
END;
```

在SQL plus中需要开启`set serveroutput on`来打开数据库中的输出功能



#### 变量

PLSQL编程中常见的变量分两大类
1.普通数据类型(char,varchar2, date, number, boolean, long)
2.特殊变量类型(引用型变量、记录型变量)

变量名 变量类型（变量长度）

变量只有在赋值之后才能被使用

有两种赋值方式

1. 直接赋值的方式，关键字:= v-name := '张三'
2. 语句赋值，使用`select 值 into 变量`

PLSQL中的语句都是需要分号结尾作为标识，

```plsql
DECLARE

	v_name varchar2(20) := 'zhangsan';
	v_sal number;
	v_addr varchar2(20);
begin

	v_sal := 1580;
	-- select语句不能单独使用，要和from指定条件
	select 'nanchang' into v_addr from dual;
	DBMS_output.put_line('姓名:'|| v_name || ',工资:' || v_sal || '地址' || v_addr);
	
END;

```

引用类型

变量的类型和长度由实际存在的表中字段的长度和类型来决定

`表名.列名%TYPE`制定变量的类型和长度

优点：普通变量在定义的时候需要知道表中字段的类型和长度，而引用变量的类型和长度是在确定好表中字段的长度和类型啦确定的



#### 记录型变量

接受表中的一行变量，相当于是Java中的集合变量（可以存储多个值）



#### Loop循环

```plsql
DECLARE
  --声明循环的变量和数据类型
  V_NUM NUMBER := 1;
BEGIN
  LOOP
    EXIT WHEN V_NUM > 10;
    DBMS_OUTPUT.PUT_LINE(V_NUM);
    V_NUM := V_NUM + 1;
  END LOOP;
  -- 循环体的结束
END;

```



#### 游标

声明的普通变量是无法存储接受从数据库中查询的多行数据，游标临时存储多行数据，类似于Java中jdbc中返回数据存储的resultSet集合，可以理解为从临时存储从数据库获得的数据	

游标中存储的数据首先会存放在计算机的内存中，在频繁操作的时候，直接访问内存中的游标数据，**游标就像我们查询数据返回的集合类型，比如List ，我就把它当做一个引用类型，它指向了内存区域中的数据结果集**



##### 游标声明

`cursor 游标名[参数名] is 查询语句`

`CURSOR`：声明->打开->读取->关闭

打开游标：`OPEN CURSOR`

游标的取值:`FETCH`游标名INTO变量列表:

游标的关闭:`CLOSE`游标名

| 属性      | 返回值类型 | 说明                        |
| --------- | ---------- | --------------------------- |
| %rowcount | 整型       | 获得fetch语句返回的结果     |
| %found    | 布尔       | fetch返回的结果有数据则为真 |
| %notfound | 布尔       | 与%found相反                |
| %isopen   | 布尔       | 游标是否打开                |

PLSQL中，游标的声明就会有开始和结束，打开游标，读取游标，关闭游标

**无参游标**

```PLSQL
--查询emp表中所有员工的姓名和工资并打印出来
DECLARE 
  --声明游标和相关参数
  cursor c_emp IS SELECT ENAME,SAL FROM emp;
  
  --声明接受游标中数据的变量
  v_ename emp.ename%TYPE;
  v_sal emp.sal%TYPE;
BEGIN
  --打开游标、关闭游标 
  OPEN c_emp; 
  
  --开启和关闭LOOP循环
  LOOP
    
  --获取游标中的数据、循环开始和退出循环
  FETCH c_emp INTO v_ename, v_sal;
  
  --判断游标中是否还有值存在
  EXIT WHEN c_emp%NOTFOUND;
  dbms_output.put_line(v_ename ||'的工资是'||v_sal);
  END LOOP;
  CLOSE c_emp;
END;
```

**有参游标**

```plsql
--查询emp表中所有员工的姓名和工资并打印出来(指定部门的ID)
DECLARE 
  --声明游标和相关参数
  cursor c_emp(v_deptno emp.deptno%TYPE) 
  IS SELECT ENAME,SAL FROM emp where deptno=v_deptno;
  
  --声明接受游标中数据的变量
  v_ename emp.ename%TYPE;
  v_sal emp.sal%TYPE;
BEGIN
  --打开游标、关闭游标 
  OPEN c_emp(20);
  
  --开启和关闭LOOP循环
  LOOP
    
  --获取游标中的数据、循环开始和退出循环
  FETCH c_emp INTO v_ename, v_sal;
  
  --判断游标中是否还有值存在
  EXIT WHEN c_emp%NOTFOUND;
  dbms_output.put_line(v_ename ||'的工资是'||v_sal);
  END LOOP;
  CLOSE c_emp;
END;
```

默认%notfound中是false值，所以判断是需要在fetch取出之后执行判断是否有值



##### 显示游标和隐式游标

DML操作和单行SELECT语句会使用**隐式游标**

------

上述的PLSQL的存储过程是可以进行表的操作但是无法被重复调用



##### 真真正正的数据库存储过程

PLSQL是将一个个业务处理过程存储起来进行复用，这就是存储过程

在开发程序中，为了一个特定的业务功能，会向数据库进行多次连接关闭(连接和关闭是很耗费资源)，需要对数据库进行多次I/O读写，性能比较低。如果把这些业务放到PLSQL中，在应用程序中只需要调用PLSQL就可以做到连接关闭次数据库就可以实现我们的业务,可以大大提高效率

语法：

`create or replace procedure 存储过程名字 as/is  begin end 存储过程名字 `

存储过程中只有输入和输出`in 和 out`

存储过程中只是存储一些SQL的业务多次使用，并不能独立运行，需要外部SQL或者程序调用

无参存储过程

```plsql
create or replace procedure p_hello as
--声明变量
begin
  
  dbms_output.put_line('hello world');
end p_hello;
```

有参输入存储过程

```PLSQL
create or replace procedure p_querynameandsal(I_EMPNO IN emp.empno%type) as
  --声明变量
  V_EMPNAME EMP.ENAME%TYPE;
  V_SAL EMP.SAL%TYPE;
BEGIN
  SELECT ENAME,SAL INTO V_EMPNAME,V_SAL FROM EMP WHERE EMPNO = I_EMPNO;
  dbms_output.put_line(V_EMPNAME||'__'||V_SAL);
end;
```

有参输出存储过程

```plsql
CREATE OR REPLACE PROCEDURE P_QUERYSAL(i_empno in emp.empno%TYPE,
                                       o_sal   OUT EMP.SAL%TYPE) AS
BEGIN
  SELECT SAL INTO o_sal FROM EMP WHERE EMPNO = i_empno;
END;


--调用有参存储过程的函数，可以被外部程序，比如Java程序调用，这时候改存储过程就相当于是一个类中的方法
DECLARE 
  --声明接受输出存储过程参数的值
  v_sal EMP.SAL%TYPE;
BEGIN
  P_QUERYSAL(7839,v_sal);
  dbms_output.put_line(v_sal);
END;
```



##### 使用Java程序调用存储过程

在JDK中，`CallableStatement`接口创建一个调用数据库存储过程的对象

```java
public static void main(String[] args) throws SQLException,Exception {

    //加载驱动
    Class.forName("oracle.jdbc.driver.OracleDriver");
    //获取连接对象
    String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    String username = "scott";
    String password = "tiger";
    Connection connection = DriverManager.getConnection(url,username,password);

    //获得语句对象
    String sql = "{call P_QUERYSAL(?,?)}";
    CallableStatement statement = connection.prepareCall(sql);

    //设置输入和输出参数
    statement.setInt(1, 7839);
    //注册输出函数
    statement.registerOutParameter(2, OracleTypes.DOUBLE);

    statement.execute();

    double d = statement.getDouble(2);

    System.out.println(d);

    connection.close();
    statement.close();
}
```



##### REF游标

动态关联结果集的临时对象，在运行的时候动态决定是否执行查询

















