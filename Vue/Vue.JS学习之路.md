---
typora-root-url: images
---

### 															Vue.JS学习之路

### 简介

**Vue.js**是一套构建用户界面的框架，**只关注视图层**，和其他的第三方库或框架也能较好的兼容结合

Vue是一个渐进式的框架，可以将Vue作为应用的一部分嵌入其中，其中有很多复用的组件

主要负责的是MVC中的View视图这一层



![](/QQ截图20191127210632.png)



Vue是属于声明式编程范式（代码和数据分离），JQuery是命令式编程方式

Vue将数据和页面分离，只要数据和页面绑定了关系，数据改变页面也会随之改变，而不需要改变页面



### const、let和var的区别

`let` 的用法类似于 `var`，但是 `let` 只在所在的代码块内有效，所以我们一般使用 `let` 替代 `var`。而 `const` 用来声明常量。

![](/QQ截图20191129205118.png)

var声明的变量是在全局window对象下，会发生变量作用于提升的情况，let和const的作用域是无法提升的

```JavaScript
console.log(a);//正常运行，控制台输出 undefined
var a = 1;

console.log(b);//报错，Uncaught ReferenceError: b is not defined
let b = 1;

console.log(c);//报错，Uncaught ReferenceError: c is not defined
const c = 1;
```

leth和const声明的变量会暂时性死区，也就是在声明之后再使用这些变量赋值或者

```JavaScript
var tmp = 123;

if (true) {
	tmp = 'abc';//报错，Uncaught ReferenceError: tmp is not defined
	let tmp;
}
```

`const` 声明的值在一开始就要被初始化，且声明之后的值不能发生改变

```JavaScript
const PI = 3.1415;
PI = 3;// 报错，Uncaught TypeError: Assignment to constant variable.
```

const和let声明的值会不允许重复声明，

```JavaScript
function func(){   
    let a = 10;  
    const PI = 3.1415;   
    var a = 1;// 报错，Uncaught SyntaxError: Identifier 'a' has already been declared   
    var PI = 3;// 报错，Uncaught SyntaxError: Identifier 'PI' has already been declared }

```



### MVVM

是前端分层的分发思想，将每个页面都分成了M（model）、V（View）和VM（viewModel），VM是中间的调度者，model层和view层时间的存取数据都要经过vm调度者

![](/QQ截图20191010190020.png)



### vue.js的基本语法

引入Vue

```html
<script src="./lib/vue-2.4.0.js"
```

```html
<!--Vue实例控制的实例-->
<div id="app">
    <p v-cloak>{{ msg }}</p>
    <p v-cloak>{{ msg2 }}</p>
    <p v-text="msg2"></p>
    <p v-html="msg2"></p>
    <div>
        <!-- v-bind绑定的时候可以写合法的表达式 -->
        <input type="button" id="btn" value="按钮" v-bind:title="myTitle+'123'">
    </div>
</div>
<script>
    //创建一个Vue的实例
    var vm = new Vue({
        el:	'#app',
        data: {	
            msg: '欢迎学习vue',
        }
    })
</script>
```

el是要绑定的页面元素，data是存储一些数据，可能是来自服务器网络

在一些网络延迟或某种情况数据没有加载出来，会出现插值表达式显现{{  }}直到数据读取到view视图



**绑定函数**

传统的JS编程，要为按钮绑定时间函数，需要操作DOM模型，根据按钮元素的Id或者类选择器来绑定函数，频繁的操作dom对编程也是一种重复的劳作也任意发生错误

vue.js中的`v-on` 可以轻松绑定函数

```JavaScript
//JS 
document.getElementById('btn').onclick = function(){
    alert("Hello");
}

//在new vue的实例下，methods后面添加需要绑定的函数方法
methods:{
    show: function (){
        alert("hello");
    }
}

<div>
    <!-- v-bind绑定的时候可以写合法的表达式 -->
    <input type="button" id="btn" value="按钮"  v-bind:title="myTitle+'123'">
    <input type="button" value="hello" v-on:click='show'>
</div>
```



#### 跑马灯效果实现	

Vue实例会自动监听data中数据的改变并自动部署到页面上，只需要关注数据的绑定，不需要进行数据的页面渲染工作

