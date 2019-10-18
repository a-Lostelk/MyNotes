---
typora-root-url: images
---

## Spring boot修炼之路

**SpringBoot**并不是一种全新的框架,默认配置了很多Spring框架的使用方式,就像maven整合了所有的jar包一样
	是简化Spring大家族的一个框架,整个Spring栈的一个大整合,J2EE的一站式解决方案

*SpringBoot*必然会和微服务有一定的联系
	架构服务微化
	一个应用是一组小型服务,可以通过HTTP协议互通
	每一个功能元素是可独立替换和升级的软件单元

##### **Springboot的优点**

- 快速创建一个可以独立运行的Spring项目以及运行

  - 使用的是嵌入式的Servlet容器,应用无需打成war包发布到服务器上面,jar包可以直接被使用,war包是需要打包到服务器上面的
  - starters启动器自动依赖和版本控制
  - 自动配置,简化开发,当然也可以修改默认值
  - 无需配置xml,无代码生成
  - 准生产环境中的运行时应用监控

  - 与云计算的天然继承

##### **缺点**

​	SpringBoot是基于Spring进行在封装,需要对Spring熟悉了解 	
​	

##### **微服务**

- 传统的架构风格是把所有的功能放入到单一进程中,将整个项目部署到服务器上,在对项目进行修改的时候,可能需要将整个项目重新发布或者部署并且通过在多个服务器上复制这个单体进行拓展
- 微服务提倡的是将每个功能元素放进独立的元素,通过跨服务器分发这些服务进行拓展,只有在需要的时候才进行复制，每一个功能元素都是一个独立替换和独立升级的软件单元


  #### ***Springboot*的java配置方式**

1. 通过 @Configuration 和 @Bean 注解实现

  - @Configuration作用在类上面,相当于一个xml文件
   - @Bean作用于类中的方法上面,相当于XML中的一个bean


  AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);



**读取外部资源文件**
	@PropertySource:读取资源文件
	**<property name="ignoreResourceNotFound" value="true"></property> **在多个扫描文件时忽略没有扫描到配置文件

**第一个Springboot程序**
	@SpringBootApplication 标注这是一个Springboot应用,主程序启动
	说明Springboot最终是Spring在运行
	run方法冲传入的类一定要是SpringBootApplication标识的主配置类
	SpringApplication.run(Application.class, args);

**@SpringBootConfiguration**
标识在某个类上,表示这是一个Springboot配置类

- @**Configuration**:这里和SpringMVC中的注解是一样的,配置类是容器的一个组件,这里的注解最终是一个接口
- **@EnableAutoConfiguration**: 开启自动配置功能,

   @AutoConfigurationPackage
   ```java
   @Import({EnableAutoConfigurationImportSelector.class})
   public @interface EnableAutoConfiguration {
   ```

- @**AutoConfigurationPackage**:自动配置包
  1. @**Import**({Registrar.class})
       Spring的底层注解,选择导入哪些包
         将主配置类**(*@SpringBootConfiguration*)**所在包以及下面所有的子包里面的所有容器都扫描到Spring容器中

    **EnableAutoConfigurationImportSelector:**选择哪些组件的选择器,将所有需要导入的组件以全类名的方式返回,这些组件就会被添加到Spring容器中

*有了自动配置类,就不用手写配置功能组件的工作*

- *Springboot*在启动的时候从类路径(/META-INF/spring.factories)获取@EnableAutoConfiguration需要自动配置的组件,将这些值作为配置类加入到Spring容器中
  都在*org.springframework.boot.autoconfigure*包下面

  **@RestController**:*@ResponseBody+@Controller*组合, 这个类的所有方法返回的数据写给浏览器(如果是对象转换json 格式)

  **Springboot**是使用的嵌入式的Tomcat,默认是不支持JSP页面
  需要使用模板引擎

  ##### 配置文件

  - **application.properties**:这是Springboot的全局配置文件

    ```properties
    server.port=8081
    ```

  - **application.yml**

    ```yml
    server:
      port: 8081
    ```

  - **xml**

    ```
    <server>
    	<port>8081</port>
    </server>
    ```


  配置文件名字是固定的,Spring boot 在底层实现了自动配置

- 标记语言

  YML是以数据为中心,比json,xml更适合做配置文件

##### YML 的语法

​	以空格来表示层级的关系,左对齐的一列数据都是表示是同一层级的

​	key:  value(空格是必须有的)

​	属性和值大小写要注意

##### 值的写法

***字面量***:  普通的值

​			字面量直接来写,字符串默认不用加上单引号双引号

- 双引号:不会转移特殊字符 例如: sunny \n sun 结果是: sunny 换行 sun
- 单引号:会转义特殊字符,例如: sunny \n sun 结果是:sunny \n sun

***对象***:  

对象还是用k:v的方法

​	key值的下一行来写属性和值的关系

```yml
friends:
	name: sunny
	age: 21
```

***数组***

用-值表示数组的一个元素	

```yml
animals:
	-cat
	-dog
	-pig
```

**@ConfigurationProperties**:该注解标识的类,会将相关配置文件中的属性进行绑定

​	prefix = "person"	是与配置文件下的某个属性进行一一映射

##### Spring boot单元测试	

```java

@RunWith(SpringRunner.class) 
@SpringBootTest
public class SpringBootApplicationTest { }
```

```java
@Component
@ConfigurationProperties(prefix = "person")
public class Person {
    /**
     * @ConfigurationProperties 会自动扫描配置文件中的person属性,将属性值存放到实体类中
     */
    private String name;
    ......
```

*@ConfigurationProperties*读取指定的配置文件会将配置文件中设置的属性值,放入到这个类中(默认是从全局配置文件中获取值)

*@Value**的作用和*ConfigurationProperties*作用相同,但是需要一个一个指定属性值,value 是Spring底层的注解

*@Validated*标识当前的类需要进行校验

***推荐使用@ConfigurationProperties而不是@Value***

***在某个业务逻辑中只需要获取一下配置文件中的某项值,使用@Value***

***某个Javabean 是专门和配置文件进行映射,我们就直接使用@ConfigurationProperties,好处在于一次性就配置文件中的值一次性注入进来***



**@PropertySource**:加载外部(非全局配置文件)的配置文件,可以是以数组的形式加载多个配置文件

```java
@PropertySource(value = {"classpath:person.properties"})
```

**@ImportResource**导入Spring容器外的Spring容器,才能让配置生效,标志在一个配置类中	

```java
@ImportResource(locations = {"classpath:HelloWorldService.xml"})
```



*Spring Boot推荐使用注解的方式添加组件*

​			**@bean**的方式添加组件:

​				可以看出,@Configuration和@Bean是Spring底层的注解

```java
 * 标注这是一个配置类
 * 注解方式的配置替代了之前的SpringXML配置文件
 */
@Configuration
public class MyConfig {

    /**
     * 将方法的返回值添加到容器中,这个组件默认的id就是方法名
     * helloWorldService方法名就是bean的id
     */
    @Bean
    public HelloWorldService helloWorldService(){
        System.out.println("向容器中添加组件-----------");
        return new HelloWorldService();
    }
```

##### 配置文件占位符

###### 1随机数

​	${random.value}



##### Profile

​	**Profile**是Spring在不同的环境中提供不同的环境支持,比如在测试环境使用测试环境,在项目上线后使用生产环境,开发过程中使用开发环境,可以通过激活,指定参数	等方式进行快速切换环境

###### 	激活指定profile(properties)

```xml
server.port=8081
#激活Dev的开发环境,开发环境中的被激活后,端口号会变成指定profile文件的端口号
spring.profiles.active=dev
```

###### 	YML的方式激活

​	使用文档块模式

```xml
server:
  port: 8081
#激活指定的profile
spring:
  profiles:
    active: dev
---
server:
     port: 8082
#生产环境
spring:
  profiles: dev
```





