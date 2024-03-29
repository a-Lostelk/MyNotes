---
typora-root-url: images
---

- a标签中可以是任何html元素，target="_blank"表示在新的页面中打开

  

- `<img>`标签的相关拓展，`usemap`，一般用在图片元素中，在点击图片中的不同位置会跳转到不同的网页

  ```html
  <img src="" usemap="#usemap" alt="这是一张图片">	<!-- #usemap是map地图的元素名 -->
  
  <map name="usemap"> <!-- area是map的唯一子元素 -->
  	<area shape="circle" coords="500,400,50" href="要跳转的地址" alt="">	
      <!--shape表示选中的区域是圆形或者是矩形，coords是从父级元素的左上角开始，向右为x轴，向下为y轴-->
      <!--如果是圆形只需要知道圆心的位置，矩形的话就需要知道四个对角的位置，依次描述点所在的位置，rect是矩形，-->
  </map>
  ```

  `<figure>`标签，

- `video`标签，和img标签类似，src导入需要显示的值，controls表示是否显示控件，只写属性名表示默认播放

  某些属性，只有两种状态: 1.不写2.取值为属性名，这种属性叫做布尔属性，在HTML5中， 可以不用书写属性值
  autoplay:布尔属性，自动播放。

  muted:布尔属性，静音播放。

  loop:布尔属性，循环播放

  

  `audio`标签和`video`的属性完全一致

  ```html
  <video  controls="controls" autoplay muted loop style="width: 50%;">
  	<source src="需要引入的mp4、webm">
  </video>
  ```

  注意：这两个属性是在html5中加入的元素

  **1.旧版本的浏览器不支持这两个元素**
  **2.不同的浏览器支持的音视频格式可能不一致**
  **mp4、webm**

- 列表`ol`标签和`ul`，应当在css中使用`list-style-type:`来选择有序列表中的列表头部，设置为none为隐藏不显示
  ul: unordered list

  无序列表常用于制作菜单或新闻列表，最常用的是无序列表

  ```html
  <ol type="a">
      <li>1</li>
      <li>2</li>
      <li>3</li>
  </ol>
  ```

  1.容器元素中可以包含任何元素

  2.a元素中几乎可以包含任何元素

  3.某些元素有固定的子元素(u1>]i, ol>li, dl>dt+dd) 

  4.标题元素和段落元素不能相互嵌套，并且不能包含容器元素

  

- `header:`通常用于表示页头，也可以用于表示文章的头部

  `footer:`通常用于表示页脚，也可以用于表示文章的尾部

  `article:`通常用于表示整篇文章

  `section:`通常用于表示文章的章节

  `aside:`通常用于表示侧边栏

  

- `box`:盒子，每个元素在页面中都会生成一个矩形区域(盒子)

  盒子类型:

  （默认属性display，可以在浏览器f12中查看）

  1. 行盒，`display`等于`inline`的元素
  2. 块盒，`display`等于`block`的元素

  **行盒在页面中不换行、块盒独占一行**

  1. 浏览器默认样式表设置的块盒:`容器元素、h1~h6、 p`
  2. 常见的行盒:` span、a、img、 video、 audio`
  
  无论是行盒、还是块盒，都由下面几个部分组成，从内到外分别是: 
  1.内容：Content、width、height，盒子的宽高
  
  2.填充：padding
  
  盒子边框到盒子内容的距离
  `padding- left、padding- right、padding- top、padding bottom`
  padding:简写属性
  padding:上右下左
  填充区+内容区= **填充盒padding- box**
  
  3.边框：border
  
  边框=边框样式+边框宽度+边框颜色
  边框样式: `border-style`
  边框宽度: `border- width`
  边框颜色: `border-color `
  边框+填充区+内容区= **边框盒border - box**
  
  4.外边距：margin
  
  属性同padding基本一致





- ### 属性值的计算过程

  从树形的根节点依次向下渲染，渲染每个元素的前提条件:该元素的所有**CSS**属性必须有值

  **一个元素，从所有属性都没有值，到所有的属性都有值，这个计算过程，叫做`属性值计算过程`**

  一个页面要完整的显示，必须所有的CSS属性都有值

  ![](/QQ截图20200207135645.png)

  

