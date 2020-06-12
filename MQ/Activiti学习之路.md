## 											Activiti

### 工作流引擎

> **Activiti5是**由Alfresco软件在2010年5月17日发布的**业务流程管理（BPM）框架**，它是覆盖了业务流程管理、工作流、服务协作等领域的一个开源的、灵活的、易扩展的可执行流程语言框架。Activiti基于Apache许可的开源BPM平台
>
> 工作流引擎最常见用于审批流程中，现在一线互联网公司也开始使用，并有快速推广的趋势，<u>复杂繁多的业务流程如果采用</u>if else实现那将是崩溃的，代码不可维护，业务流程在代码中可读性很差

### 工作流

**工作流（Workflow），就是“业务过程的部分或整体在计算机应用环境下的自动化”**

[工作流管理系统](https://zh.wikipedia.org/wiki/工作流管理系统)（WfMS）是处理工作流的电脑软件系统，其主要功能是通过计算机技术的支持去定义、执行和管理工作流，协调工作流执行过程中工作之间以及群体成员之间的信息交互。工作流需要依靠工作流管理系统来实现。

在公司，我们的日常请假可能需要经过一层层的批阅，作为一个普通员工，我们是无法越级直接向总经理董事长直接请求（级别不够），**工作流程是一步一步的，无法跳跃**

请假人 ->直属领导->部门经理->人事->总经理，发起的请假是一步一步的，最终确认的总经理，必须在人事批准后才会收到请求，

### Activiti简介

Activiti是一个开源的工作流引擎，它实现了BPMN 2.0规范，可以发布设计好的流程定义，并通过api进行流程调度。

Activiti 作为一个遵从 Apache 许可的工作流和业务流程管理开源平台，其核心是基于 Java 的超快速、超稳定的 BPMN2.0 流程引擎，强调流程服务的可嵌入性和可扩展性，同时更加强调面向业务人员。



参考文章：<https://cloud.tencent.com/developer/article/1178597>

Activiti数据库支持：

Activiti的后台是有数据库的支持，所有的表都以ACT_开头。 第二部分是表示表的用途的两个字母标识。 用途也和服务的API对应。

ACT_RE_*: \'RE\'表示repository。 这个前缀的表包含了流程定义和流程静态资源 （图片，规则，等等）。

ACT_RU_*: \'RU\'表示runtime。 这些运行时的表，包含流程实例，任务，变量，异步任务，等运行中的数据。 Activiti只在流程实例执行过程中保存这些数据， 在流程结束时就会删除这些记录。 这样运行时表可以一直很小速度很快。

ACT_ID_*: \'ID\'表示identity。 这些表包含身份信息，比如用户，组等等。

ACT_HI_*: \'HI\'表示history。 这些表包含历史数据，比如历史流程实例， 变量，任务等等。

ACT_GE_*: 通用数据， 用于不同场景下，如存放资源文件。



### 配置文件

processEngine为工作流引擎声明。

repositoryService、runtimeService、taskService、historyService、managementService、IdentityService都是对activiti自己的数据库表的增删改查

简单的配置文件

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-2.5.xsd
http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.0.xsd">
 <!-- 配置 ProcessEngineConfiguration  -->
 <bean id="processEngineConfiguration" class="org.activiti.engine.impl.cfg.StandaloneProcessEngineConfiguration">
   <!-- 配置数据库连接 -->
 <property name="jdbcDriver" value="com.mysql.jdbc.Driver"></property>
 <property name="jdbcUrl" value="jdbc:mysql://localhost:3306/activitiDB?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf8"></property>
 <property name="jdbcUsername" value="root"></property>
 <property name="jdbcPassword" value="root"></property>
 
  <!-- 配置创建表策略 :没有表时，自动创建 -->
  <property name="databaseSchemaUpdate" value="true"></property>
     <!-- true Activiti在启动时，会对数据库中所有表进行更新，
		如果表不存在，则Activiti会自动创建。 -->
  <property name="databaseSchemaUpdate" value="true" />
     <!-- 保存历史数据
 		full　保存历史数据的最高级别，除了会保存audit级别的数据外，还会保存其他
		全部流程相关的细节数据，包括一些流程参数等。 -->
 </bean>
</beans>

```

