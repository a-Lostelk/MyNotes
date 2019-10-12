---
typora-root-url: images
---

### 															Vue.JS学习之路

### 简介

**Vue.js**是一套构建用户界面的框架，**只关注视图层**，和其他的第三方库或框架也能较好的兼容结合

主要负责的是MVC中的View视图这一层



### MVVM

是前端分层的分发思想，将每个页面都分成了M（model）、V（View）和VM（viewModel），VM是中间的调度者，model层和view层时间的存取数据都要经过vm调度者

![](/QQ截图20191010190020.png)



#### vue.js的基本语法

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



在一些网络延迟或某种情况数据没有加载出来，会出现插值表达式显现{{  }}直到数据读取到view视图，

`v-cloak`可以解决表达式闪烁的问题

`v-text`的作用和插值表达式的功能一样，会覆盖元素中的原本的存在的内容，{{}}插值表达式不会覆盖原先元素中的数据

`v-html`插入的数据不会转义，可以添加一些<h1>等html标签

` v-bind`可以绑定一些数据，也可以添加一些合法的JS表达式



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