- #### 步骤（CSS属性从没有值到有值的过程）

  1. 确定声明值：**参考样式表中没有冲突的声明，作为CSS属性值**

  2. 层叠冲突：**对样式表有冲突的声明使用层叠规则，确定CSS属性值**

  3. 使用继承：**对仍然没有值的属性，若可以继承，则继承父元素的值（某些不能继承的元素如背景颜色就不会继承）**

  4. 使用默认值：**对仍然没有值的属性，若可以继承，则继承父元素的值（如背景颜色的默认值是`transparent`）**

     **元素必须要所有的CSS属性都有值才能运行，默认是采用声明的属性值，层叠后采用后面确定的元素，如果没有值使用父级元素乃至祖先元素的值或者使用祖先元素的默认值**

- #### 经典案例

  ```html
  <style>
      div {
          color: red;
      }
  </style>
  <body>
  <div>
      <a href="">a元素不会继承</a>
      <p>p元素默认会继承</p>
  </div>
  ```

  考虑到CSS属性的计算过程，会采用以上四个步骤，通常来说，a元素和p元素没有声明任何的属性值，也没有任何的层叠样式，就会默认继承 `div`的`color`样式，由于a标签比较特殊，使用的是浏览器的默认样式表 **参考样式表**中的`color:webkit-link`属性，p元素是**普通块盒元素**，会向父级乃至祖先元素寻找样式

  ```css
  a{
      color: inherit;	/**inherit默认是继承关系**/
  }
  ```

  `inherit`:手动(强制)继承，将父元素的值取出应用到该元素
  `initial`:初始值，将该属性设置为默认值



- ### 块盒模型

  1. **内容盒应用**

     应用场景：

  2. 当一个盒子内的p块盒是独占一行的，对其设置样式比如`margin-left`的时候父元素回随之发生变化

  3. `box-sizing: border- box;`属性可以将设置的样式只作用于有内容的部分，其父级元素不会随之内容盒的样式发生改变而改变

     `background-clip`默认是border-box

  4. 关于盒子的溢出，没有设置固定宽高的时候，父级盒子是会自动增加宽高的，

     `overflow`，控制内容的溢出是否显示，`hidden`超出的部分默认会被隐藏，`sroll`是为隐藏的内容设置滚动条可以查看

  5. **控制文字内容溢出部分用...隐藏**

     ```css
     white-space: nowrap ;
     overflow: hidden;
     text-overflow: ellipsis; 
     ```

     首先控制字体不换行，将溢出部分隐藏，隐藏部分使用ellipsis替代

     `white-space: pre`页面显示的内容户根据在编辑器中的书写样式展现出来

     

- #### 行盒模型

  行盒的宽高是跟着内容走的，比如文字的大小会改变行盒的大小，行盒宽高无效

  调整行盒的宽高，应该使用字体大小、行高、字体类型，间接调整，比如`line-height`
  
  padding、border、margin水平方向有效，垂直方向不会实际占据空间，实际高度受内容的大小改变

- #### 行块盒

  `display: inline-block`的盒子，行盒是不能改变宽高的，将其设置为行块盒，就有了块盒的属性，

  object-fit：会将元素中的内容根据宽高自适应或者牺牲谋陷展示等方式显示出来

  大部分元素，页面上显示的结果，取决于元素内容，称为**非可替换元素**
  少部分元素，页面上显示的结果，取决于元素属性，称为**可替换元素**
  可替换元素:` img、video、 audio`
  绝大部分可替换元素均为行盒。
  可替换元素类似于行块盒，盒模型中所有尺寸都有效。

  

- #### 常规流

  **盒模型**:规定单个盒子的规则
  **视觉格式化模型**:页面中的多个盒子排列规则

  **视觉格式化模型**，大体上将页面中盒子的排列分为三种方式:
  1.常规流
  2.浮动
  3.定位

  常规流布局：

  常规流、文档流、普通文档流、常规文档流
  所有元素，默认情况下，都属于常规流布局
  总体规则:块盒独占-行，行盒水平依次排列
  **包含块(`containing block`)** :每个盒子都有它的包含块，包含块决定了盒子的排列区域。
  绝大部分情况下:盒子的包含块，为其父元素的内容盒

  1.每个块盒的总宽度，必须刚好等于包含块的宽度
  宽度的默认值是auto
  `margin`的取值也可以是auto,默认值0
  auto:将剩余空间吸收掉

  常规流中，块盒在包含块中设置定宽，左右margin都为auto，如果量margin的左右设置为负数的话，当前块盒超出包含块的宽度后，块盒的宽度也会发生变化

  2.包含块的高度

  包含块的高度会被子元素内容盒中的内容撑开，内容盒中的高度是多高的包含块就会有多高

  3.百分比取值

  **所有的百分比取值都是和包含块父级元素的宽度相对关系，和高度没有任何关系**

  padding、宽、margin可以取值为百分比
  以上的所有百分比相对于包含块的宽度。
  高度的百分比: 

  1.包含块的高度是否取决于子元素的高度，**设置百分比无效**

  2.包含块的高度不取决于子元素的高度，**百分比相对于父元素高度**
  
  
  
