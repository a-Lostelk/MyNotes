---
typora-root-url: images
---

### 															Vue.JS学习之路

### 简介

**Vue.js**是一套构建用户界面的框架，**只关注视图层**，和其他的第三方库或框架也能较好的兼容结合

Vue是一个渐进式的框架，可以将Vue作为应用的一部分嵌入其中，其中有很多复用的组件

主要负责的是MVC中的View视图这一层



![](/QQ截图20191127210632.png)



Vue是属于**声明式编程范式**（代码和数据分离），JQuery是命令式编程方式

Vue将数据和页面分离，只要数据和页面绑定了关系，数据改变页面也会随之改变，而不需要改变页面



### MVC，MVVM的区别

用户对View的操作交给了Controller处理，在Controller中响应View的事件调用Model的接口对数据进行操作，一旦Model发生变化便通知相关视图进行更新。

MVVM与MVC最大的区别就是：**它实现了View和Model的自动同步**，也就是当Model的属性改变时，我们不用再自己手动操作Dom元素，来改变View的显示，而是改变属性后该属性对应View层显示会自动改变

Vue实例中的data相当于Model层，而ViewModel层的核心是Vue中的双向数据绑定



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

是前端分层的分发思想，将每个页面都分成了`M（model）、V（View）和VM（viewModel）`，VM是中间的调度者，**model层和view层时间的存取数据都要经过vm调度者**

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