##### 父项目**


		<parent>
	        <groupId>org.springframework.boot</groupId>
	        <artifactId>spring-boot-starter-parent</artifactId>
	        <version>1.5.9.RELEASE</version>
	    </parent>
		<!--真正管理Springboot的依赖-->
		<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-dependencies</artifactId>
		<version>1.5.9.RELEASE</version>
		<relativePath>../../spring-boot-dependencies</relativePath>
	</parent>

**导入的web依赖**	
*spring-boot-starter:场景启动器,自动导入web模块运行的时候所需要的组件*

*Spring boot*将所有的功能场景都抽取出来,用starter表示,在项目中根据项目的需求导入相应的场景启动器



	<dependencies>
	    <dependency>
	        <groupId>org.springframework.boot</groupId>
	        <artifactId>spring-boot-starter-web</artifactId>
	    </dependency>
	</dependencies>

##### ***Maven插件***


  <!--这个插件作用是将应用打包成一个可执行的jar包-->

	<build>
	    <plugins>
	        <plugin>
	            <groupId>org.springframework.boot</groupId>
	            <artifactId>spring-boot-maven-plugin</artifactId>
	        </plugin>
	    </plugins>
	</build>  
​	

java -jar spring-boot-hellowrold-1.0-SNAPSHOT.jar直接cmd就能运行,和在编译器中通过发布到服务器上进行运行是一样的,
这个jar包本身会将项目相关jar包和Spring容器,Tomcat服务器等携带过去,因此使用该jar包的调用者句不需要安装服务器
​	

#### **Spring boot**

​	使用"习惯优于配置"的理念
​	Spring boot可以整合第三方框架,让项目快速运行起来,可以很快的创建一个独立运行(运行jar,内嵌ServletTomcat服务器)
​	准生产级别的基于Spring框架的web项目

##### 	**优点:**

​		1.对主流开发框架的无配置继承
​		2.项目可独立运行,无序依赖外部的Servlet容器
​		3.提供运行时的应用监控
​		4.极大的提高了开发,部署效率
​	它并不是一种新的框架技术,而是整合了Spring家族的很多框架技术

```
 <parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>1.5.2.RELEASE</version>
		<!-- 在parent中已经定义了版本号,所以在接下来的Spring相关jar包就不用定义版本号 -->
	  </parent>
```

##### **常用注解**

​	@*EnableAutoConfiguration*: 启用自动配置,将项目所依赖的jar包自动配置到项目的配置项
​	@*ComponentScan*:默认会扫描@SpringBootApplication 注解所在类同级目录以及子目录
​	@*Configuration* 作用在类上面,相当于一个xml文件
​	@Bean作用于类中的方法上面,相当于XML中的一个bean,会被当成是一个bean添加到容器中
​	@*SpringBootApplication*：申明让spring boot自动给程序进行必要的配置，这个配置等同于：@*Configuration*
​	 ，@EnableAutoConfiguration 和 @ComponentScan 三个配置。 
​	 exclude将不需要自动配置的类排除
​	 @RestController：用于标注控制层组件(如struts中的action), @ResponseBody和@Controller的合集
​	 @*ConditionalOnClass*:当运行环境中包含以下class文件后,才会实例化这个对象
​	@*ImportResource*:加载外部XML文件

##### **starter pom文件**

​	Spring boot为我们提供了绝大部分场景所需要的starter pom,相关的技术配置将会消除,

Spring boot的自动配置原理
	在SpringApplication对象实例化的时候会加载META-INF/spring.factories,将该配置文件中的配置加载到Spring的容器中

静态语言和动态语言
	静:先编译后运行的
	动:不需要编译直接运行的    

自定义消息转化器
	要在 @Configuration 的类中添加消息转化器的类假如到Spring容器中,将会被Spring boot自动加载到Spring容器中
	 //添加消息转化器
	
		    @Bean /*会自动将含bean注解的方法实例加入到Spring容器中*/
		    public StringHttpMessageConverter stringHttpMessageConverter(){
			StringHttpMessageConverter converter = new StringHttpMessageConverter(Charset.forName("UTF-8"));//设置编码格式是中文
			return converter;
		 }

##### 添加SpringMVC拦截器

​	要继承一个抽象接口WebMvcConfigurerAdapter

##### Spring Boot的web开发

​	@PropertySource:加载外部配置文件
​	@ComponentScan:设置扫描包
​	@ConditionalOnMissingBean:当容器里没有指定的bean时创建该对象
​	@AutoConfigureAfter(MybatisConfig.class):保证在Mybatis对象实例化之后再实例化该类
事务管理
​	引入jdbc依赖后自动注入DataSourceTransactionalManager(数据源事务管理器)和JpaTransactionalManager,所以不需要依赖任何外部配置就可以实现
​	注解事务的使用
​	@Transactional不仅可以使用在方法上,还可以使用在类上,使用在类上的时候意味着所有的Public方法都是开启事务的,



##### SpringBoot的配置文件加载

容器启动时加载的application.properties或者yml文件位置有优先级之分,*优先级高的会覆盖低优先级的文件*,从高到低加载

1. 根目录的config文件夹
2. 根目录文件夹
3. 资源(resources)文件夹的config包下
4. 资源文件夹的根目录下(这是默认的Springboot的配置文件路径)

Spring.config.location修改默认的配置文件路径

该命令是项目打包后使用命令行指定配置文件和项目默认的配置文件形成互补的作用

适用于项目已经打包上线的时候需要更改什么配置文件的时候,不需要将项目重新运行更改并重新打包



##### 外部配置文件的优先级

1. ###### 命令行参数

   项目打包完成后在CMD命令行指定修改的参数

   **java -jar **spring-boot-hellowrold-1.0-SNAPSHOT.jar **-service.port=8180**

2. ###### jar包外部的全局配置文件

   优先级是根据application.yml（properties）文件是否带有profile参数，带有的先被执行，会覆盖低优先级的配置文件

   有jar包外部向jar包外部寻找

3. @Configuration配置的类中的注解@ImportSource

##### Springboot的自动配置原理:

1. 容器在启动的时候夹杂配置类,开启了自动配置功能 ***@EnableAutoConfiguration***