- margin只要是相邻（父元素的margin-top和子元素的margin-top），**不管是是兄弟元素还是子元素都会合并**  

  如这种情况：父元素parent距离body的top大小是50，子元素距离父元素的外边距的距离也是50，这时候就会发生看似异常的重合现象

  ![](/QQ截图20200205120919.png)



- ### **浮动**

  1.文字环绕 	2.横向排列

  #### **基本特点**

  修改float属性值为: 
  `left：`左浮动，元素靠上靠左
  `right:`右浮动，元素靠上靠右
  默认值为none
  1.当一个元素浮动后，**元素必定为块盒**，也就是说只要元素浮动起来，该元素就会变成**块盒**

  当浮动盒子和常规盒子一起排列的时候，因为块盒是独占一行的，浮动盒子是行块盒，会脱离常规盒子的常规流之外依次排序

- #### **盒子排列**
  
  左浮动的盒子靠上靠左排列
  右浮动的盒子考上靠右排列
  浮动盒子在包含块中排列时，会避开常规流块盒
**常规流块盒在排列时，无视浮动盒子**
  

行盒在浮动时，会避开浮动盒子，**如果文字没有在行盒中，浏览器会自动生成一个行盒包裹文字**

如下：文字所有的区域都包含图片img标签下的div，`img`加了浮动属性成为浮动盒子，p元素实际上是一个行盒子，会在图片盒子的后面跟着排列，这就是一个简单的**文字环绕**例子

**如果需要改变图片和文字的间距，则需要改变图片的margin，因为p元素是包含整个页面，文字只是浮动于img盒子后面**

![](/QQ截图20200205203227.png)



- #### 高度坍塌

  浮动盒中的常规流盒子，设置的高度或者宽度超出了浮动盒设置的，样式会在父级元素之外

  **高度坍塌的根源:常规流盒子的自动高度，在计算时，不会考虑浮动盒子**

  使用`clear：both`属性，会将之前浮动盒子的所有浮动盒子清楚，然后展示在浮动盒后面，而不是出现在被浮动盒遮挡位置

  ![](QQ截图20200205211523.png)



- ### 定位（`position`）

  视觉格式化模型，大体上将页面中盒子的排列分为三种方式: 
  **1.常规流**
  **2.浮动**
  **3.定位**

  定位：**手动控制元素在包含块中的精准位置**

  只要一个元素的`position为非static`，，会认为该元素是一个定位元素，定位元素会脱离文档流（**相对定位除外**）

  默认值:` static`, 静态定位(不定位)

  `relative`:相对定位，不会导致元素脱离文档流，只是让元素在**原来位置**上进行偏移，有4个css属性能					 改变元素的相对位置`left、right、top、buttom`；

  ​					 相对于margin属性，margin自适应包含块的大小，不会超出包含块的，relative会改变当前元					 素的位置，元素的大小不会发生改变，会发生超出包含块的大小的情况

  ​					 盒子的便宜不会对其他元素有任何影响

  ​					 一般来说，相对定位是用来作为绝对定位的包含包含块

  `absolute`:绝对定位，包含块变化:找祖先中第一个定位元素， 该元素的填充盒为其包含块，如果没					 有，那么包含块是整个网页

  ​					此时，包含红色div的元素是上级元素，祖先元素是最上层元素，`absolute`是相对于祖先					元素，默认情况下祖先元素是属于文档流且有`relative`定位![](QQ截图20200206163821.png)

  `fixed`：固定定位，和绝对定位大致一样，不同的是包含块是**视口（浏览器的可视窗口）**，也就是页面				 元素可视的范围之内，和任何元素都没有关系

  ​				固定定位的使用场景有，比如网站上比较烦人的小广告，或者无论如何滚动都不会消失的搜索				栏

  ​				为绝对定位的元素通过包含块

  ![](QQ截图20200206170609.png)