```html
<div id="app" style="text-align: center;">
    	<input type="button" value="开始" @click="lang()" />
    	<input type="button" value="结束" @click="stop"/>
		<h4>{{ msg }}</h4>
    </div>
	<script>
		var vm = new Vue({ 
			el: '#app',
			data: {
				msg: '这是一段跑马灯文字~~~~',
				/**
				 * 预先设置一个定时器变量，交于Vue引擎监视，如果setInterval定时器启动了，变量会被赋值
				 */
				interValId: null	
			},
			methods: {
				lang () {
					//如果定时器变量已经有值了，说明定时器已经启动了，就不在执行以下的操作，
					if(this.interValId != null){
						return;
					}
					//this函数指向的是当前Vue实例
				 	this.interValId =	setInterval(() => {
						var start = this.msg.substring(0,1)
						var end = this.msg.substring(1)
						this.msg = end + start
					},500)
				},
				//停止定时器
				stop(){
					//清除了定时器，将定时器变量重新赋值为null
					clearInterval(this.interValId);
					this.interValId = null;
				}
			}
		});
```

`setInterval()`方法详解

JavaScript中的方法，可以在指定的周期内调用函数方法或计算表达式，会不断的循环下去，知道遇到`clearInterval()`方法执行下去



#### 事件捕获和时间冒泡

` @click`是开启一个点击事件的函数，方法是在Vue实例的Methods

`.stop`阻止冒泡

`.prevent`阻止默认事件

`.capture`添加事件侦听器时使用事件捕获模式

`.self`只当事件在该元素本身(比如不是子元素)触发时触发回调

`.once`事件只触发一次

事件捕获指的是从document到触发事件的那个节点，即**自上而下**的去触发事件

相反的，事件冒泡是**自下而上**的去触发事件

```html
<div class="inner">
    <!-- .stop可以阻止冒泡事件 -->
    <input type="button" value="戳一下" @click.stop="btnHandler">
</div>
```

**注意点：**`.self`和`.stop`不能相互替代使用，`.self`只能阻止元素本身冒泡行为触发的事件，`.stop`自身不响应事件，也阻止事件的传递



#### Vue指令

`v-cloak`可以解决表达式闪烁的问题

`v-text`的作用和插值表达式的功能一样，会覆盖元素中的原本的存在的内容，{{}}插值表达式不会覆盖原先元素中的数据

`v-html`插入的数据不会转义，可以添加一些<h1>等html标签

` v-bind`可以绑定一些数据，也可以添加一些合法的JS表达式（只能实现数据的单向绑定，从model层绑定到view层）

 `v-model`和双向数据绑定，是唯一一个实现双向数据绑定的语法（应用在表单元素中select、form、input、checkbox）

`class`操作class类的样式

1. 数组

```HTML
<h1 :class="['red', 'thin']">这是- 个邪恶的1</h1>
```

- 数组中使用三元表达式

```HTML
<h1 :class="['red', 'thin', isactive? "active' :"']">这是一个邪恶的H1</h1>
```

- 数组中嵌套对象
```HTML
<h1 :class"['red', 'thin', {'active': isactive}]"*>这是一 个邪恶的41</h1>
```

- 直接使用对象

```HTML
<h1 :class"{red:true, italic:true, active:true, thin:true}">这是一个邪恶的1</h1>
```

`v-for`循环和`key`属性，可以用来迭代数组和迭代对象，在遍历对象的键值对的时候，（val,key）中键是在后面

```HTML
<!-- v-for="" 后面可以接数字，对象，对象数组，数字 -->
<p>循环普通数组：</p>
<p v-for="(item, i) in list">索引值：{{i}} -----每一项的值：{{ item }}</p>
<p>循环对象：</p>
<p v-for="user in objectList">用户ID：{{user.id}} ----- 用户名：{{user.name}}</p>
<p>循环迭代数组</p>
<p v-for="count in 10">第{{count}}次循环</p>
```

#### 自制计数器

可以给click函数中在绑定一个函数，methods是方法，v-on:click可以被@click

```JavaScript
<div id="app">
    <h2>当前的数是{{counter}}</h2>
    <!--<button v-on:click="counter++">+</button>
    <button v-on:click="counter--">-</button>-->
    <button v-on:click="add">+</button>
    <button v-on:click="sub">-</button>
</div>
    <script src="../js/vue.min.js"></script>
    <script>
        const app = new Vue({
            el: '#app',
            data: {
                counter:0
            },
            methods:{
                add:function(){
                    this.counter ++;
                },
                sub:function(){
                    this.counter --;
                }
            }
        });
    </script>
```