2. ***@EnableAutoConfiguration***作用:

   - *@Import({AutoConfigurationImportSelector.class})*导入了一些组件

   - *org.springframework.boot.autoconfigure.AutoConfigurationImportSelector#selectImports*方法获取待读取的配置文件组件

     ```java
         protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
             
     //通过SpringFactoriesLoader加载资源,扫描jar包类路径下的META-INF/spring.factories文件得到URLs集合
             List<String> configurations = SpringFactoriesLoader.loadFactoryNames(this.getSpringFactoriesLoaderFactoryClass(), this.getBeanClassLoader());
             
             Assert.notEmpty(configurations, "No auto configuration classes found in META-INF/spring.factories. If you are using a custom packaging, make sure that file is correct.");
             return configurations;
         }
     ```
  ```
   
- Spring工厂加载器通过*loadFactoryNames*根据文件名从类路径下得到一个资源(*扫描所有的jar包*),返回的结果封装成一个枚举接口Enumeration,得到所有的URL路径
   
     ```java
     Enumeration<URL> urls = classLoader != null ? classLoader.getResources("META-INF/spring.factories") : ClassLoader.getSystemResources("META-INF/spring.factories");
  ```

- 将urls枚举数组遍历后,得到的url封装成一个*properties*对象

- 从*properties*对象中获取的值(factoryClassName)最终返回Result结果添加到容器中



**总结**: 将 *autoconfiguare* jar包下的 *Spring.properties*中的  ***org.springframework.boot.autoconfigure.EnableAutoConfiguration***的所有配置加到容器中,会添加一系列的*xxxAutoconfiguare* 的类到SpringBoot容器中,配置类就会完成Springboot的自动配置功能

   

   **自动配置原理**

   ```java
   @Configuration	//配置类,可以向容器添加组件
   @EnableConfigurationProperties({HttpProperties.class})	//启动指定类的自动配置功能
   @ConditionalOnWebApplication(type = Type.SERVLET)
   @ConditionalOnClass({CharacterEncodingFilter.class})//判断当前类有没有指定的类CharacterEncodingFilter编码过滤器
   @ConditionalOnProperty(prefix = "spring.http.encoding",value = {"enabled"}, matchIfMissing = true)	//判断配置文件中是否存在spring.http.encoding.enabled 
   						//matchIfMissing如果不存在也默认为true
   public class HttpEncodingAutoConfiguration {
       //已经个Spring的配置文件绑定了
        private final Encoding properties;
   
       //只有一个有参构造函数的情况下,参数的值会从容器中拿
       public HttpEncodingAutoConfiguration(HttpProperties properties) {
           this.properties = properties.getEncoding();
       }
   
       @Bean	//向容器添加一个组件,组件中一些内容会从properties中取出来
       @ConditionalOnMissingBean
       public CharacterEncodingFilter characterEncodingFilter() {
           CharacterEncodingFilter filter = new OrderedCharacterEncodingFilter();
           filter.setEncoding(this.properties.getCharset().name());
           .....
   ```

   根据IOC的自动注入特性,该类已经绑定了很多的配置类(类前的多个注解已经绑定了很多配置文件,)

######  @Conditional 派生注解

-  *@ConditionalOnWebApplication*,*@ConditionalOnClass*,@ConditionalOnProperty
-  必须满足on后面的条件后,才会执行

***自动配置类大多都是有一定的条件才能生效***

我们需要关注的就是那些自动配置类生效了

```
#开启SpringBoot的debug模式
debug=true
```

控制台会打印出日志,提示那些组件容器加载了,那些容器没有加载

控制台打印如下:

```java
###容器加载了的组件
Positive matches:
-----------------
   CacheAutoConfiguration matched:
      - @ConditionalOnClass found required class 'org.springframework.cache.CacheManager' (OnClassCondition)

          ......
```

```java
###没有加载的组件
Negative matches:
-----------------
   ActiveMQAutoConfiguration:
      Did not match:
         - @ConditionalOnClass did not find required class 'javax.jms.ConnectionFactory' (OnClassCondition)
             
             .....
```

**总结**:

1. 当Springboot启动的时候,是从带有*@SpringBootApplication*注解的主程序开始启动的,它的主要作用是开启*@EnableAutoConfiguration*自动注解扫描一些组件
2. *@EnableAutoConfiguration*实现自动配置组件得益于*@EnableAutoConfigurationImportSelector*选择器给Spring容器中来导入一些组件
3. 选择器扫描jar包类路径下的 *META-INF/spring.factories*文件并得到一个urls集合,遍历集合最后得到一个*spring.properties*对象*(spring-boot-autoconfigure-2.1.6.RELEASE.jar* MATA_INFO下),***spring.properties*的autoconfigure有所有的已经自动配置的类**
4. 从properties对象中获取一些值,这些值是需要配置的类的类名,相当于factoryClassName,然后添加到容器中
5. 每一个xxxAutoConfiguration类都是容器中的一个组件,并都加入到容器中,然后容器会根据这些类来做自动配置

```xml
# Auto Configure
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
org.springframework.boot.autoconfigure.admin.SpringApplicationAdminJmxAutoConfiguration,\
org.springframework.boot.autoconfigure.aop.AopAutoConfiguration,\
org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration,\
org.springframework.boot.autoconfigure.batch.BatchAutoConfiguration,\
org.springframework.boot.autoconfigure.cache.CacheAutoConfiguration,\
org.springframework.boot.autoconfigure.cassandra.CassandraAutoConfiguration,\
org.springframework.boot.autoconfigure.cloud.CloudServiceConnectorsAutoConfiguration,\
......#还有很多
```

***如果Springboot中没有我们需要的自动配置类，我们需要自己创建一个类将相应的组件配置起来***

***给容器中添加自动配置类组件的时候，会从properties中获取某些属性，这些属性我们可以在配置文件中指定这些属性的值***





##### Springboot和日志

###### 日志框架

一般情况下,我们打印日志可以把关键数据打印在控制台,用来了解项目的流程情况

*日志框架就是用来记录系统的一些运行时期信息*

**日志门面**: SLF4J

**日志实现:** LogBack

Springboot的日志框架默认是Spring的JCL(Commons logging)

###### SLF4J使用

日志打印的时候,一般都是调用日志抽象层的方法,而不是使用实现类的方法,指定了抽象层的方法就会自动选择实现类的方法

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class HelloWorld {
  public static void main(String[] args) {
      //获取一个记录器,传入需要记录日志的类(此处是当前类HelloWorld)
    Logger logger = LoggerFactory.getLogger(HelloWorld.class);
    logger.info("Hello World");	//打印控制台或记录文件
  }
}
```

***每一个框架都有自己的配置文件,使用slf4j后,配置文件还是写的是实现层框架的配置文件,使用哪个实现层框架就是写哪个框架的配置文件***



##### SLF4J和其他的日志框架整合

1. 将项目原先的日志框架移除
2. **替换想要替换的日志框架中间包**
3. 最终需要的日志框架添加到项目中取代原先的jar包



##### Springboot的日志关系

```
##Springboot的场景启动器(最高一级的)
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>	
</dependency>

#位于starter中的日志启动器
 <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-logging</artifactId>
      <version>2.1.6.RELEASE</version>
      <scope>compile</scope>
    </dependency>

```

- [ ] ![](D:\typora\typora-user-images\1562568509089.png)



###### 日志级别

```java
 @Test
    public void contextLoads() {
        //由低到高的日志级别,Springboot默认使用的是info级别的日志,因此会输出级别以后的高级别日志
        logger.trace("——————跟踪日志");
        logger.debug("——————Debug日志");
        logger.info("——————info日志");
        logger.warn("——————警告日志");
        logger.error("——————错误日志");
    }
```

日志输出格式

%d	日期时间

%thread	线程名字

%-5level:	级别从左显示五个宽度

%logger{50}	每个logger的名字最长是多少

%msg:	日志消息

%n	换行符

```java
例子
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} %msg%n

效果如下
2019-07-08---> [main]---> TRACE---> com.example.SpringbootLoggingDemoApplicationTests:  ——————跟踪日志
2019-07-08---> [main]---> DEBUG---> com.example.SpringbootLoggingDemoApplicationTests:  ——————Debug日志
2019-07-08---> [main]---> INFO ---> com.example.SpringbootLoggingDemoApplicationTests:  ——————info日志
2019-07-08---> [main]---> WARN ---> com.example.SpringbootLoggingDemoApplicationTests:  ——————警告日志
2019-07-08---> [main]---> ERROR---> com.example.SpringbootLoggingDemoApplicationTests:  ——————错误日志

```

在*application.properties*文件中

```
#控制台输出的日志格式,可以自定义格式
logging.pattern.console=%d{yyyy-MM-dd}---> [%thread]---> %-5level---> %logger{50}:  %msg%n
```

配置自定义的日志配置文件最好用logback-spring.xml,才能被Springboot容器识别

###### 激活自定义日志

```xml
#激活自定义的日志配置文件的环境(在logback-spring.xml中)
spring.profiles.active=dev
```

*在logback-spring.xml可以指定多个生成环境*

```xml
 <!-- 开发环境 -->
    <springProfile name="dev">
        <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>${PATTERN}</pattern>
            </encoder>
        </appender>
        <root level="info">
            <appender-ref ref="CONSOLE" />
        </root>
    </springProfile>
```



##### Springboot与web开发

***xxxAutoproperties***：帮我们给容器添加自动配置组件

***xxxproperties***:封装配置文件中配置类



##### SPringboot对静态资源的映射

```java
@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			if (!this.resourceProperties.isAddMappings()) {
				logger.debug("Default resource handling disabled");
				return;
			}
			Duration cachePeriod = this.resourceProperties.getCache().getPeriod();
			CacheControl cacheControl = this.resourceProperties.getCache().getCachecontrol().toHttpCacheControl();
			if (!registry.hasMappingForPattern("/webjars/**")) {
				customizeResourceHandlerRegistration(registry.addResourceHandler("/webjars/**")
						.addResourceLocations("classpath:/META-INF/resources/webjars/")
						.setCachePeriod(getSeconds(cachePeriod)).setCacheControl(cacheControl));
			}
            ·····
```

*webjars*：以jar包的形式引入静态资源

```xml
 <!--以jar包的形式导入JQuery-->
        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>jquery</artifactId>
            <version>3.3.1</version>
        </dependency>
```





![1562660097887](D:\typora\typora-user-images\1562660097887.png)

*classpath:/META-INF/resources/webjars/：*默认的Webjars的寻找路径

浏览器上输入 <http://localhost:8080/webjars/jquery/3.3.1/jquery.js>就能访问到项目中的JS文件



/**访问任意的资源

**需要自己添加静态资源的时候，应当放在这几个文件夹下**，容器首先会在这几个文件找加载静态资源

```
	  "classpath:/META-INF/resources/",
      "classpath:/resources/", 
      "classpath:/static/", 
      "classpath:/public/
```



**默认首页index.html**，**被映射所以首页也应该放在指定的文件夹下面**

```java
	private Optional<Resource> getWelcomePage() {
			String[] locations = getResourceLocations(this.resourceProperties.getStaticLocations());
    //如果请求的路径不存在或是没找到，跳转的默认路径
    //locations).map(this::getIndexHtml
			return Arrays.stream(locations).map(this::getIndexHtml).filter(this::isReadable).findFirst();
		}

		private Resource getIndexHtml(String location) {
			return this.resourceLoader.getResource(location + "index.html");
		}
```

**标签栏图标**

放在 **/**** 指定的文件夹下， *名字必须是favicon.ico才能生效*



##### 模板引擎

JSP、freemark、velocity等

Springboot推荐的模板引擎是Thymeleaf，功能强大

###### Thymeleaf的引入

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>

##修改版本为2.0以上
 <properties>
        <thymeleaf.version>3.0.11.RELEASE</thymeleaf.version>
        <thymeleaf-layout-dialect.version>2.1.1</thymeleaf-layout-dialect.version>
    </properties>
```

***这里有一个比较坑的地方：***thymeleaf的版本最好是要适配的版本，如上图所示，不然会发生404错误

###### thymeleaf的使用和语法

```java
@ConfigurationProperties(prefix = "spring.thymeleaf")
public class ThymeleafProperties {

	private static final Charset DEFAULT_ENCODING = StandardCharsets.UTF_8;

	public static final String DEFAULT_PREFIX = "classpath:/templates/";

	public static final String DEFAULT_SUFFIX = ".html";
```

***从这里可以看出，我们把html页面放在classpath:/templates/下，thymeleaf引擎自动为我们进行渲染，我们并不需要对Spring boot进行视图解析器模板引擎等的配置***

```java
/**
     * 类似于SpringMVC的视图解析器
     * 会自动解析classpath:templates的HTML文件
     * @return
     */
    @RequestMapping("/success")
    @ResponseBody
    public String success(){
        return "success";
    }
```

**使用：**

1. 导入thymeleaf的命名空间（*之后就会有语法提示*）

   ```html
   <html xmlns:th="http://www.thymeleaf.org">
   ```

2. 使用thymeleaf的语法

   ***th：将任意html原生属性替代自定义的值***


   ```html
   <!--th:text 将div的文本设置为 ${}占位符中的值}-->
   <div th:text="${hello}">不经过模板引擎直接访问div中的文本内容,使用thymeleaf渲染后的读取的后台取出设置的值</div>
   ```

   详细在thymeleaf官方文档中：

   ![1562740063619](D:\typora\typora-user-images\1562740063619.png)

   **其中几个常用的**：

   - **th:insert** : 片段包含，类似于jsp：include标签

   - **th:each** ：c:forEach

   - **th:if/unless/switch/case**  条件判断(只有当条件成立的时候，才会显示元素的内容)

   - **th:objectb**  c:set  变量声明

   - **th:attr/attrprepend/attrappend**:任意属性修改，添加属性

   - **th:text/utext**:前者转义（直接将后台传递的数据显示在页面），后者不转义(会被当成html的元素)

   - **th:fragment**:声明片段

   - **th:href="@{}"**: url引用文件

   - **th:value:**取出对象的值

     **thymeleaf的详细参考博客**：<https://www.cnblogs.com/ityouknow/p/5833560.html>



3. **表达式**：

   ```properties
   Simple expressions:			（表达式语法）
       Variable Expressions: ${...}		（获取属性，底层是OGNL）
       	1·获取对象的方法、属性
       	2·获取内置的对象
       Selection Variable Expressions: *{...}		(选择表达式)
       	和￥{}的用处大致相同
       Message Expressions: #{...}		（获取国际化内容）
       Link URL Expressions: @{...}	（定义URL）
       Fragment Expressions: ~{...}	（片段）
   Literals
   Text literals: 'one text' , 'Another one!' ,…
   Number literals: 0 , 34 , 3.0 , 12.3 ,…
   Boolean literals: true , false
   Null literal: null
   Literal tokens: one , sometext , main ,…
   Text operations:
   String concatenation: +
   Literal substitutions: |The name is ${name}|
   Arithmetic operations:
   Binary operators: + , - , * , / , %
   Minus sign (unary operator): -
   Boolean operations:
   Binary operators: and , or
   Boolean negation (unary operator): ! , not
   Comparisons and equality:
   Comparators: > , < , >= , <= ( gt , lt , ge , le )
   Equality operators: == , != ( eq , ne )
   Conditional operators:
   If-then: (if) ? (then)
   If-then-else: (if) ? (then) : (else)
   Default: (value) ?: (defaultvalue)
   Special tokens:
   ```

   4 . 内置的工具对象

   would be obtained using #{…} syntax.
   #uris : methods for escaping parts of URLs/URIs 
   
   #conversions : methods for executing the configured conversion service (if any).
#dates : methods for java.util.Date objects: formatting, component extraction, etc.
   #calendars : analogous to #dates , but for java.util.Calendar objects.
   #numbers : methods for formatting numeric objects.
   #strings : methods for String objects: contains, startsWith, prepending/appending, etc.
   #objects : methods for objects in general.
   #bools : methods for boolean evaluation.
   #arrays : methods for arrays.
   #lists : methods for lists.
   #sets : methods for sets.
   #maps : methods for maps.
   #aggregates : methods for creating aggregates on arrays or collections.
   #ids : methods for dealing with id attributes that might be repeated (for example, as a result of an iteration). 


    ***{...}选择表达式和${}的不同**

   ![1562744689485](D:/typora/typora-user-images/1562744689485.png)

   

   **@{}定义url**

   @{/order/process(execId=${execId},execType='FAST')} 

   ```html
   <!-- Will produce 'http://localhost:8080/gtvg/order/details?orderId=3' (plus rewriting) -->
   <a href="details.html"
   th:href="@{http://localhost:8080/gtvg/order/details(orderId=${o.id})}">view</a>
   <!-- Will produce '/gtvg/order/details?orderId=3' (plus rewriting) -->
   <a href="details.html" th:href="@{/order/details(orderId=${o.id})}">view</a>
   <!-- Will produce '/gtvg/order/3/details' (plus rewriting) -->
   <a href="details.html" th:href="@{/order/{orderId}/details(orderId=${o.id})}">view</a>
   ```

   **~{}：片段引用**

   ```html
   <div th:insert="~{commons :: main}">...</div> 
   ```

   

   -——————  ***th:标签都是写在那些html元素后面的，不能单独作为使用***

   

   **thymeleaf内置对象：**

   **#ctx** : the context object.		//上下文对象
   #**vars**: the context variables.	//代表变量
   #**locale** : the context locale.		//区域信息

   *文本环境下的变量*

   #**request** : (only in Web Contexts) the HttpServletRequest object.
   #**response** : (only in Web Contexts) the HttpServletResponse object.
   #**session** : (only in Web Contexts) the HttpSession object.
   #**servletContext** : (only in Web Contexts) the ServletContext object. 

   

     **Arrays.asList**

   将数组转换为list，不支持基本数据类型（可以使用包装类），将数组和链表结合，一个更新时，另一个也会更新，不支持add和remove方法，有链表的结构，没有链表的可以增加属性变长的特性

   

4. **支持行内写法[[...]]和[(...)]**

   从后台传递的数据，可以不用包含在元素标签中，可以直接在空白处通过该标签直接写出来

   [[...]] ===>th:text

   [(...)] ===>th:utext



##### SpringMVC的自动配置原理

详细文档：<https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html>

Spring Boot底层对SpringMVC实现了自动配置

参照官方文档：

- Inclusion of `ContentNegotiatingViewResolver` and `BeanNameViewResolver` beans.
- Support for serving static resources, including support for WebJars (covered [later in this document](https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html#boot-features-spring-mvc-static-content))).
- Automatic registration of `Converter`, `GenericConverter`, and `Formatter` beans.
- Support for `HttpMessageConverters` (covered [later in this document](https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html#boot-features-spring-mvc-message-converters)).
- Automatic registration of `MessageCodesResolver` (covered [later in this document](https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html#boot-features-spring-message-codes)).
- Static `index.html` support.
- Custom `Favicon` support (covered [later in this document](https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html#boot-features-spring-mvc-favicon)).
- Automatic use of a `ConfigurableWebBindingInitializer` bean (covered [later in this document](https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/boot-features-developing-web-applications.html#boot-features-spring-mvc-web-binding-initializer)).

1. 自动配置了**ViewResolver**视图解析器，**view**视图对象决定如何渲染（转发、重定向）

2. **ContentNegotiatingViewResolver**:组合所有的视图解析器，我们可以自己添加一个视图解析器，**ContentNegotiatingViewResolver**会自动组合进容器中，例子

   ```java
     @Bean	//将该对象多为bean组件自动添加到容器中
       public ViewResolver myViewResolver(){
           return new  myViewResolver();
       }
       public static class myViewResolver implements ViewResolver {
           @Override
           public View resolveViewName(String s, Locale locale) throws Exception {
               return null;
           }
       }
   ```

   ![1562775033056](D:\typora\typora-user-images\1562775033056.png)


3. 自动注册了**Converter（转换器）`, `GenericConverter`,Formatter（格式化器）**


4. **HttpMessageConverters**：SpringMVC用来转换HTTP请求和响应的；	将对象以JSON方式写出去（user ==>json）该对象是从容器中获取所有的消息转换器

5. **ConfigurableWebBindingInitializer**是从容器中取出来的



##### 如何修改SpringBoot的默认配置

1. SpringBoot在自动配置的时候，先看容器中是否有用户自己配置的 **Bean、component**组件，如果没有，就自动配置，有些组件（如视图解析器）可以有多个和用户配置的组合使用

2. **拓展SpringMVC **

   ```java
      <mvc:interceptors>
           <mvc:interceptor>
               <mvc:mapping path="/hello"/>
               <bean></bean>
           </mvc:interceptor>
       </mvc:interceptors>
   ```

   编写一个带有**@Configuration**配置类（会自动添加到容器中），**是@WebMvcAutoConfiguration**类型的（继承该父类），不能标注**@enableWebMvc**

   既保留了自动配置，也能拓展我们的设置

   ```java
   @Configuration
   public class MyMvcConfig  extends WebMvcConfigurerAdapter implements WebMvcConfigurer {
       @Override
       public void addViewControllers(ViewControllerRegistry registry) {
           //浏览器发送请求(无携带数据,只是请求).跳转到指定页面
           registry.addViewController("/helloWorld").setViewName("success");
       }
   }
   ```

   ##### **原理：**

   - ***@WebMvcAutoConfiguration***是SpringMVC的自动配置类

3. **@EnableWebMVC**：全面接管SpringMVC，所有的配置都要自己配置，SpringBoot的自动配置MCVC就会失效



##### 国际化

1. **编写国际化配置文件**

   ![1562834618362](D:\typora\typora-user-images\1562834618362.png)


2. SpringBoot实现了自动配置国际化的组件

   ![1562837508611](D:\typora\typora-user-images\1562837508611.png)

3. 国际化区域对象（Local区域信息对象），LocaleResolver（作用就是获取区域对象）

   默认就是通过url请求头来获取Local进行国际化

   **<http://localhost:8080/index?l=zh_CN‘>**		**<http://localhost:8080/index?l=en_US>切换英文**

4. **最主要的步骤是如下**

   ```html
   //通过th：href将国际化区分的请求头发送到后台
   <p class="mt-5 mb-3 text-muted">© 2017-2018</p>
   <a class="btn btn-sm" th:href="@{/index(l='zh_CN')}">中文</a>
   <a class="btn btn-sm" th:href="@{/index(l='en_US')}">English</a>
   ```

   解析从前台发送的url请求头发过来的国际化区分请求头

   ```java
     /**
        * 解析区域信息
        * @param httpServletRequest
        * @return
        */
       @Override
       public Locale resolveLocale(HttpServletRequest httpServletRequest) {
           //获取参数的值(l)
           String l = httpServletRequest.getParameter("l");
           //如果链接上带了l=zh_CN或l=en_US,就是用数组中的结果,没有的话就是用默认的
           Locale locale = Locale.getDefault();
           if (!StringUtils.isEmpty(l)) {
               //如果不为null就从青苔获取到区域信息,
              /*
              *  根据_进行分割,index?l=zh_CN zh是中文,CN是国家
              * */
               String[] split = l.split("_");
               //数组下标为0的是语言代码,1的是国家代码
               locale = new Locale(split[0], split[1]);
           }
           return locale;
       }
   ```

   将自定义的国际化解析类通过**@Bean**的方式添加到容器中使用

##### 

##### SpringBoot 的web登录实例

**@RequestParam（"username"）：**指定从请求参数中查找域中指定的值，没有查找到指定的值，就会抛异常

**th:action**：指定提交的地址



###### 拦截器

*LoginHandleInterceptor实现HandlerInterceptor接口*

作用就是:通过登录页面登录成功后跳转到指定页面，通过指定页面的url地址可以直接访问该页面，这在业务逻辑上极度不允许的，这时候就需要拦截器的作用了，用户不通过登录是无法访问后台请求的

**拦截器进行登录检查，验证通过才允许访问页面**



##### RestFul风格

URI：/资源名称/资源标识	，用请求方式来区分对资源的CRUD操作

|      | 普通请求             | RestFul           |
| ---- | ---------------- | ----------------- |
| 查询   | getEmp           | emp - GET         |
| 添加   | addEmp           | emp - POST        |
| 修改   | updateEmp?id=xxx | emp/{id} - PUT    |
| 删除   | deleteEmp/id=1   | emp/{id} - delete |

**Model**:放在请求域中，页面共享

**thymleaf公共页面抽取（复制）**

***~{templatename::fragmentname}  模板名：： 片段名，模板名可以是被抽取内容的html名，片段名是被抽取内容的名字***

*th:fragment抽取出来的内容是公共的，可以在其他页面使用*

```html
#抽取内容
<div th:fragment="copy">
&copy; 2011 The Good Thymes Virtual Grocery
</div>

#重用插入页面
<div th:insert="~{footer :: copy}"></div>
```

有三种引入公共页面的方法

<div th:insert="footer :: copy"></div>	//将公共页面直接插入到元素中
<div th:replace="footer :: copy"></div>	//将声明的元素替换为公共片段
<div th:include="footer :: copy"></div> 	//被引入的片段包含在片段中
**@PathVariable：**当使用@RequestMapping URI template 样式映射时， 即 someUrl/{paramId}, 这时的paramId可通过 @Pathvariable注解绑定它传过来的值到方法的参数上。*将id绑定到请求方法的参数上*



##### Springboot的错误提示

1. **DefaultErrorAttributes**

   帮我们页面共享信息

2. ***BasicErrorController：***处理默认：/error/4xx5xx请求

   1. *类中有**errorHtml**和**error***两个方法，

      errorHtml产生的是html类型的数据，浏览器发送的请求会到这个方法

      error产生的是json数据，其他客户端会来到这个方法

      ```java 
      public ModelAndView errorHtml(HttpServletRequest request, HttpServletResponse response) {
          HttpStatus status = this.getStatus(request);
          Map<String, Object> model = Collections.unmodifiableMap(this.getErrorAttributes(request, this.isIncludeStackTrace(request, MediaType.TEXT_HTML)));
          response.setStatus(status.value());
        //调用解析错误页面的方法  
          ModelAndView modelAndView = this.resolveErrorView(request, response, status, model);
          return modelAndView == null ? new ModelAndView("error", model) : modelAndView;
   }
      @RequestMapping
      @ResponseBody
      public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
          Map<String, Object> body = this.getErrorAttributes(request, this.isIncludeStackTrace(request, MediaType.ALL));
          HttpStatus status = this.getStatus(request);
          return new ResponseEntity(body, status);
      }
      ```
      
   2. 响应页面的解析

      ```java
       protected ModelAndView resolveErrorView(HttpServletRequest request, HttpServletResponse response, HttpStatus status, Map<String, Object> model) {
              Iterator var5 = this.errorViewResolvers.iterator();
              ModelAndView modelAndView;
              do {
                  if (!var5.hasNext()) {
                      return null;
                  }
                  ErrorViewResolver resolver = (ErrorViewResolver)var5.next();
                  modelAndView = resolver.resolveErrorView(request, status, model);
              } while(modelAndView == null);
      
              return modelAndView;
          }
      ```

3. **ErrorPageCustomizer**：

4. **DefaultErrorViewResolver**：决定了错误的页面走向

   ```java
    public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
           ModelAndView modelAndView = this.resolve(String.valueOf(status), model);
           if (modelAndView == null && SERIES_VIEWS.containsKey(status.series())) {
               modelAndView = this.resolve((String)SERIES_VIEWS.get(status.series()), model);
           }
           return modelAndView;
       }
   //模板引擎可以调用
       private ModelAndView resolve(String viewName, Map<String, Object> model) {
           String errorViewName = "error/" + viewName;
           TemplateAvailabilityProvider provider = this.templateAvailabilityProviders.getProvider(errorViewName, this.applicationContext);
           //模板引擎不可用的时候，在静态资源文件夹下找对应的错误提示页面，也就是error/html
           return provider != null ? new ModelAndView(errorViewName, model) : this.resolveResource(errorViewName, model);
       }
   
   ```

   ###### 自定义错误提示页面

   *tyhmeleaf 的静态资源都是妨碍templates文件夹下*

   1. 有模板引擎的情况下 ：error/状态码.html	 会跳转到 ***templates***下的error文件夹中的页面

      页面能获取的信息

      timestamp：时间戳

      status：状态码

      error错误提示

      exception：异常信息

      message：异常消息

      errors：JSR303数据校验的错误

   2. 在没有模板引擎的情况下，也是在静态资源文件夹下



##### 自定义的错误提示信息

1. 自定义的异常类返回定制的消息提示，继承 **RuntimeException**运行期异常才能打展示出来

   ```java 
   
   public class UserNotExistException extends RuntimeException {
       public UserNotExistException() {
          super("用户不存在");
       }
   }
   ```

   ```java
       @ExceptionHandler(UserNotExistException.class)
       public String handleException(Exception e, HttpServletRequest request){
           Map<String,Object> map = new HashMap<>();
           //传入我们自己的错误状态码  4xx 5xx
           // Integer statusCode = 		(Integer)request.getAttribute("javax.servlet.error.status_code");获取错误状态码
           request.setAttribute("javax.servlet.error.status_code",500);
           map.put("code","user.notexist");
           map.put("message","用户出错啦");
           request.setAttribute("ext",map);
           //转发到/error，Springboot就会根据自动配置自适应将JSON数据填充到html页面
           return "forward:/error";
       }
   ```

   ***传入错误状态码，Springboot会根据自定义配置错误页面的规则，将错误消息提示数据渲染到指定的4xx，5xx提示页面***

2. 自定义 **ErrorAttributes**添加自己的错误表达数据格式



##### 配置嵌入式Servlet容器

*在我们启动Springboot项目的时候，并没有配置外部的Tomcat服务器，而是使用的是内置的Tomcat，使用内置的Tomcat相较于外部的运行速度更快更稳定，Springboot默认使用的是嵌入式的Tomcat容器*

![](/TIM截图20190714102259.png)

在application.properties文件中可以修改内置Servlet容器的一些配置（**Server有关的配置**）

###### 注册Servlet的三大组件

***ServletRegistrationBean,FilterRegistrationBean（拦截器）,ServletListenerRegistrationBean（监听器）***

默认的Springboot是没有web.xml。webapp等文件的，*注册三大组件的方式如下*:

1. Servlet

   ```java
     	@Bean
       public ServletRegistrationBean myServlet(){
           //注册自定义的Servlet，访问路径是/myServlet
           ServletRegistrationBean registrationBean = new ServletRegistrationBean(new MyServlet(),
                   "/myServlet");
           registrationBean.setLoadOnStartup(1);
           return registrationBean;
       }
   ```

2. ###### filter

   ```java
   	@Bean
       public FilterRegistrationBean myFilter(){
           FilterRegistrationBean registrationBean = new FilterRegistrationBean();
           registrationBean.setFilter(new MyFilter());
           //拦截指定请求，封装为一个list数组
           registrationBean.setUrlPatterns(Arrays.asList("/hello","/myServlet"));
           return registrationBean;
       }
   ```

3. listener

   ```java
   	@Bean
       public ServletListenerRegistrationBean myListener(){
           ServletListenerRegistrationBean<MyListener> registrationBean = new
                   ServletListenerRegistrationBean<>(new MyListener());
           return registrationBean;
       }
   ```

   ***注：每一个注册组件都对应一个实例类，可以在实例中配置内容，在注册类中注册***

   ###### **DispatcherServlet**

   Springboot在Starter场景启动器中通过*DispatcherServletAutoConfiguration*自动注册了*DispatcherServlet*控制器

   ```java
    public ServletRegistrationBean dispatcherServletRegistration(DispatcherServlet dispatcherServlet) {
               ServletRegistrationBean registration = new
               				ServletRegistrationBean(dispatcherServlet, new String[
               				{this.serverProperties.getServletMapping()});
               registration.setName("dispatcherServlet");
               //默认是拦截所有的路径 /*会拦截JSP
            	//server.servlet-path=/ 修改dispatcherServlet拦截的请求
               registration.setLoadOnStartup(this.webMvcProperties.                                                          		 getServlet().getLoadOnStartup());
               if (this.multipartConfig != null) {
                   registration.setMultipartConfig(this.multipartConfig);
               }
   
               return registration;
           }
   ```

   ##### Springboot支持其他Servlet容器

   **Tomcat**（默认）

   **Jetty**（长连接，两个用户之间会建立长时间的连接，微信电话）

   **undertow**（不支持JSP）

   使用其他的Servlet容器，首先要将默认的Tomcat引用移除，添加自己的Servlet容器

   ```java
   	##移除Tomcat	
   	<dependency>
   			<groupId>org.springframework.boot</groupId>
   			<artifactId>spring-boot-starter-web</artifactId>
   			<exclusions>
   				<exclusion>
					<artifactId>spring-boot-starter-tomcat</artifactId>
   					<groupId>org.springframework.boot</groupId>
   				</exclusion>
   			</exclusions>
   		</dependency>	
   <!--引入其他的Servlet容器-->	
   		<!--<dependency>
   			<artifactId>spring-boot-starter-undertow</artifactId>
   			<groupId>org.springframework.boot</groupId>
   		</dependency>-->
   ```
   

##### 嵌入式的Servlet容器配置原理

***EmbeddedServletContainerAutoConfiguration***类

```java
@AutoConfigureOrder(-2147483648)
@Configuration
@ConditionalOnWebApplication
@Import({EmbeddedServletContainerAutoConfiguration.BeanPostProcessorsRegistrar.class})
public class EmbeddedServletContainerAutoConfiguration {
```

```java
@Configuration
    @ConditionalOnClass({Servlet.class, Tomcat.class}) //判断是否引入Servlet依赖和Tomcat依赖
    @ConditionalOnMissingBean(
        value = {EmbeddedServletContainerFactory.class},
        search = SearchStrategy.CURRENT
    )//判断当前用户没有用户自定义的Servlet容器工厂
    public static class EmbeddedTomcat {
        public EmbeddedTomcat() {
        }

        @Bean
        public TomcatEmbeddedServletContainerFactory tomcatEmbeddedServletContainerFactory() {
            return new TomcatEmbeddedServletContainerFactory();
        }
    }
```

**EmbeddedServletContainerFactory**：嵌入式Servlet工厂

```java
//获取嵌入式Servlet容器
public interface EmbeddedServletContainerFactory {
    EmbeddedServletContainer getEmbeddedServletContainer(ServletContextInitializer... var1);
}
```

![](/QQ浏览器截图20190714150211.png)



##### 嵌入式Servlet容器的优缺点

内置Servlet容器是以jar包的形式

*优点*：简单便携

*缺点*：默认不支持JSP，优化定制比较复杂

*外置的Servlet容器（Tomcat）*：外部安装Tomcat服务器，以war包的形式打包

步骤：

1. 创建一个war项目

2. 将Tomcat的运行指定为provide,不需要在打包的时候带上Tomcat环境

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-tomcat</artifactId>
       <scope>provided</scope>
   </dependency>
   ```

3. 必须有一个实现 *SpringBootServletInitializer*接口的子类（Servlet初始化器）

   （可能是因为使用的是外部的Tomcat服务器，因此）

```java 
public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        //传入主程序的class文件
		return application.sources(SpringbootTomcatJspDemoApplication.class);
	}

}
```



##### 执行原理

jar包的形式：执行Springboot的主方法，启动IOC容器，会创建一个IOC容器

war包的形式		：启动外部服务器，服务器启动SpringBootServletInitializer，启动IOC容器

Springboot-web模块中的META-INF/service中有一个文件：**org.springframework.web.SpringServletContainerInitializer**，指向Spring的Servlet容器初始化器，Springboot在启动项目的时候，加载到Web模块的时候，会根据这个路径找到初始化器，*而项目中自定义的ServletInitializer就是继承于该接口*

![](/搜狗截图20190714171131.png)

*ServletInitializer*继承SpringServletContainerInitializer中有一个onStartup方法

```java 
   public void onStartup(ServletContext servletContext) throws ServletException {
        this.logger = LogFactory.getLog(this.getClass());
       //创建了根容器
        WebApplicationContext rootAppContext = this.createRootApplicationContext(servletContext);
        if (rootAppContext != null) {
            servletContext.addListener(new ContextLoaderListener(rootAppContext) {
                public void contextInitialized(ServletContextEvent event) {
                }
            });
        } else {
            this.logger.debug("No ContextLoaderListener registered, as createRootApplicationContext() did not return an application context");
        }
    }
