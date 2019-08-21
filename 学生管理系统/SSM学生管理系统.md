---
typora-root-url: Images
---

# 						SSM学生管理系统

### SSM框架

Spring是一个大容器，bean（Java实体对象）的集合

SpringMVC：控制器（业务逻辑层）（视图分发器）由前端分发器dispatcherServlet决定调用后台的那个控制器

mybatis：JDBC的封装（数据库框架）

### 流程图

![](/QQ截图20190812221749.png)



Get方式的请求参数在地址栏中会有显示，例如（www.baidu,com/baidu?word=xxx&ie=utf-8&cn=13），适用于提交一些比较小的数据

POST方式是以表单的方式，具体的参数看不到，提交数量比较大上传文件提交图片等

tomcat的入口是web.xml 文件



### 项目模块

![](/QQ拼音截图20190815172246.png)



### 小问题

系统默认生成的web.xml是2.3dtd，默认不开启el表达式，导致JSP页面${}并不能获取到值，

解决方法

- 页面上增加<%@ page isELIgnored=”false” %>代码手动开启el。

- 使用最新的Servlet3.1规范,不要使用默认的2.3dtd，修改web.xml文件。

  ```xml
  <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
      xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
      xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" id="WebApp_ID" version="3.1">
  ```

  



### BufferedImage图片生成工具

继承 ***java.awt.Image*** 接口，提供获得绘图对象、图像缩放、选择图像平滑度等功能，BufferedImage是带数据缓冲区的图像类,BufferedImage生成的图片在内存里有一个图像缓冲区，利用这个缓冲区我们可以很方便的操作这个图片，通常用来做图片修改操作如大小变换、图片变灰、设置图片透明或不透明等

#### 生成验证码功能

```java
/**
 * 生成验证码
 * @return 验证码
 */
public String generatorVCode(){
   int len = code.length;
   Random ran = new Random();
   StringBuffer stringBuffer = new StringBuffer();
   for(int i = 0;i < vcodeLen;i++){
      int index = ran.nextInt(len);
      stringBuffer.append(code[index]);
   }
    //生成的验证码转换成字符串
   return stringBuffer.toString();
}
```

#### 生成验证码图片

```java
/**
 * 获得旋转字体的验证码图片
 * @param vcode
 * @param drawline 是否画干扰线
 * @return
 */
public BufferedImage generatorRotateVCodeImage(String vcode, boolean drawline){
   //创建验证码图片
   BufferedImage rotateVcodeImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
   Graphics2D g2d = rotateVcodeImage.createGraphics();
   //填充背景色
   g2d.setColor(new Color(246, 240, 250));
   g2d.fillRect(0, 0, width, height);
   if(drawline){
      drawDisturbLine(g2d);
   }
   //在图片上画验证码
   for(int i = 0;i < vcode.length();i++){
      BufferedImage rotateImage = getRotateImage(vcode.charAt(i));
      g2d.drawImage(rotateImage, null, (int) (this.height * 0.7) * i, 0);
   }
   g2d.dispose();
   return rotateVcodeImage;
}
```

#### 请求的方法(自定义宽高和验证码数量)

```java
/**
 * @param request
 * @param vl    验证码数量
 * @param w     验证图片宽度
 * @param h     验证图片高度
 * @param response
 */
@RequestMapping(value = "/get_Cpacha", method = RequestMethod.GET)
public void getCpacha( HttpServletRequest request,
                       @RequestParam(value = "vl", defaultValue = "4", required = false) Integer vl,
                       @RequestParam(value = "w", defaultValue = "98", required = false) Integer w,
                       @RequestParam(value = "h", defaultValue = "33", required = false) Integer h,
                               HttpServletResponse response) {
    CpachaUtil cpachaUtil = new CpachaUtil(vl, w, h);
    //生成验证码
    String generatorVCode = cpachaUtil.generatorVCode();
    request.getSession().setAttribute("loginCpacha", generatorVCode);
    //生成图片，true表示画干扰线
    BufferedImage generatorRotateVCodeImage = cpachaUtil.generatorRotateVCodeImage(generatorVCode, true);
    try {
        //将生成的验证码图片存放于response对象中通过ImageIO写入页面
        ImageIO.write(generatorRotateVCodeImage, "gif", response.getOutputStream());
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```



### 登录管理

*SystemController*：Java后台验证，将返回结果封装为HashMap对象，StringUtils工具类判断是否为null*（实际开发中，尽量减少服务器的压力，一些简单的判断验证可以在页面中处理）*

```java
@ResponseBody
@RequestMapping(value = "/login", method = RequestMethod.POST)
public Map<String, String> login(
        @RequestParam(value = "username", required = true) String username,
        @RequestParam(value = "password", required = true) String password) {
    HashMap<String, String> hashMap = new HashMap<>();
    if (StringUtils.isEmpty(username)) {
        hashMap.put("type", "error");
        hashMap.put("msg", "用户名不能为空");
        //返回不继续执行
        return hashMap;
    }
    if (StringUtils.isEmpty(password)) {
        hashMap.put("type", "error");
        hashMap.put("msg", "密码不能为空");
        return hashMap;
    }
    hashMap.put("type", "success");
    hashMap.put("msg", "登录成功");
    ......
	......
    return hashMap;
}
```



### 拦截器