- #### 定位下的居中

  绝对定位和固定定位中，margin为auto时， 会自动吸收剩余空间
  
  ```css
  position: fixed;
  left: 0;
  top: 0;
  right: 0;
  buttom: 0;
  margin: auto;
  /**可以将一个元素始终保持在页面的最中间**/
  ```

- #### 堆叠上下文

  设置z- index,通常情况下，该值越大，越靠近用户
  只有定位元素设置z - index有效
  z- index可以是负数，如果是负数，则遇到常规流、浮动元素，则会被其覆盖

  **绝对定位、固定定位元素一定是块盒**

  **绝对定位、固定定位元素一定不是浮动** 

  **没有外边界合并的说法**

  

- #### 防止高度坍塌

  当使用浮动的时候可能会发生高估坍塌导致背景颜色失效，将该属性加到发生高度坍塌的元素的包含块元素的class选择器中

  ```css
  .clearfix::after {
  content "":
  display: block;
  clear: both;
  }
  ```

  在实际开发中，要使用`absolute`属性必须要将其的上级或跟更高级元素设置为`relative`属性



- ### 实现透明效果

  在css中，只要是设计到颜色的改变，都有一个默认透明通道，其数值的大小就是颜色的透明度

  可以使用`rgba(0,0,0,.5)`最后面的0.5表示的就是50%的黑色透明

  ```css
  /**
  	可以使元素在页面上无论上下左右都是居中的效果
  **/
  position: absolute ;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  margin: auto;
  ```

  `cursor:pointer;`可以鼠标转换成小手指



- ###  更多伪类选择器 

  first-child、last-child、nth-child、nth-of-type

  first- letter（选中元素中的第一个字母）、first- line（选中元素中第一行的文字）、selection（选中被用户框选的文字）

  `:first-child`表示的是选择当前元素中的子元素的子元素类推，直到找到最后一个子元素，一般会精确指定到需要操作的子元素的位置

  `a: last-child`与之相反是选择后面的元素

  ```css
  nth-child(even){
      color: red; /*第n个元素为红色，n是偶数*/
  }
  ```

  

  选中指定的第几个子元素
  `even`:关键字，等同于2n（偶数）
  `odd`:关键字，等同于2n+1（奇数）

- ### CSS属性补充

- #### 透明度

  `opacity`：设置的是整个元素的透明，它的取值是0 ~ 1
  `rrgba()`：在颜色位置设置alpha通道(rgba )

- #### 鼠标样式

  `cursor`:可以设置图片，后缀名必须是ico格式，auto表示当图片格式发生错误的时候使用浏览器默认的样式，`cursor:url("imgs/target .ico"),auto；`

- #### 盒子隐藏

  1. `display:none`,不生成盒子，相当于是移出了当前盒子，会影响其他盒子的布局
  2. `visibility:hidden`,生成盒子，只是从视觉上移除盒子，盒子仍然占据空间。

- #### 背景图

  `img`元素是属于HTML的概念，背景图属于`css`的概念

  1. 当图片属于网页内容时，必须使用`img`元素
  2. 当图片仅用于美化页面时，必须使用背景图

  

- ##### 涉及的CSS属性

  默认情况下，背景图会在横坐标和纵坐标中进行重复，使用`background-repeat:no-repeat`去除重复

  `background-position`使用上下左右四个值可以改变背景的位置

  `background-size`背景图片的显示比例，默认是根据图片的大小显示

  `background-attachment`设置值为fixed的时候，背景图是相对于视口的，就能实现在翻动内容的时候背景图始终保持在视口内容盒中

- #### 雪碧图(精灵图) (spirit)

  在实际开发中，假设一个页面中有大量的图标需要读取，可以将所有的图标都做成一个页面（也就是雪碧图），通过`background-position`可以选择该图片的指定区域，类似于截取雪碧图中需要的图片，通过指定大小就能获得一个图标，可以省去大量的读取图片的操作只需要读取一个图片并截取其中的图标内容，提高开发效率



- ### iframe

  通常用来嵌入其他的网页，是**可替换元素**，是**行盒**

  1. 通常行盒

  2. 通常显示的内容取决于元素的属性

  3. CSS不能完全控制其中的样式
  4. 具有行快盒的特点

  在自己的网站中链接其他网页的内容进行展示或者播放



