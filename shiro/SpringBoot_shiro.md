---
typora-root-url: images
---

## 									SpringBoot和Shiro安全框架

### 简介

Apache Shiro是一一个 强大且易用的Java安全框架，执行身份验证、授权、密码学和会话管理。使用Shiro的易于理解的API,您可以快速、轻松地获得任何应用程序，从最小的移动应用程序到最大的网络和企业应用程序。

#### 主要功能

1、`Authentication`认证用户登录
2、`Authorization `授权用户具有哪些权限
3、`Cryptography` 安全数据加密
4、`Session Management`会话管理
5、`Web Integration web`系统集成
6、`Interations` 集成其它应用，spring、 缓存框架

![](/20150603101803466.jpg)



`Subject`：即当前用户，在权限管理的应用程序里往往需要**知道谁能够操作什么，谁拥有操作该程序的权利**，shiro中则需要通过Subject来提供基础的当前用户信息，**Subject 不仅仅代表某个用户，也可以是第三方进程、后台帐户（Daemon Account）或其他类似事物**。

`SecurityManage`：即所有Subject的管理者，这是Shiro框架的**核心组件**，可以把他看做是一个Shiro框架的全局管理组件，用于调度各种Shiro框架的服务。

`Realms`：Realms则是用户的信息认证器和用户的权限认证器，我们需要自己来实现Realms来自定义的管理我们自己系统内部的权限规则。



#### 创建SpringBoot工程

- 导入相关的starter启动器，`spring-boot-starter-web`等组件

- `SpringBootApplication`标识的类是SpringBoot工程的启动器，通过main主方法运行整个项目

  ```java
  @SpringBootApplication
  public class SpringbootShiroApplication {
      public static void main(String[] args) {
  		SpringApplication.run(SpringbootShiroApplication.class, args);
  	}
  }
  ```

  

- SpringBoot工程的静态资源在resources下的templates文件夹下，这是固定写法，引擎默认加载的就是这个位置下的静态资源，如果业务也可以自己在properties文件中修改

- SpringBoot推荐使用的模板引擎是thymeleaf，引入对应的命名空间`

  <html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">

  

  #### 测试项目和引入的模板引擎

  **UserController**

  ```java
  @RequestMapping("/test")
  public String testThymeleaf(Model model) {
      model.addAttribute("name", "大家好我是sunny");
      model.addAttribute("age", 22);
      return "test";
  }
  ```

  **test.html**

  ```html
  <!DOCTYPE html>
  <html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
  <head>
      <meta charset="UTF-8">
      <title>Title</title>
  </head>
  <body>
  <div>
      姓名：<h1 th:text="${name}"></h1>
      年龄：<h1 th:text="${age}"></h1>
  </div>
  </body>
  </html>
  ```

  

  #### SpringBoot与shiro整合

  [Shiro的官方文档]( http://greycode.github.io/shiro/doc/reference.html )

  ##### Shiro的核心API

  Subject：用户主体

  SecurityManager：安全管理器

  Realm：Shiro连接数据的中间桥梁

  ##### 导入相关依赖	

  ```xml
  <!--shiro相关依赖-->
  <dependency>
      <groupId>org.apache.shiro</groupId>
      <artifactId>shiro-spring</artifactId>
      <version>1.4.0</version>
  </dependency>
  ```

  Shiro的配置类

  ```java
  @Configuration
  public class ShiroConfiguration {
      /**
       * 创建ShiroFilterFactoryBean
       */
      public ShiroFilterFactoryBean getShiroFilterFactoryBean(
              @Qualifier("securityManager") DefaultWebSecurityManager securityManager) {
          ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
          
          //设置安全管理器
          shiroFilterFactoryBean.setSecurityManager(securityManager);
          return shiroFilterFactoryBean;
      }
      /**
       * 创建web认证安全管理器
       */
      @Bean(name = "securityManager")
      public DefaultWebSecurityManager getDefaultWebSecurityManager(@Qualifier("UserRealm") UserRealm userRealm){
          DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
          //关联realm
          securityManager.setRealm(userRealm);
          return securityManager;
      }
      /**
       * 获取自定义的权限认证器
       * @return
       */
      @Bean(name = "UserRealm")
      public UserRealm getRealm(){
          return new UserRealm();
      }
  }
  ```

自定义的Realm类

```java
/**
 * 自定义实现的Realm
 */
public class UserRealm extends AuthorizingRealm 
    /**
     * 执行授权
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("-------正在授权--------");
        return null;
    }
    /**
     * 执行认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("--------正在认证--------");
        return null;
    }
```