抽象的来说，拦截器充当类似检票员的角色，在程序的入口进行拦截，每个请求在进入到容器中之前被拦截，完成了相关判断的请求才被放行到后台中，而不是在所有的方法都进入到方法中才开始进行判断检测

```java
/**
 * 方法执行前进入拦截器
 */
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
    String uri = request.getRequestURI();
    User user = (User) request.getSession().getAttribute("userInfo");
    //用户未登录或登录失效
    if (user == null) {
        System.out.println("error:用户未登录或登录失效" + uri);
        //获取请求头，ajax请求头会携带XMLHttpRequest参数
        String header = "XMLHttpRequest";
        if (header.equals(request.getHeader("X-Requested-With"))) {
            Map<String, String> hashMap = new HashMap<>();
            hashMap.put("type", "error");
            hashMap.put("msg", "登录已经失效，请重新登录");
            response.getWriter().write(JSONObject.toJSONString(hashMap));
            return false;
        }
        //未登录跳转到登录页面
        response.sendRedirect(request.getContextPath() + "/System/login");
        return false;

    }
    return true;
}
```



### 用户管理

**easyui分页实现**，dataList是一个table元素块的集合，columns中的字段值和user实体层的属性值匹配框架会自动显示并完成分页等相关功能，pagination分页控件

```javascript
//datagrid初始化 
$('#dataList').datagrid({
    title: '用户列表',
    iconCls: 'icon',//图标
    border: true,
    collapsible: false,//是否可折叠的
    fit: true,//自动大小
    method: "post",
    url: "get_list?t=" + new Date().getTime(),
    idField: 'id',
    singleSelect: false,//是否单选
    pagination: true,//分页控件
    rownumbers: true,//行号
    sortName: 'id',
    // sortOrder: 'DESC',
    remoteSort: false,
    columns: [[
        {field: 'chk', checkbox: true, width: 50},
        {field: 'id', title: 'ID', width: 50, sortable: true},
        {field: 'username', title: '用户名', width: 150, sortable: true},
        {field: 'password', title: '密码', width: 100},

    ]],
    toolbar: "#toolbar"
});

 //设置分页控件 
var p = $('#dataList').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,//每页显示的记录条数，默认为10 
    pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
    beforePageText: '第',//页数文本框前显示的汉字 
    afterPageText: '页    共 {pages} 页', 
    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
}); 
```

like子语句通常是和%%一起使用的，%表示里面的是任意类型相当于一个占位符，不加和=是一样的

```java
@RequestMapping(value = "/get_list", method = RequestMethod.POST)
@ResponseBody
public Map<String, Object> getList(
        @RequestParam(value = "username", required = false, defaultValue = "")String username,
        PageDTO pageDTO) {
    Map<String, Object> hashMap = new HashMap<>();
    Map<String, Object> queryMap = new HashMap<>();
    queryMap.put("username", "%" + username + "%");
    queryMap.put("offset", pageDTO.getOffset());
    queryMap.put("pageSize", pageDTO.getRows());
    hashMap.put("rows", userService.findList(queryMap));
    hashMap.put("total", userService.getTotal(queryMap));
    return hashMap;
}
```

分页DTO，以此来接收页面传递过的分页浏览和模糊查询，页面的显示页数到后台是offise偏移量，数据库的索引是从0开始的

```java
public Integer getOffset() {
    this.offset = (page - 1) * rows;
    return offset;
}
/**
 * 当前页是第1页，数据库中的偏移量是从下标为0的第一条数据开始
 * 当前页是第2页，(1-1)*10=0 (2-1)*10=10 (3-1)*10=20,以此类推
 */
public void setOffset(Integer offset) {
    this.offset = (page - 1) * rows;
}
```

**删除功能**

${}和#{}的区别：#相当于preparedstatement执行sql语句的（?,?,?,?），是占位符根据传递过来的值决定，mybatis默认会将其当成字符串，可以防止SQL注入，先编译语句再根据值执行

使用${}方式传入的参数，mybatis不会对它进行特殊处理，传递过来的是什么值进行sql语句就是什么值，不会编译语句在执行

```xml
<delete id="delete">
    ##传递过来是什么，就是什么，一般是用在传入表名
    DELETE FROM user where id in (${value})
</delete>
```

```java
@RequestMapping(value = "/delete",method = RequestMethod.GET)
@ResponseBody
public Map<String,String> edit(
        @RequestParam(value = "ids[]", required = true) Long[] ids) {
    Map<String, String> map = new HashMap<>();
    if (ids == null) {
        map.put("type", "error");
        map.put("msg", "请选择要删除的数据");
        return map;
    }
    String string = "";
    for (Long id:
         ids) {
        string += id + ",";
    }
    //截取传递过来的id
    string = string.substring(0, string.length() - 1);
    if (userService.delete(string) <= 0) {
        map.put("type", "error");
        map.put("msg", "删除失败");
        return map;
    }
    map.put("type", "success");
    map.put("msg", "删除成功");
    return map;
}
```

### get和post的区别

向后台传递国歌参数的时候用post，get对参数的长度有限制

##### GET请求

根据HTTP规范，GET用于信息获取，而且应该是安全的和幂等的。GET 请求一般不应产生副作用。就是说，它仅仅是获取资源信息，就像数据库查询一样，不会修改，增加数据，不会影响资源的状态

##### POST请求

根据HTTP规范，POST表示可能修改变服务器上的资源的请求，