```

*createRootApplicationContext*方法详解

首先会构建*SpringApplicationBuilder*构建器，子类（上文的ServletInitializer构建器）重写了这个方法，将Springboot的主程序传入后，构建会构建Spring应用，然后直接启动Springboot应用，Tomcat服务器已经在IOC容器启动之前已经启动了，这时候Springboot项目就已经启动了



*****



##### Springboot和docker

简介：[Docker](<https://baike.baidu.com/item/Docker>) 是一个[开源](https://baike.baidu.com/item/开源/246339)的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的镜像中，然后发布到任何流行的 [Linux](https://baike.baidu.com/item/Linux)或Windows 机器上，也可以实现[虚拟化](https://baike.baidu.com/item/虚拟化/547949)。容器是完全使用[沙箱](https://baike.baidu.com/item/沙箱/393318)机制，相互之间不会有任何接口。

docker和虚拟机类似，***docker在安装的时候，把原始环境一模一样地复制过来。***

###### 虚拟机的优缺点

**虚拟机**（virtual machine）就是带环境安装的一种解决方案。它可以在一种操作系统里面运行另一种操作系统，比如在 Windows 系统里面运行 Linux 系统。应用程序对此毫无感知，因为虚拟机看上去跟真实系统一模一样，*而对于底层系统来说，虚拟机就是一个普通文件*，不需要了就删掉，对其他部分毫无影响。

***缺点***：

**（1）资源占用多**

**（2）冗余步骤多**

**（3）启动慢**



###### Linux容器

由于虚拟机存在这些缺点，Linux 发展出了另一种虚拟化技术：***Linux 容器***（Linux Containers，缩写为 LXC）。**Linux 容器不是模拟一个完整的操作系统，而是对进程进行隔离**，对于容器里面的进程来说，**它接触到的各种资源都是虚拟的，从而实现与底层系统的隔离**

***优点***

**（1）启动快**

**（2）资源占用少**

**（3）体积小**



###### Docker的简介

**Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。**它是目前最流行的 Linux 容器解决方案

Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个***虚拟容器***。容器还可以进行版本管理、复制、分享、修改，就像管理普通的代码一样

***Docker 的主要用途***

**（1）提供一次性的环境。**比如，本地测试他人的软件、持续集成的时候提供单元测试和构建的环境。

**（2）提供弹性的云服务。**因为 Docker 容器可以随开随关，很适合动态扩容和缩容。

**（3）组建微服务架构。**通过多个容器，一台机器可以跑多个服务，因此在本机就可以模拟出微服务架构。

**例如：**在一台机器上配置好的redis应用程序和相关环境，将这个机器的应用程序和环境配置打包成一个docker镜像文件，只要在另一个机器上安装了docker，在这台机器的docker容器中直接运行镜像文件，这个运行的redis镜像就相当于这台机器的redis容器，无需用户配置过多的环境变量

开发者将软件编译一个镜像，然后在镜像中做好各种配置，其他使用者可直接使用这个镜像文件



##### 核心概念

- docker主机（Host）：物理的或是虚拟的机器，用来执行docker守护进程和容器，是安装在操作系统里

- docker客户端（Client）：连接docker主要与守护进程进行通信

- docker仓库：保存各种打包好的软件和镜像，[Docker Hub](<https://hub.docker.com/>)提供了大量的精选集合使用

- docker镜像（images）：软件打包好的镜像

- docker（container）：镜像文件启动后的实例被称之为是一个容器，容器是独立运行的一个或一组应用

  ![](/搜狗截图20190715145029.png)

运行docker镜像后，会产生一个容器

*docker是一个软件，docker容器是一个镜像文件实例，关闭容器就是关闭docker*



##### Linux查看ip地址

![](/搜狗截图20190715173311.png)

**本机ip地址**

![](/搜狗截图20190715173807.png)

Linux虚拟机和主机是在同一个网段下

![](/搜狗截图20190715175437.png)



**docker必须运行在内核为3.1.0以上Linux系统上**，在Linux安装docker命令

![菜鸟教程](/搜狗截图20190716093608.png)



***yum***下载的软件和镜像文件在*/var/cache/yum*目录下

```properties
yum clean headers  #清理/var/cache/yum的headers
yum clean packages #清理/var/cache/yum下的软件包
yum clean, yum clean all (= yum clean packages; yum clean oldheaders) :清除缓存目录下的软件包及旧的headers
```

 

***docker的详细命令*** ：[Docker常用命令](https://segmentfault.com/a/1190000012063374)

![]()

**容器操作**

![](/搜狗截图20190716144700.png)

**启动端口映射的Tomcat服务器**

*docker run -d -p 8888:8080 tomcat:9.0*：-d：后台运行	-p端口映射 	8888:8080 虚拟机的端口号和服务器容器端口号的映射

![](/搜狗截图20190716151734.png)

前提是防火墙要关闭或者对端口映射

![](/搜狗截图20190716152056.png)

一个镜像可以启动多个容器

**启动mysql数据库**：

```shell
 docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6
