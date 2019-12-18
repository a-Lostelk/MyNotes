---

typora-root-url: codingImages
---

# coding社区笔记

### `@RequestParam` 和 `@PathVariable` 注解的区别

- 相同点：用于从request中接收请求的，两个都可以接收参数
- 不同点：`@RequestParam` 是从request里面拿取值，而 `@PathVariable` 是从一个URI模板里面来填充

#### @RequestParam

```java
public String getDetails(
    @RequestParam(value="param1", required=true) String param1,
        @RequestParam(value="param2", required=false) String param2){
...
}
//是直接从请求域中根据key获取value值
```

有四个参数

- **defaultValue** 如果本次请求没有携带这个参数，或者参数为空，那么就会启用默认值
- **name** 绑定本次参数的名称，要跟URL上面的一样
- **required** 这个参数是不是必须的
- **value** 跟name一样的作用，是name属性的一个别名

#### @PathVariable

```java
@RequestMapping("/hello/{id}")
    public String getDetails(@PathVariable(value="id") String id,
    @RequestParam(value="param1", required=true) String param1,
    @RequestParam(value="param2", required=false) String param2){
.......
}
//是从请求的URL中获取的参数@RequestMapping("/hello/{id}")
```



### Git

***git init***:当前文件夹初始化，能被Git所识别

***git add .***将文件夹中的所有文件都添加到暂存区中

***git status***：查看Git的状态，当前文件夹是否有需要添加的Git文件

***git commit -m"init repo"***：将暂存区中的添加到本地仓库中并添加一个备注

***git remote add origin git@github.com:a-Lostelk/milu3.git***：添加一个远程仓库地址

***git push -u origin master***：将本地仓库推送到名字为origin（上面的地址）远程仓库中

***git commit --amend --no-edit***：提交追加被改变的文件，当有文件被被改变的时候，需要使用这个问价将被追加的内容追加到本地仓库



------

### github授权登录

#### 开放授权