- ### 在页面中使用Flash

  object、embed

  它们都是可替换元素

  MIME ( **Multipurpose Internet Mail Extensions**)

  ```html
  <object data="./example. swf" type= " application/x-shockwave-flash"></objec
  ```

  

- ### @规则

  **at-rule: @规则、@语句、CSS语句、 CSS指令**

  `@import` "路径"，导入另外一个css文件

  `charset`告诉浏览器CSS文件使用的字符集

  

- ### 使用web字体

  在实际开发中，可能开发环境中使用的web字体用户环境中不存在，可能会在页面展示的时候让用户手动下载已达到开发者希望展示的效果

  `@font-face`:

  ```css
  @font-face {
      font-family: "good night"; /*字体的名字*/
      src: url("./font/晚安体");	/*服务器上的字体文件*/
  }
  ```

  使用web字体的局限就是每次用户在加载页面的时候都会下载服务器端的字体资源，会影响用户体验

  所以web字体在实际开发中并不常见

- ### 字体图标

  常见的字体图标网站有阿里的iconfont，可以使用导入CSS文件和Unicode编码的方式使用字体图标

  ![](/QQ截图20200209144532.png)



![](/QQ截图20200209144644.png)



- ### 块级格式化上下文

  全称`Block Formatting Context,` 简称**BFC**

  它是一块独立的渲染区域，它规定了在该区域中，**常规流块盒**的布局

  1. 常规流块盒的作用，常规流块盒在**水平方向上，必须撑满包含块**
  2. 常规流块盒在包含块的**垂直方向上依次摆放**
  3. 常规流块盒若外边距无缝相邻，则进行外边距合并
  4. 常规流块盒的自动高度和摆放位置，**无视浮动元素、定位元素**等其他元素

  BFC元素是一块独立的html块元素，**根元素、浮动和绝对定位元素、overflow不等于visible的块盒** 都会创建BFC元素，不同的BFC互不干扰，每一个BFC都是独立的区域，内部的BFC和外部的BFC（如html根节点）不会影响

  ![](/QQ截图20200209204037.png)

  div是块盒，常规元素的div块盒的高度是不会计算浮动元素的高度，类似于浮动元素想水面一样漂浮在常规流元素上， 就会导致**高度坍塌**

  

  1. **创建BFC的元素,它的自动高度需要计算浮动元素**
  2. **创建BFC的元素，它的边框盒不会与浮动元素重叠**
  3. **创建BFC的元素，不会和它的子元素进行外边距合井**

  最理想的解决高度坍塌的问题是：`overflow:hidden`

  ```html
  <style>
      .left {
          height: 200px;
          width: 200px;
          background-color: red;
          margin: 20px;
          float: left;
         	overflow: hidden;	/*如果不加上该属性会导致常规盒子直接包裹了浮动盒子*/
      }
      .container {
          height: 500px;
          background-color: #14414e;
      }
  </style>
  <body>
  <div class="left"></div>
  <div class="container"></div>
  ```

  创建BFC的元素会和其他元素隔绝，因此不会影响到其他元素的布局

- ### 布局

  是页面的整体排列和分布情况，大部分的网站都是两栏或者是三栏布局

  ![](/QQ截图20200209220018.png)

- #### 等高布局,设置布局，侧边栏和内容栏的高度始终一致,

  ```css
  /*解决高度坍塌问题*/
  .clearfix {
      content: "";
      display: block;
      clear: both;}
  .container {  
      width: 90%;   
      margin: 0 auto;    
      overflow: hidden;}
  .aside {    
      float: left;    
      background-color: #207890;    
      color: white;    
      width: 300px;
      margin-right: 20px;/*实际上就是将侧边栏高估变大，但并没有将包容盒的长度变大*/
      height: 10000px;
      margin-bottom: -9990px;
  }
  .main {
      overflow: hidden;
     background-color: #4d4a40;
  }
  
  
  ```

  **`border-collapse`** [CSS](https://developer.mozilla.org/zh-CN/docs/CSS) 属性是用来决定表格的边框是分开的还是合并的。在分隔模式下，相邻的单元格都拥有独立的边框。在合并模式下，相邻单元格共享边框。

 

### CSS弹性布局

[CSS](https://developer.mozilla.org/zh-CN/css)属性 **flex** 规定了弹性元素如何伸长或缩短以适应flex容器中的可用空间

display： flex

子容器可以在10 的范围内规定容器的大小