```

至少要携带一个参数 -e -d 后台运行

*这时候容器外界还是无法访问的，要为容器分配一个端口映射*

![](/搜狗截图20190716161420.png)

**搜索命令**

 *docker search mysql*：会在docker远程仓库（ [docker hub](https://hub.docker.com/)）所有mysql的镜像文件

*docker pull myslq:5.7.26*：搜索镜像（可以指定镜像版本）



****



##### Spirngboot 数据访问

关系型数据（SQL）和非关系型数据库（NoSql）。默认是使用Spring Date为数据库访问技术

**Springboot访问数据库**

*只需要在Springboot的配置文件中配置数据库的相关配置，**默认是使用Tomcat数据源***

```yml
spring:
  datasource:
    url: jdbc:mysql://192.168.1.102:3306/jdbctest
    username: root
    password: 123456
    driver-class-name: com.mysql.jdbc.Driver
```



##### 自动配置原理

```java
@Configuration
//在容器中有Tomcat数据源class文件的时候，才会生成DataSource
@ConditionalOnClass({org.apache.tomcat.jdbc.pool.DataSource.class})
@ConditionalOnMissingBean({DataSource.class})
@ConditionalOnProperty(
    name = {"spring.datasource.type"},
    havingValue = "org.apache.tomcat.jdbc.pool.DataSource",
    matchIfMissing = true
)
static class Tomcat {
    Tomcat() {
    }
    //根据prefix来自定义数据源
    @Bean
    @ConfigurationProperties(
        prefix = "spring.datasource.tomcat"
    )
    public org.apache.tomcat.jdbc.pool.DataSource dataSource(DataSourceProperties properties) {
        org.apache.tomcat.jdbc.pool.DataSource dataSource = (org.apache.tomcat.jdbc.pool.DataSource)DataSourceConfiguration.createDataSource(properties, org.apache.tomcat.jdbc.pool.DataSource.class);
        DatabaseDriver databaseDriver = DatabaseDriver.fromJdbcUrl(properties.determineUrl());
        String validationQuery = databaseDriver.getValidationQuery();
        if (validationQuery != null) {
            dataSource.setTestOnBorrow(true);
            dataSource.setValidationQuery(validationQuery);
        }
        return dataSource;
    }
```

其他的数据源（dbcp，c3p0等）都是类似的配置

```java
  @Configuration
    @ConditionalOnMissingBean({DataSource.class})
    @ConditionalOnProperty( name = {"spring.datasource.type"})
    static class Generic {
        Generic() {
        }
        @Bean
        public DataSource dataSource(DataSourceProperties properties) {
            //建造者模式创建数据源
            return properties.initializeDataSourceBuilder().build();
        }
    }
```



**手动配置引入的其他连接池默认不会与DataSourceProperties中的文件映射上去**

```java
@Configuration
public class DataSourceDriudConfig {
    @ConfigurationProperties(prefix = "spring.datasource")	//将yml文件中的DataSource属性全部添加到容器中
    @Bean
    public DataSource druid(){
        return new DruidDataSource();
    }
   ......

```

***Druid连接池的配套数据源监控实现***

```java
/**
 * 配置管理后台的servlet
 */
@Bean
public ServletRegistrationBean staViewServlet(){
    ServletRegistrationBean bean = new ServletRegistrationBean(new StatViewServlet(), "/druid/*");
    Map<String, String> initParams = new HashMap<>();
    initParams.put("loginUserName","admin");
    initParams.put("loginPassword", "123456");
    //默认是允许所有访问
    initParams.put("allow", "");
    return bean;
}
/**
 * 拦截器配置
 */
@Bean
public FilterRegistrationBean webStaFilter(){
    FilterRegistrationBean bean = new FilterRegistrationBean();
    bean.setFilter(new WebStatFilter());
    Map<String, String> initParams = new HashMap<>();
    initParams.put("exclusions", "*.js, *css, /druid/*");	//设置不拦截的属性
    bean.setInitParameters(initParams);
    bean.setUrlPatterns(Arrays.asList("/*"));
    return bean;
}
```



****



##### Springboot和mybatis的整合 

引入***mybatis-spring-boot-starter***场景启动器jar包

![](/搜狗截图20190717113639.png)



**配置SQL脚本**

注：***yml有严格的语法，空格极为敏感，- 是list集合，classpath中不能有空格***

```yml
schema:
  - classpath:sql/department.sql
  - classpath:sql/employee.sql
```

##### 注解版

```java
@RestController
public class DeptController
{
    @Autowired
    DepartmentMapper departmentMapper;