#### **绑定函数**

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
				 	this.interValId = setInterval(() => {
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

`v-clock`可以解决表达式闪烁的问题

`v-text`的作用和插值表达式的功能一样，会覆盖元素中的原本的存在的内容，{{}}插值表达式不会覆盖原先元素中的数据

`v-html`插入的数据不会转义，可以添加一些<h1>等html标签

` v-bind`可以绑定一些数据，也可以添加一些合法的JS表达式（只能实现数据的单向绑定，从model层绑定到view层）

 `v-model`和双向数据绑定，是唯一一个实现双向数据绑定的语法（应用在表单元素中select、form、input、checkbox）

`class`操作class类的样式

`v-if`的值是布尔值，每次都会重新删除和创建元素，**涉及到频繁的切换不推荐使用**

`v-show`类似，不会对dom的删除和创建，切换了`display:none`属性，**切换的元素不经常使用或者永久删除不推荐使用**





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
<h1 :class"['red', 'thin', {'active': isactive}]">这是一 个邪恶的41</h1>
```

- 直接使用对象

```HTML
<h1 :class"{red:true, italic:true, active:true, thin:true}">这是一个邪恶的1</h1>
```

`v-for`循环和`key`属性，可以用来迭代数组和迭代对象，在遍历对象的键值对的时候，（val,key）中键是在后面

`v-for`循环的时候，只能使用Number属性来获得String类型

key在使用的过程，必须使用`v-bind`来对属性进行绑定

**Vue**实例在挂载指定的div中时，`v-model`绑定的数据自动和Vue实例下

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

可以给click函数中在绑定一个函数，methods是方法，`v-on:click`可以被`@click`简写

```html
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
                //this代表的是整个Vue实例
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



- 在Vue中，Vue 实例里 **data** 数据会自动和 **el** 指定的元素中的值绑定，当对data中的数据改变了，会自动将更新的数据应用到页面中

- `some()`方法，检测数组中的元素是否满足指定的条件的元素，会依次执行数组中的每个元素，遇到满足条件的元素后返回 **true** 其他的元素不再执行

  | 参数             | 描述             |
  | :------------- | :------------- |
  | *currentValue* | 必须。当前元素的值      |
  | *index*        | 可选。当前元素的索引值    |
  | *arr*          | 可选。当前元素属于的数组对象 |

- `splice()` 方法向/从数组中添加/删除项目，然后返回被删除的项目。

  | 参数                | 描述                                  |
  | :---------------- | :---------------------------------- |
  | index             | 必需。整数，规定添加/删除项目的位置，使用负数可从数组结尾处规定位置。 |
  | howmany           | 必需。要删除的项目数量。如果设置为 0，则不会删除项目。        |
  | item1, ..., itemX | 可选。向数组添加的新项目。                       |



- 在es6中新增了多个遍历的方法

  1. `forEach()`方法，返回的是对应索引位置的元素并组成一个新的数组对象，**该方法不会终止会全部执行**

     ```javascript
     search(keywords){
         let newList = [];
         this.list.forEach(item => {
             if (item.name.indexOf(keywords) != -1) {
                 newList.push(item);
             }
         })
     }
     ```

  2. `filter`方法，`includes()`和 **jquery** 中的`contains()`方法类似，**类似过滤方法，查询到的结果返回出去，也会遍历所有的元素**

     ```JavaScript
     search(keywords) {
         return this.list.filter(item =>{
             if(item.name.includes(keywords)){
                 return i;
             }
         })
     }
     ```

  3. `some()`方法，方法用于检测数组中的元素是否满足指定条件（函数提供），**找到了指定的元素停止查找，适合查询单一条件的情况**

     ```javascript
     del(id) {
         //根据id找到对应list中数据的索引
         this.list.some((i, d) => {
             if (i.id === id) {
                 this.list.splice(d, 1);
                 return true;
             }
         });
     },
     ```


  4. `findIndex()`方法，找对对应元素的索引值，**一般用于删除元素，需要得到对应的索引删除**

     ```JavaScript
     delById(id) {
         let index = this.list.findIndex(item => {
             if (item.id === id) {
                 return true;
             }
         });
         this.list.splice(index, 1);
     },
     ```




### 模板语法

#### {{}}和插值表达式的区别

`{{  变量名 }}`会数据转化为不同文本，在遇到一些特殊情况下，例如添加到span、button元素中，`v-html`指令输出将数据转换为HTML元素（**插值表达式**）



```html
<button v-bind:disabled="isButtonDisabled">Button</button>
```

如果 `isButtonDisabled` 的值是 `null`、`undefined` 或 `false`，则 `disabled` attribute 甚至不会被包含在渲染出来的 `<button>` 元素中



#### 使用JavaScript表达式

无论是插值表达式和{{}}的方式，所有涉及到数据的绑定和赋值，都能使用JavaScript表达式来实现

`{{ number + 1 }}`、

`{{ ok ? 'YES' : 'NO' }}`、

`{{ message.split('').reverse().join('') }}`、

`<div v-bind:id="'list-' + id"></div>`

例如：JS中的var声明语句，`if(true){return 1;}`这种流程控制语句也无法实现



### 过滤器

概念: Vuejs允许你自定义过滤器,可被用作一 些常见的文本格式化。过滤器可以用在两个地方: `mustache
插值和v-bind表达式`。过滤器应该被添加在JavaScript表达式的尾部，由“管道"符指示;

`Vue.filter()`方法，**注意：filter过滤器需要放在实例之前，在data实例实现双向数据绑定的时候完成过滤器需要的功能**

过滤器可以组合使用，过滤器后面再加过滤器

全局过滤器是可以被全局过滤器共享

```html
<p>{{ msg | msgFormat }}</p>
<script>
	Vue.filter('msgFormat', function (msg) {
        return msg.replace(/咸鱼/g, '咸鱼干');
    });
</script>
```

##### 私有过滤器	

全局过滤器是所有Vue实例共享的，也可以定义 **私有过滤器**  `filters`，和`data`、`Methods`一样是属于Vue实例的对象

```JavaScript
var app = new Vue({
   el: '#app',
   data: {},
   methods: {},
   filters: {},
});
```



### 自定义按键修饰符

```html
NAME: <input type="text" class="form-control" v-model="name" @keyup.enter="add">
```

`keyup`可以对电脑键盘监听，`enter`表示监听enter键，在监听到用户的键盘敲下回车键的时候回执行add（）方法，一些常用的电脑操作键都有配对的按键码



### 自定义指令

```javascript
// 注册一个全局自定义指令 `v-focus`
Vue.directive('focus', {
  // 当被绑定的元素插入到 DOM 中时……
  inserted: function (el) {
    // 聚焦元素
    el.focus()
  }
})
//要在需要聚焦的元素上添加v-focus
```

`directive()`函数绑定自定义的指令函数，所有的Vue指令是以`v-`的形式使用，`focus`是自定义的指令名，`inserted`是Vue提供的钩子函数

el表示被绑定元素，自定义函数绑定到`input`框中，el对象就表示的是el

#### 钩子函数

- `bind`：**只调用一次**，指令第一次绑定到元素时调用。在这里可以进行一次性的初始化设置。
- `inserted`：被绑定元素插入父节点时调用 ，元素插入的dom的时候，会执行一次
- `update`：所在组件的 VNode 更新时调用，**但是可能发生在其子 VNode 更新之前**。指令的值可能发生了改变，也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新 (详细的钩子函数参数见下)

**注意：** `bind`函数适用于为元素添加内联样式，`inserted`函数适用于在对JS有所操作的情况，

可以给`bind`函数传输指定的参数，i代表的就是传输的参数

```javascript
Vue.directive('color', {
    bind: function (el, i) {
        //对样式的操作不需要添加到内联样式中，因此一次添加也是可以生效的
        // el.style.color = 'red';
        el.style.color = i.value;
    }
});
```

##### 钩子函数参数

指令钩子函数会被传入以下参数：

- `el`：指令所绑定的元素，可以用来直接操作 DOM 。

- `binding`一个对象，包含以下属性：

  ：一个对象，包含以下属性：

  - `name`：指令名，不包括 `v-` 前缀。
  - `value`：指令的绑定值，例如：`v-my-directive="1 + 1"` 中，绑定值为 `2`。
  - `oldValue`：指令绑定的前一个值，仅在 `update` 和 `componentUpdated` 钩子中可用。无论值是否改变都可用。
  - `expression`：字符串形式的指令表达式。例如 `v-my-directive="1 + 1"` 中，表达式为 `"1 + 1"`。
  - `arg`：传给指令的参数，可选。例如 `v-my-directive:foo` 中，参数为 `"foo"`。
  - `modifiers`：一个包含修饰符的对象。例如：`v-my-directive.foo.bar` 中，修饰符对象为 `{ foo: true, bar: true }`。

- `vnode`：Vue 编译生成的虚拟节点。移步 [VNode API](https://cn.vuejs.org/v2/api/#VNode-接口) 来了解更多详情。

- `oldVnode`：上一个虚拟节点，仅在 `update` 和 `componentUpdated` 钩子中可用。

  ```JavaScript
  Vue.directive('color', {
      bind: function (el, i) {	//i表示的就是binding对象
          //对样式的操作不需要添加到内联样式中，因此一次添加也是可以生效的，i表示的是传输的对象
          // el.style.color = 'red';
          console.log(i.value);	//red	
          console.log(i.expression);	//'red'
          el.style.color = i.value;
      }
  });
  ```

`Vue.directive`也可以作为Vue实例的私有参数设置



#### 踩坑之指令名

`Vue`自定义的指令名不能和其他如CSS，JavaScript中的属性名一致，如`v-fontSize`会发生异常，而`v-fontsize`就不会发生异常了，`fontSize`是CSS中的属性名





### `Vue`的生命周期

`Vue`实例的新建到消亡，伴随着不同的事件，称为为生命周期，也叫 **生命周期钩子**

##### 创建阶段

- **beforeCreate**

  `Vue`实例创建之前执行的函数，无法访问`Vue`实例中的`data`和`method`属性

  ```JavaScript
  beforeCreate() {    //创建Vue实例之前的函数
       console.log(this.msg);  //undefined
       this.show();    //not a function
  },
  ```

- **created**

  `Vue`实例新建的时候回执行这个函数，这时候就可以访问`Vue`实例中的属性了

  执行完创建方法后，找到`el`挂载的 **DOM** 元素并将它编译为 **template** 模板

  **注意：编译模好的模板字符串只是在内存中渲染好的数据，并没有将数据挂载到`el`属性中对应的DOM元素上**

- **beforeMount**

  模板在内存中已经生成，并没有将模板渲染到页面中

  ```javascript
  beforeMount() {
      console.log(document.getElementById('app').innerText);
      //哈哈哈	但是在F12控制台依然是 ｛｛msg｝｝：说明msg中的值只是显示在页面中，并没有将msg的模板渲染到页面中去
  }
  ```

- **mounted**

  这时候内存中的模板才是正在的挂载到 **DOM ** 元素中并渲染数据，控制台F12就会显示真实的数据值，而不是插值表达式 {{ msg }}

##### 运行阶段

执行完`mounted`后，整个Vue实例已经初始化完毕

- **beforeUpdate**

  触发该事件的时候`data`数据一定是改变了，在内存中会生成一份新的 **DOM** 数据，但是并没有渲染到页面中，也就是说，`template`模板中并没有发生改变

- **updated**

  `beforeUpdate`和`updated`是相伴相随的，当数据改变了两者会一起改变，`data`数据的改变会发出0次到多次 

  执行该函数的时候，页面和data中的数据已经同步，即`model`和`data`中的数据已经同步了

##### 销毁阶段

- **beforeDestroy**

  执行该函数的时候，`Vue`实例进入准备销毁的阶段，但是在期间所有的组件、指令都是可用状态，这是准备销毁

- **destroyed**

  执行到该方法的时候，所有组件已经被销毁，也就是不可使用

![](/lifecycle.png)

### Vue中的AJAX请求

在Vue中不推荐使用jquery操纵dom元素，因此jQuery的ajax请求方式也不提倡

`vue-resource`实现get、post、jsonp请求，也可以使用`axios`的第三方包实现对数据的请求

`vue-resource`方式：

**get 、JSONP ** 的方式一样：第一个参数是请求地址，`.then`后面加的是回调函数，**POST** 的方式略微不同，因为Vue的POST方式必须有请求体 

```JavaScript
getInfo() {
    this.$http.get('http://vue.studyit.io/api/getlunbo').then(function (result) {
        console.log(result);
    });
}
```



#### 配置根域名

`Vue.http.options.root = 'http://localhost:8080';`

定于默认跳转的路径，在进行多次相同端口的ajax请求后就不要频繁输入端口地址等数据



#### JSONP的实现原理

由于浏览器的安全性限制。不允许AJAX访问**协议不同、域名不同、端口号不同**的数据接口浏览器认为这种访问不安全;
可以通过动态创建script标签的形式，把`script`标签的`src`属性,指向数据接口的地址,因为script标签不存在跨域限制,这种数据获取方式,称作**`JSONP`** (注意:根据`JSONP`的实现原理, `JSONP`只支持Get请求) ;

换言之，就是从当前页面跨域请求其他域的页面不可以，但是请求脚本可以，当前页面需要引入对应页面的跨域脚本才能



### Vue的动画

Vue的动画效果是希望在操作DOM元素的时候，提供多种过渡效果，提高用户的用户体验

工具

- 在 CSS 过渡和动画中自动应用 class
- 可以配合使用第三方 CSS 动画库，如 Animate.css
- 在过渡钩子函数中使用 JavaScript 直接操作 DOM
- 可以配合使用第三方 JavaScript 动画库，如 Velocity.js

#### 过渡的类别

过渡可以大致分为 **进入/离开** ，其中又有六种Class切换

![](/transition.png)

1. `v-enter`：定义进入过渡的开始状态。在元素被插入之前生效，在元素被插入之后的下一帧移除。
2. `v-enter-active`：定义进入过渡生效时的状态。在整个进入过渡的阶段中应用，在元素被插入之前生效，在过渡/动画完成之后移除。这个类可以被用来定义进入过渡的过程时间，延迟和曲线函数。
3. `v-enter-to`: **2.1.8版及以上** 定义进入过渡的结束状态。在元素被插入之后下一帧生效 (与此同时 `v-enter` 被移除)，在过渡/动画完成之后移除。
4. `v-leave`: 定义离开过渡的开始状态。在离开过渡被触发时立刻生效，下一帧被移除。
5. `v-leave-active`：定义离开过渡生效时的状态。在整个离开过渡的阶段中应用，在离开过渡被触发时立刻生效，在过渡/动画完成之后移除。这个类可以被用来定义离开过渡的过程时间，延迟和曲线函数。
6. `v-leave-to`: **2.1.8版及以上** 定义离开过渡的结束状态。在离开过渡被触发之后下一帧生效 (与此同时 `v-leave` 被删除)，在过渡/动画完成之后移除。

####  `transition`元素

#### 使用自定义style

是Vue官方提供的，用于定义需要添加动画的元素

```html
<style>
    /*初始和结束状态*/
    .v-enter,.v-leave-to {
        opacity: 0;
        transform: translateX(100px);
    }
    /*入场和离场动画时间段*/
    .v-enter-active, .v-leave-active {
        transition: all 1s ease;
    }
</style>
<body>
<div id="app">
    <input type="button" value="不使用动画" @click="flag=!flag">
    <h3 v-if="flag">this is a paragraph of H3 text</h3>

    <input type="button" value="使用动画" @click="flag1=!flag1">
    <transition>
        <h3 v-if="flag1">this is a paragraph of H3 text</h3>
    </transition>
    </div>
</body>
```

**自定义状态名**，只需要在`transition`标签中添加name属性，例如my，那么`v-`就变成`my-`了

#### 使用animate.css文件

在transition标签中添加过渡类别

```html
<transition enter-active-class="animated bounceIn" leave-active-class=" animated bounceOut">
    <h3 v-if="flag2">this is a paragraph of H3 text</h3>
</transition>
```

![](/QQ截图20200223152626.png)



#### 使用JavaScript钩子

```Html

<transition
v-on:before-enter="beforeEnter"
v-on:enter="enter"
v-on:after-enter="afterEnter"
v-on:enter-cancelled="enterCancelled"
v-on:before-leave="beforeLeave"
v-on:leave="leave"
v-on:after-leave="afterLeave"
v-on:leave-cancelled="leaveCancelled">
</transition>
<!--有时候只需要一部分动画，使用自定义style和animate.css很难完成，使用JavaScript钩子就可以-->
```

例如：

```html
<input type="button" value="使用钩子" @click="flag3=!flag3">
<transition
@before-enter="beforeEnter"
@enter="enter"
@after-enter="afterEnter">
    <div class="gouzi" v-show="flag3"></div>
</transition>
<script>
    let vm = new Vue({
    ....    
    ....
      methods: {
                //el表示要执行动画的元素，是操作DOM元素的对象
                beforeEnter(el) {
                    el.style.transform = "translate(0, 0)";
                },
                enter(el) {
                    el.offsetWidth;
                    el.style.transform = "translate(150px, 250px)";
                    el.style.transition = "all 1000 ease";
                },
                afterEnter(el) {
                    this.flag3 = !this.flag3;
                }
            }
        })
</script>
```

**注意**：类似`ul>li`这中列表元素，如果数据是动态生产`v-for`循环出来的，就不能使用`transition`标签，而是使用`transition-group`标签

`transition-group`中的tag属性指定要渲染的HTML元素



### Vue的组件化

什么是组件:组件的出现,就是为了拆分Vue实例的代码量的,能够让我们以不同的组件,来划分不同的功能
模块,将来我们需要什么样的功能,就可以去调用对应的组件即可。

#### 组件化和模块化

模块化：从业务逻辑的角度，比如说订单我们搞成一个模块，个人中心我们搞成一个模块

组件化：主要是功能的封装，一个功能的合集，IO，数据库等功能，前端代码的组件化是便于组件的重用

#### Vue创建组件

方式一：

`Vue.extend`：创建组件

```javascript
let extend = Vue.extend({
        template: '<h1>这是Vue创建的组件</h1>'
    });
```

`Vue.component("com", extend);`调用组件，**com**是调用组件名，**extend**是创建组件名，如果调用组件名是驼峰命名，要使用-区分驼峰命名

```html
<com></com>
```

方式二：

```JavaScript
Vue.component('myCom', Vue.extend({
    template: '<h1>这是Vue创建的组件的第二种方式</h1>'
}));

// 简化
Vue.component('myCom1', {
    template: '<h1>这是Vue创建的组件的第三种方式</h1>'
});
```

**注意：**template常见的html元素只有一个根节点，当设计到多个同级元素并排显示，

方式三：

```html
<template id="temp">
    <div>
        <h1>创建组件的第三种方式</h1>
    </div>
</template>

Vue.component('com2',{
template: '#temp'
})
```



#### 定义私有组件

`components`：vue实例的定义组件

```JavaScript
components: {
    com3:{
        template: '<h1>定义Vue的私有组件</h1>'
    }
}
```

组件中的`data`必须是一个function对象



### v-if和v-else

两者搭配使用，和平常的if-else差不多的作用

### component元素

`<component :is="comName"></component>`：is表示要展示的组件名称，comName要在配置类中

组件切换的过程中可能会发生一些竞争的事件，使用mode属性可以避免两者竞争，只有当一个组件切换完了，另一个组件才会进行

```html
<transition mode="out-in">
    <component :is="comName"></component>
</transition>
```



### vue路由

路由：**路由**（**routing**）就是通过互联的[网络](https://zh.wikipedia.org/wiki/互聯網)把[信息](https://zh.wikipedia.org/wiki/信息)从源地址传输到目的地址的活动。路由发生在[OSI网络参考模型中](https://zh.wikipedia.org/wiki/OSI模型)的第三层即[网络层](https://zh.wikipedia.org/wiki/网络层)

1. **后端路由：**每跳转到不同的URL，都是重新访问服务端，然后服务端返回页面，这意味着每次跳转都会重新发送请求，所有的请求URL地址都是对应的服务器的资源
2. **前端路由：**在单页面应用，大部分页面结构不变，只改变部分内容的使用，实际上只是JS根据URL来操作DOM元素

Vue的路由运行我们通过不同的URL访问不同的内容，例如**Vue的组件**

#### URL中的#号（Hash）

<https://www.cnblogs.com/joyho/articles/4430148.html>详解

#### NPM

```bash
npm install vue-router
```

如果在一个模块化工程中使用它，必须要通过 `Vue.use()` 明确地安装路由功能：

```js
import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
```

**案例：**

```html
<div id="app">
    <a href="#/login">登录</a>
    <a href="#/reg">注册</a>
    <router-view></router-view> <!--Vue提供的开启路由的标签-->
</div>
</body>
<script src="../js/vue.js"></script>
<script src="../js/vue-router-3.0.1.js"></script>
<script>
    // 组件的模板对象
    let login = {
        template: '<h1>登录组件</h1>'
    };
    let reg = {
        template: '<h1>注册组件</h1>'
    };

    // 创建路由对象
    let router = new VueRouter({
        routes: [
            {path: '/login', component: login}, //path是要监听的URL，component是要展示的组件
            {path: '/reg', component: reg}
        ],
    });

    let vm = new Vue({
        el: '#app',
        data: {},
        methods: {},
        router: router, //将路由对象注册到VUE实例中，用于监听URL地址的改变
    });
</script>
```

应用场景：当登录默认展示某个页面的时候，可以使用`{path: '/login', redirect: login}`

#### Vue中的query传参

`query`组件用来监听URL的传参，qu	ery对象里是传输的参数名和参数值



### webpack

前端的项目构建工具，是基于Node.js开发的前端工具

**问题：**在powershell中遇到无法加载执行webpack命令，解决步骤如下

1. win+X启动 **windows PowerShell（管理员）**

2. 若要在本地计算机上运行您编写的未签名脚本和来自其他用户的签名脚本，请使用以下命令将计算机上的 执行策略更改为 RemoteSigned 执行：`set-ExecutionPolicy RemoteSigned`

3. 查看执行策略：`get-ExecutionPolicy`

4. 问题解决

#### 案例：

![](/QQ截图20200306212238.png)

1. `npm init -y`初始化一个项目
2. `npm i jquery -S`下载jquery文件
3. `webpack 需打包的文件的路径 打包好输出的文件路径`

#### webpack的作用

1. webpack 能够处理JS文件的互相依赖关系;

2. webpack能够处理Js的兼容问题，把高级的、浏览器不是别的语法，转为低级的，浏览器能正常识别的语法，例如ES6中的语法在目前的浏览器就不能兼容


    `webpack .\src\main.js .\dist\bundle.js`打包后的bundle文件是生产环境下的打包文件，开发环境中的main.js需要

   **webpack.config,js**的配置文件：

   ```javascript 
   const path = require('path');
   
   module.exports = {
       entry: path.join(__dirname, './src/main.js'),   // 要打包的文件
       output: {
           path: path.join(__dirname, './dist'),   // 指定输出的位置
           filename: 'bundle.js',  // 指定输出的文件名称
       }
   };
   ```

#### cnpm淘宝镜像

安装淘宝镜像

`npm install -g cnpm --registry=https://registry.npm.taobao.org`

cnpm是npm的一个国内镜像，里面所有的模块都是根据国外的npm的内容复制，国外的网络访问受限，推荐使用淘宝镜像

` cnpm i`会根据在package.json中的依赖来下载所有的依赖

```json
{
  "name": "webpack-study",	// 项目名
  "version": "1.0.0",	// 版本号
  "description": "",
  "main": "index.js",
  "dependencies": {
    "jquery": "^3.4.1",		// 依赖的jquery
    "webpack": "^3.5.5"
  },
  "devDependencies": {
    "webpack-dev-server": "^3.10.3"
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev": "webpack-dev-server"		//开发环境下
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}	
```

![](/QQ截图20200306230039.png)

提示以上WARNING警告的时候，说明并没有下载完成的依赖