**开放授权**（OAuth）是一个[开放标准](https://zh.wikipedia.org/wiki/开放标准)，允许用户让第三方应用访问该用户在某一网站上存储的私密的资源（如照片，视频，联系人列表），而无需将用户名和[密码](https://zh.wikipedia.org/wiki/密码)提供给第三方应用。

#### 步骤

1. GitHub主页中的settings中developer settings中创建开放授权应用（[OAuth Apps](https://github.com/settings/developers) ）

   ![](/搜狗截图20190721210338.png)


2. 页面的请求中会携带以下几个参数

   - ***client_id***：创建GitHub授权管理应用的时候自动生成的一个token令牌
   - ***redirect_uri***：转发到指定的URL，GitHub注册授权管理时候添加的callbackURL
   - ***scope***：获取的列表范围，这里只需要获取用户信息
   - ***state***：状态码

   ```html
   <!--调用GitHub的接口-->
   <a href="https://github.com/login/oauth/authorize?client_id=392c25cb6564a22b7cf6&redirect_uri=http://localhost:8081/callback&scope=user&state=1">登录</a>
   ```

   ![](/搜狗截图20190721211658.png)

3. 启动服务后跳转本地地址后会获取到GitHub的授权响应（调用authorize）

4. GitHub中创建access token并选择scope为user（只获取user的信息）

5. 测试调用API根据access_token能否获取到GitHub上用户的基本信息（必须在已知用户的access_token令牌的前提下）

   




### *@Component*和*controller*

区别

- ***@Controller***是运用在控制层，就是action层；
- ***@Component***可以放在任何层，当不确定的时候都可以使用；

***@Component***将当前的类初始化到spring容器中的上下文环境中



### Cookies和Session状态保存

- 从request域中写入session

```java
if (user != null) {
    //登录成功写入cookies和session
    request.getSession().setAttribute("user", user);
    //页面跳转，redirect跳转的是路径
    return "redirect:/";
} else {
    return "redirect:/";
}
```



- index.html页面通过thymleaf模板引擎获取session对象中的user属性

  ```html
   <!--如果没有session就显示登录按钮,thLif中的条件成立了才会显示元素的内容-->
  <li th:if="${session.user == null}">
  <a href="https://github.com/login/oauth/authorize?client_id=392c25cb6564a22b7cf6&redirect_uri=http://localhost:8081/callback&scope=user&state=1">
  登录</a>
  </li>
  ```

- 首次登录成功后会在后台执行一次数据库写入操作保存用户的基本信息

```java
if (githubUser != null) {
    //将获取到的GitHub用户信息写入到数据库
    User user = new User();
    String token = UUID.randomUUID().toString();
    user.setToken(token);
    user.setName(githubUser.getName());
    user.setGmtCreate(System.currentTimeMillis());
    user.setGmtModified(user.getGmtModified());
    userMapper.insert(user);	//保存用户信息数据
    //使用随机生成的Token作为cookies数据
    Cookie cookie = new Cookie("token", token);
    cookie.setMaxAge(60 * 60 * 24 * 7);
    response.addCookie(cookie);
    /*request.getSession().setAttribute("user", githubUser);*/
    //页面跳转，redirect跳转的是路径
    return "redirect:/";
} else {
    return "redirect:/";
}

```



- 在跳转到主页的时候会从请求域中取出cookie值，通过数据库查询操作查找是否有对应的token信息，如果存在创建一个新的session会话，下次刷新访问的时候

```java
 @GetMapping("/")
public String index(HttpServletRequest request) {
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if ("token".equals(cookie.getName())) {
            String token = cookie.getValue();
            User user = userMapper.findUserByToken(token);
            if (user != null) {
                request.getSession().setAttribute("user", user);
            }
            break;
        }
    }
    return "index";
}
```



### 初始H2数据库

是一个JDBC的API

可以以jar包的方式引入，jar包中包含数据库连接驱动，h2 的数据库存储文件是以. db结尾，可以指定在硬盘的某个文件夹

#### 数据源

Springboot默认的数据源是[HikariCP](https://github.com/brettwooldridge/HikariCP)

- 使用`spring-boot-starter-jdbc`或`spring-boot-starter-data-jpa`“starters”，则会自动获得`HikariCP`的依赖关系。

- 通过设置`spring.datasource.type`属性指定要使用的自定义连接池。如果您在Tomcat容器中运行应用程序，这一点尤为重要，因为默认情况下会提供`tomcat-jdbc`

```properties
spring.datasource.url=jdbc:mysql://localhost/test
spring.datasource.username=dbuser
spring.datasource.password=dbpass
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```

***@Param 注解将形参中的非Java类参数绑定到SQL语句中***



### FlayWay数据库版本管理工具

自动更新数据库脚本，多人协同开发的时候，例如插入更新语句等时候只需要一句SQL脚本就能更新数据库

##### 步骤

- 创建一个migration文件夹存放需要改动的脚本`src/main/resources/db/migration`.
- 以`V1__Create_person_table.sql`这样的命名方式创建一个数据库脚本
- 控制台执行maven命令`mvn flyway:migrate`,自动扫描执行一个脚本



### Bootstrap相关知识

[bootstrap参考文档](https://v3.bootcss.com/css/)

**Bootstrap **的栅格系统可以应对不同屏幕大小的尺寸，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多12列

页面在不同大小的屏幕被缩放的时候，原本左右的页面布局会变成上下的显示，而显示的宽度也是屏幕的宽度` col-md-12 col-sm-12 col-xs-12`



```html
 <!--针对不同屏幕的尺寸-->
<div class="clo-lg-9 col-md-12 col-sm-12 col-xs-12"></div>
<div class="clo-lg-3"></div>
```



### lombok

Lombok能以简单的注解形式来简化java代码，提高开发人员的开发效率。例如开发中经常需要写的javabean，都需要花时间去添加相应的getter/setter，也许还要去写构造器、equals等方法，而且需要维护，当属性多时会出现大量的getter/setter方法，这些显得很冗长也没有太多技术含量，一旦修改属性，就容易出现忘记修改对应方法的失误。

#### 1. @Data

@Data注解在类上，会为类的所有属性自动生成setter/getter、equals、canEqual、hashCode、toString方法，如为final属性，则不会为该属性生成setter方法。



在javaweb的开发中，由于持久层是对应的一个单独的实体类，如果存在多表共同组装数据的时候，这个时候就需要使用DTO层（***专门用于数据传输的层***），好处是不用多次在数据库中建立外键和关联，DTO数据封装数据传输并不会影响到实体表的数据和字段

```java
//利用工具类，快速的将question中的工具类拷贝到DTO类中
BeanUtils.copyProperties(question, questionDTO);
```



### mybatis的驼峰映射

数据库中的字段和实体类中的字段可能在大小写和_会有区分，在Springboot项目中需要开启驼峰命名匹配

```xml
#开启驼峰命名
mybatis.configuration.map-underscore-to-camel-case=true
```

***contains***当且仅当此字符串包含指定的 char 值序列时，返回 true。

***equals***指示其他某个对象是否与此对象“相等”。



### 首页展示功能

- 判断访问页面是否有cookies缓存对象，如果有发送请求到后台验证是否已登录用户，不存在cookies会展示登录按钮登录，同时查询question表中用户发表数据通过封装到model对象中发送页面并展示在页面中

  ```java
  Cookie[] cookies = request.getCookies();
  if (cookies != null && cookies.length != 0) {
      for (Cookie cookie : cookies) {
          if ("token".equals(cookie.getName())) {
              String token = cookie.getValue();
              User user = userMapper.findUserByToken(token);
              if (user != null) {
                  request.getSession().setAttribute("user", user);
              }
              break;
          }
      }
  }
  List<QuestionDTO> questionList = questionService.list();
  model.addAttribute("questions",questionList);
  return "index";
  ```

- thymleaf的th：each标签将model对象foreach循环到一个question中，然后在页面中显示

  ```html
  <div class="media" th:each="question : ${questions}">
      <div class="media-left">
          <a href="#">
              <img class="media-object img-thumbnail" th:src="${question.user.avatarUrl}"><!--头像-->
          </a>
      </div>
  ```

  *th:text="${#dates.format(question.gmtCreate,' yyyy MM-dd hh:mm')}"*: 将后台发送的时间戳转换成对应的数据格式



### 分页功能实现细节

- 传入两个参数page（第几页）size（每页显示条数），根据参数进入到service层封装分页数据和mapper数据

```java
@GetMapping("/")
public String index(HttpServletRequest request,
                    Model model,
                    @RequestParam(name = "page", defaultValue = "1") Integer page,
                    @RequestParam(name = "size", defaultValue = "3") Integer size) {
```

- DTO是数据封装类，用于数据传输，不同于实体层对应的数据库字段，有根据需求添加的属性

```java
/**
 * Created by IntelliJ IDEA.
 *
 * @author: fang
 * @Date: 2019/7/27
 *
 * 展示前台数据包含分页数和当前页数等数据
 */
@Data
public class PaginationDTO {
    private List<QuestionDTO> questionDTO;
    private boolean showPrevious; //是否有上一页按钮
    private boolean showFirstPage;	//是否有首页功能
    private boolean showNext;	//是否展示下一页功能
    private boolean showEndPage;	//是否展示最后一页功能
    private Integer currentPage;	// 当前页码
    private List<Integer> pages;	//分页栏页码显示
    private Integer totalPage;	//总页数

    /**     
     * 实现分页的主要逻辑
     * @param totalCount  总数据记录数
     * @param size  每页显示数据
     * @param page  当前页码
     */
    public void setPagination(Integer totalCount, Integer size, Integer page) {
        pages = new ArrayList<>();
        //总页数（会出现一页数据只有一条不满size的情况，需要判断总页数）
        if (totalCount % size == 0) {
            totalPage = totalCount / size;
        } else {
            totalPage = totalCount / size + 1;
        }
        //将页面当前页码传入
        this.currentPage = page;
        /*
        * 向前展示三个页码和向后展示三个页码，当前页currentPage-3>0前面有三个页码，currentPage+3>totalPage总页数，就不在追加三个页码
        * 123 1234567 567
        * */
        pages.add(currentPage);
        for (int i = 1; i <= 3; i++) {
            if (page - i > 0) {
                pages.add(0,currentPage - i);
            }
            if (page + i <= totalPage) {
                pages.add(currentPage + 1);
            }
        }
        //是否展示上一页
        if (page == 1) {
            showPrevious = false;
        }else {
            showPrevious = true;
        }
        //是否展示下一页
        if (page == totalPage) {
            showNext = false;
        } else {
            showNext = true;
        }
        //是否展示第一页(pages分页数据中包含第一页的时候)
        if (pages.contains(1)) {
            showFirstPage = false;
        }else {
            showFirstPage = true;
        }
        //是否展示最后一页
        if (pages.contains(totalPage)) {
            showEndPage = false;
        }else {
            showEndPage = true;
        }
    }
}
```

- service层将查询数据和分页信息组装到一个对象中，数据库的偏移量比页面小以为，显示第一页的时候数据库偏移量是0

```java
Integer offset = size * (page - 1);
List<Question> questions = questionMapper.list(offset, size);
List<QuestionDTO> questionDTOList = new ArrayList<>();
```

- 页面接受model对象，从中取出值显示在页面的功能的模块上，具体业务和判断在DTO值判断了

  ```html

  <ul class="pagination">
      <!--第一页-->
      <li th:if="${pagination.showFirstPage}">
          <a  href="/?page=1" aria-label="firstPage">
              <span aria-hidden="true">&laquo;</span>
          </a>
      </li>
      <!--上一页-->
      <li th:if="${pagination.showPrevious}">
          <a  th:href="@{/(page=${pagination.currentPage - 1})}"aria-label="Previous">
              <span aria-hidden="true">&lt;</span>
          </a>
      </li>
      <li  th:each="page:${pagination.pages}" th:class="${pagination.currentPage == page}?'active' : ''">
          <a th:href="@{/(page=${page})}" th:text="${page}" ></a></li>
      <!--下一页-->
      <li  th:if="${pagination.showNext}">
          <a th:href="@{/(page=${pagination.currentPage + 1})}" aria-label="Next">
              <span aria-hidden="true">&gt;</span>
          </a>
      </li>
      <!--最后一页-->
      <li th:if="${pagination.showEndPage}">
          <a th:href="@{/(page=${pagination.totalPage})}" aria-label="lastPage">
              <span aria-hidden="true">&raquo;</span>
          </a>
      </li>
  </ul>

  ```


### 拦截器HandlerInterceptor

常见的用途：

1、日志记录：记录请求信息的日志，以便进行`信息监控`、信息统计、计算PV（Page View）等。
 2、权限检查：如`登录检测`，进入处理器检测检测是否登录，如果没有直接返回到登录页面；
 3、性能监控：有时候系统在某段时间莫名其妙的慢，可以通过拦截器在进入处理器之前记录开始时间，在处理完后记录结束时间，从而得到该请求的处理时间（如果有反向代理，如apache可以自动记录）；
 4、通用行为：读取cookie得到用户信息并将用户对象放入请求，从而方便后续流程使用，还有如提取Locale、Theme信息等，只要是多个处理器都需要的即可使用拦截器实现。
 5、OpenSessionInView：如Hibernate，在进入处理器打开Session，在完成后关闭Session。

需要**WebMvcConfigurerAdapter**对拦截器进行注册

- preHandle (HttpServletRequest request, HttpServletResponse response, Object handle) 方法，顾名思义，***该方法将在请求处理之前进行调用***。SpringMVC 中的Interceptor 是链式的调用的，在一个应用中或者说是在一个请求中可以同时存在多个Interceptor，最先执行的都是Interceptor 中的preHandle 方法，所以可以在这个方法中进行一些`前置初始化操作`或者是对当前请求的一个`预处理`

- postHandle (HttpServletRequest request, HttpServletResponse response, Object handle, ModelAndView modelAndView) 方法，顾名思义就是在当前请求进行处理之后，***也就是Controller 方法调用之后执行***，但是它会在DispatcherServlet 进行视图返回渲染之前被调用，所以我们可以在这个方法中对Controller 处理之后的ModelAndView 对象进行操作
- afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handle, Exception ex) 方法，顾名思义，***该方法将在整个请求结束之后***，也就是在DispatcherServlet 渲染了对应的视图之后执行。这个方法的主要作用是用于进行资源清理工作的 

在之前每次访问页面都有一段判断cookies是否登录的代码，重复不雅观，通过拦截器将这一模块抽离，以便在之后的场景中需要使用到session访问cookide的时候都可以直接访问拦截器，也正体现了面向切面编程的思想，

```java
 /**
     * preHandle 在页面加载之前开始执行
     */
    @Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    Cookie[] cookies = request.getCookies();
    if (cookies != null && cookies.length != 0) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                String token = cookie.getValue();
                User user = userMapper.findUserByToken(token);
                if (user != null) {
                    request.getSession().setAttribute("user", user);
                }
                break;
            }
        }
    }
    //默认是返回false的结果，当cookie验证存在的时候，返回true继续执行
    return true;
}
```

只需要***User user = (User) request.getSession().getAttribute("user")***获取Cookie域中的token



### 退出登录

移除客户端cookie域中的token值和服务器端的session值

```java
/**
 * 退出登录功能
 */
@GetMapping("/logout")
public String logout(HttpServletRequest request, HttpServletResponse response) {
    //根据session名移除
    request.getSession().removeAttribute("user");
    //重新创建一个为null的cookie，将setMaxAge生命周期设置0就是立马删除
    Cookie cookie = new Cookie("token", null);
    cookie.setMaxAge(0);
    response.addCookie(cookie);
    return "redirect:/";
}
```



### 编辑修改功能

使用的是和发布同一个页面，从主页跳转到详情页面，点击编辑携带详情页面的`唯一标识的ID`跳转到发布页面，后台接口中通过***getById（）***方法获取指定ID的问题信息，通过model对象回显到页面中，如果是不带ID的就是第一次发布，如果页面含有ID的就是编辑更新，就执行对应的方法

- 回显问题内容

  ```java
  @GetMapping("/publish/{id}")
  public String edit(@PathVariable(name = "id") Integer id, Model model) {
      Question question = questionMapper.getById(id);
      model.addAttribute("title", question.getTitle());
      model.addAttribute("description", question.getDescription());
      model.addAttribute("tags", question.getTags());
      model.addAttribute("id", id);
      return "publish";
  }
  ```

- 表单中添加ID标识（存在为更新，不存在为发布）

  ```html
  <form action="/publish" method="post" id="formPublish">
      <input type="hidden" name="id" th:value="${id}">
  <div class="form-group">
  ```




### Mybatis逆向工程IDEA使用

POM 文件中添加相关依赖

```
<plugin>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-maven-plugin</artifactId>
    <version>1.3.7</version>
    <dependencies>
    <!--依赖数据库驱动连接-->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <version>1.4.197</version>
    	</dependency>
	</dependencies>
</plugin>    
```

**generatorConfig.xml配置详解**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <!--<classPathEntry location="/Program Files/IBM/SQLLIB/java/db2java.zip" />-->

    <context id="DB2Tables" targetRuntime="MyBatis3">

        <!--数据库连接信息-->
        <jdbcConnection driverClass="org.h2.Driver"
                        connectionURL="jdbc:h2:~/community"
                        userId="sa"
                        password="123">
        </jdbcConnection>
        <!--true：使用BigDecimal对应DECIMAL和 NUMERIC数据类型，默认是false，根据实际情况选择数据类型-->
        <javaTypeResolver >
            <property name="forceBigDecimals" value="false" />
        </javaTypeResolver>
        <!--生成的模型类位置-->
        <javaModelGenerator targetPackage="com.majiang.community.model1" targetProject="src/main/java">
            <!--不存在时自动创建-->
            <property name="enableSubPackages" value="true" />
            <property name="trimStrings" value="true" />
        </javaModelGenerator>
        <!--MapperXML的生成位置-->
        <sqlMapGenerator targetPackage="mapper"  targetProject="src/main/resources">
            <property name="enableSubPackages" value="true" />
        </sqlMapGenerator>
        <!--接口的生成位置-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.majiang.community.mapper1"  targetProject="src/main/java">
            <property name="enableSubPackages" value="true" />
        </javaClientGenerator>
        <!--表名-->
        <table tableName="user" domainObjectName="User" >
            <!--根据默认的方式对java属性字段命名，不会采用驼峰命名法-->
            <!--<property name="useActualColumnNames" value="true"/>-->
        </table>
    </context>
</generatorConfiguration>
```

控制台直接运行就能启动逆向工程***mvn -Dmybatis.generator.overwrite=true mybatis-generator:generate***

回滚到某一次历史提交(git reset –hard 8ff24a6803173208f3e606e32dfcf82db9ac84d8)



### 自定义异常处理请求

自定义枚举异常（举例：用于访问不到页面信息）

```java
//自定义异常枚举
public enum CustomizeErrorCode implements ICustomizeErrorCode {
    QUESTION_NOT_FOUND("你找的问题不存在了，要不换一个问题试试");
    private String message;
    @Override
    public String getMessage() {
        return message;
    }
    CustomizeErrorCode(String message) {
        this.message = message;
    }
}
```

自定义异常实现类

```java
/*
 * 自定义异常实现类
 */
public class CustomizeException extends RuntimeException {
    private String message;
    public CustomizeException(ICustomizeErrorCode errorCode) {
        this.message = errorCode.getMessage();
    }
    @Override
    public String getMessage(){
        //继承自Throwable的方法
         return message;
    }
    public CustomizeException(String message) {

        this.message = message;
    }
}
```

异常处理拦截器

```java
/*
 * 异常处理拦截器(用于处理页面传递过来的错误信息，并返回响应的信息)
 */
@ControllerAdvice
public class CustomizeExcptionHandler {
    /**
     * Throwable 类是 Java 语言中所有错误或异常的父类
     * @param throwable
     * @return
     */
    @ExceptionHandler(Exception.class)
    ModelAndView handle(Throwable throwable, Model model) {
        //判断异常是否属于CustomizeException自定义的枚举异常，并返回model结果到页面
        if (throwable instanceof CustomizeException) {
            model.addAttribute("message", throwable.getMessage());
        }else {
            model.addAttribute("message","服务器冒烟了......");
        }
        return new ModelAndView("/error");
    }
}
```

异常转发控制器

```java
/**
 * 跳转错误页面的控制器
 */
@Controller
@RequestMapping("${server.error.path:${error.path:/error}}")
public class CustomizeErrorController implements ErrorController {
    @Override
    public String getErrorPath() {
        return "error";
    }
    @RequestMapping(
            produces = {"text/html"}
    )
    public ModelAndView errorHtml(HttpServletRequest request, Model model) {
        HttpStatus status = this.getStatus(request);
        if (status.is4xxClientError()) {
            model.addAttribute("message", "访问的资源不存在");
        }
        if (status.is5xxServerError()) {
            model.addAttribute("message", "服务器异常，请您稍后再试好吗");
        }
        return new ModelAndView("error");
    }
    /**
     * 获取到错误状态码，4xx资源错误，5xx服务器内部错误
     */
    private HttpStatus getStatus(HttpServletRequest request) {
        Integer statusCode = (Integer)request.getAttribute("javax.servlet.error.status_code");
        if (statusCode == null) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        } else {
            try {
                return HttpStatus.valueOf(statusCode);
            } catch (Exception var4) {
                return HttpStatus.INTERNAL_SERVER_ERROR;
            }
        }
    }
}
```



### JSON数据传输格式

[JSON](https://baike.baidu.com/item/JSON)([JavaScript](https://baike.baidu.com/item/JavaScript) Object Notation, JS 对象简谱) 是一种轻量级的数据交换格式。它基于 [ECMAScript](https://baike.baidu.com/item/ECMAScript) (欧洲计算机协会制定的js规范)的一个子集，采用完全独立于编程语言的文本格式来存储和表示数据。简洁和清晰的层次结构使得 JSON 成为理想的数据交换语言。 易于人阅读和编写，同时也易于机器解析和生成，并有效地提升网络传输效率。

JSON 键值对是用来保存 JS 对象的一种方式，**在 JS 语言中，一切都是对象**

SpringMVC中处理请求参数有好几种不同的方式，如我们常见的下面几种

- 根据 `HttpServletRequest` 对象获取
- 根据 `@PathVariable` 注解获取url参数
- 根据 `@RequestParam` 注解获取请求参数
- 根据Bean的方式获取请求参数
- 根据 `@ModelAttribute` 注解获取请求参数
- `@RequestBody`可以将参数封装成一个对象