    @GetMapping("/dept/{id}")
    public Department getDepartment(@PathVariable("id") Integer id){
        return departmentMapper.getDeptById(id);
    }

    @GetMapping("dept")
    public Department insertDept(Department department) {
        departmentMapper.insertDept(department);
        return department;
    }
}
```

***@MapperScan(value = "com.sunny.springboot.mapper")***:全局扫描mapper接口

mybatis的配置文件，作用和Spring中的配置文件是大致相同的

```yml
mybatis:
  config-location: classpath:mybatis/mybatis-config.xml
  mapper-locations: classpath:mybatis/mapper/*.xml
```



****

Springboot Data JPA

- 简化数据库访问技术，提供统一的API来对数据层进行操作，***Repository***接口包含了基本的CRUD和分页排序乐观锁等功能，继承 ***Repository***接口就能使用这些方法
- 提供数据访问模板类（template）



##### 整合Springboot Data JPA数据访问技术

实体层和数据库的相关映射配置

```java
@Entity
@Table(name = "tb_user")
public class User {
    /**
     * 自增id，主键
     * 省略，默认列名就是属性名
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "username", length = 50)
    private String username;
    
    @Column
    private String email;
```

继承Repository或者其子类的接口用于基本的CRUD操作

```java 
 * 操作数据表的接口
 * 继承JpaRepository，就有了基本的CRUD和分页功能
 */
public interface UserRepository extends JpaRepository<User,Integer> {
}

```

在全局配置文件中配置

```xml
  jpa:
    hibernate:
	   #更新或是创建数据表，如果数据库中不存在表的话就会自动创建，如果有且发生了变化，就会更新操作
      ddl-auto: update
	 #控制台显示SQL
    show-sql: true*
```



**启动流程**

- 创建并运行SpringApplication对象

  ```java
  private void initialize(Object[] sources) {
      //source就是主配置类
      if (sources != null && sources.length > 0) {
          this.sources.addAll(Arrays.asList(sources));
      }
      //判断是否是web应用
      this.webEnvironment = this.deduceWebEnvironment();                  this.setInitializers(this.getSpringFactoriesInstances(ApplicationContextInitializer.class));
          this.setListeners(this.getSpringFactoriesInstances(ApplicationListener.class));
          this.mainApplicationClass = this.deduceMainApplicationClass();
  ```

  

****

clone下maven项目后，可以直接cd 项目名跳转到该maven项目，执行mvn flyway:migrate -Pdev，项目运行数据库脚本，***mvn clean compile package***执行java文件打成jar包

*****



创建一个配置文件用于保存密码

***git config --global credential.helper store***

