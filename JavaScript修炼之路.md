## JavaScript修炼之路									



### 弱类型和强类型区别

***JavaScript属于弱类型语言***

**强类型**:	一旦一个变量被指定了某个数据类型，如果不经过强制转换，那么它就永远是这个数据类型了
				定义了一个整型变量a,程序就不会将a当作字符串类型进行处理,约束越强越不容易出错,但在
				编写的时候会相对复杂一点
**弱类型**:	数据类型可以被忽略,一个变量可以赋予不同数据类型的值
				例如
				  

```JavaScript
 int a = 100;
     a = "1";		//这样是合法的

 int a = 100;
 int b = "1";
 int c = a + b; //结果是1001
 //实际上是字符串和数字的拼接,JavaScript没有强制转换的约束,因此适合于数字和字符串
 的拼接   
```



### JavaScript的数据类型

###### 原始数据类型(基本数据类型):

- ***number***:数字
- ***string***:字符串		
- ***Boolean***值
- ***null***和***undefined***是比较特殊的数据类型*

###### 对象类型

Object:**function**(函数),**Array**数组,**Date**(日期)在JavaScript中被当作对象

- `JS中所有的变量的都是对象,对象是一种复合的数据类型,可以保存不同的数据类型的属性内建对象基本数据类型都是属于JS的内建对象,在任何的ES的实现都可以直接使用,Math,String,Number`
  	 

##### 宿主对象

- JS运行环境提供的对象,主要是浏览器提供的对象

- DOM(文档对象模型):`Document Object Model`


- JS通过文档对象模型对HTML文档进行操作


- 文档:表示整个的HTML网页


- 对象:将网页中的每一部分都转换为对象


- 模型:使用模型来表示对象之间的关系,方便我们获取对象， 体现出节点与节点之间的关系




##### 节点

节点:是构成我们网页最基本的部分,网页的每一部分都是可以看做是一个节点

节点之间的关系构成了节点树的关系,最顶层的是document文档节点,一下是子节点html,head等后代元素,直到处

于所有级别最低的文本节点为止
	节点之间也有类型的区别:
					1. **标签**我们称之为**元素节点**,**属性**称之为**属性节点**,**文本**称之为**文本节点**,文档称为**文档节点**
	

   2. **文档对象:整个HTML文档**
      	 浏览器为我们提供文档节点,对象就是Window属性,可以在页面之后直接使用,文档对象代表的是整个网页

      - innerHTML是双向操作,可以读取指定元素的值也可以进行修改

      - BOM
        

  **自定义对象**
        
开发人员自己创建的对象

向对象添加属性:对象.属性名 = 属性值;

JS的属性值可以为任意数据类型,或者是另一个对象

in可以检查某个对象是否包含某个属性      
      

```javascript
 //可以使用对象字面量创建对象{}
 var obj = {}		==> var obj = new Object();
 /*它的原理是new构造器是相同的,可以在{}直接确定属性名和属性值
 实参可以是任意数据类型,也可以是一个对象,形参是根据实参的类型,函数也是一个对象,所以实参也可以是一个函数	*/
```



### JavaScript中的事件

文档或浏览器窗口中发生一些指定的交互瞬间、

JavaScript和HTML的交互是通过HTML实现的:点击按钮,点击元素等事件

`window.onload`是在整个页面加载完成后才会触发，该事件对应的响应函数会在页面加载完成之后执行,这样可以确保我们的代码所有的DOM对象都已经加载完毕了

?	假如JS脚本文件是在页面之前,就需要将script脚本放到`window.onload`函数中，js代码优先写在后面,后加载后执行	



#### 强制类型转换

##### 转换String类型

方式一:调用`toString()`方法,不会将原变量的类型改变,

方式二:调用`String()`函数,将需要被转换的参数作为参数传递给函数,使用String()函数的时候,对于Number和boolean实际上是调用`toString()`方法,对于null值和undefined,是将字面量转换成字符串,null转换为"null"

函数:`alter()`,`toString()`

方法:`a.toString()`

##### 转换Number类型

调用`Number()`函数

1）如果是纯数字的字符串直接转换成数字

2）如果字符串中有非数字的内容,就会被转换成NaN 

3) 如果字符串是一个空串,则转换成0

4) 布尔值true转1,false转0

调用`parseInt()`函数

把一个字符串转换成一个整型
parsetInt只会取整数	

如果对非String进行parseInt或者parseFloat操作的时候先转换成String类型然后在进行整型转换操作

1)Number类型转换boolean,除了0和NaN其他的都是true 

2)字符串转布尔,除了空**字符串、null和undefined**其他的都是true

3)任何值和字符串进行加法运算,都会转换为字符串,然后再进行字符串的拼接操作



### 函数（函数也是对象）

函数对象中可以封装一些功能(代码),在需要的时候执行这些功能

```JavaScript
var fun = new Function();	//创建一个函数对象
```

封装到函数中的代码不会**立即被执行**,会在函数被调用的时候执行

函数对象具有**普通对象**功能

在开发中一般不使用这种方式来创建函数对象



对象的属性值可以是**任意的数据类型**,也可以是**个函数**,当一个函数被作为一个对象的属性保存,那么这个函数是这个对象的方法

调用该函数就是调用对象的方法(method),

使用函数表达式来创建一个函数,匿名函数一定要以一个变量来接收封装	
在调用函数的时候解析器不会检查实参的类型和数量,所以多余的实参不会被赋值

##### 立即执行函数:

单独一个匿名函数是不允许的,将立即执行的函数放在一个括号中表示这是一个整体是成立的,函数定义完,会被立即执行函数,立即函数往往只执行一次,当执行完后会被回收,因为没有变量去保存它

```JavaScript
function 函数名(形参1,形参2)

	(function () {
        alert("这是一个立即执行函数(匿名函数)");
    })();
	
	obj.name();	//调用方法
	fun():		//调用函数
	
	 for(var变量 in 对象){}
	  for (var a in obj) {
        console.log(obj[a]);	//当前对象是a的话在被循环体中寻找a的值,类似于将
								//obj中的属性转换为一个数组,在数组中根据被循环赋值的变了a在obj中寻找对象的属性值
    }
	for in	//语句,对象中有几个属性,循环体就会被执行几次,每次执行的时候,都会把循环体对象中的值赋值给定义的变量
```

##### 作用域

一个变量的作用范围

变量的声明提前,使用***var*** 关键字声明的变量,<u>会在所有的代码执行之前被声明</u>

函数的声明提前,使用**函数声明形式**创建的函数,function函数(){} ,<u>会在所有的代码执行之前就被创建,会被最先被创建,可以在声明之前调用</u>



###### 	1.全局作用域

直接编写在script标签中中的 JS代码,<u>在页面打开的时候创建,在页面关闭的时候销毁</u>,Windows是**全局对象**,代表的是**一个浏览器的窗口**

在全局作用域中,**创建的对象都会作为Windows对象的属性保存下来,创建的函数都会作为Windows对象的方法保存，**所谓的函数其实就是Windows对象的方法

***全局作用域中的变量在任意部位都可以被访问***

###### 	2.局部作用域(函数作用域)

调用函数时创建函数作用域,**函数执行完毕的时候,函数作用于销毁**

每调用一次函数就会创建一个新的函数作用于,**函数作用域之间是相互独立的**

在函数作用域中**可以访问全局作用域的变量**,但是**全局变量不可以访问到函数作用域的变量**

当在函数作用域中操作一个变量,首先会在**自身的作用域**中寻找,如果存在直接使用,如果不存在去**上一级作用域**中寻找,可以是一级作用域或是全局作用域

在函数中访问全局变量使用Windows对象	

##### this关键字

解析器每次调用函数的时候都会向函数内部传递一个**隐式的this函数**

this指向的是一个对象,这个对象称为**函数执行的上下文对象**,根据函数的调用方式的不同,this**指向的不同的对象**

```JavaScript
	function fun(a, b){
				console.log(this);
			}
			var obj = {
				name:"sunny",
				sayName:fun 	//对象的属性可以为任意数据类型和函数
			};
			obj.sayName();	//[object Object]由obj对象调用,this指向的是上一级Object对象
			fun();			//[object Window]由Windows对象调用,this指向的父级Windows对象
```



**小结**:	以函数形式调用时,this指向的是Windows对象 fun();

以方法形式调用,this指向的是调用方法的那个对象 obj.fun;

以构造函数的形式调用时候,this指向的就是新创建的那个对象

***谁调用函数的,this就指向谁***

 

##### 原型prototype

当我们访问一个对象的属性的时候,首先会在对象中寻找,存在直接使用,如果不存在会在**原型对象**中寻找

 将**共享的属性**添加到构造函数的原型对象中,就不用为每一个对象添加属性,不会破坏区全局作用域,属于该类的实例对象都具有这些**属性和方法**

 使用in检查对象中是否由某个属性,如果对象中没有,但是原型中有,也会返回true

 ***hasOwnProperty***来检查对象中是否拥有某个属性,当对象中含有该属性的时候才会返回true，原型对象也是一个对象,所以原型对象也是有原型的



每次创建一个函数的时候,解析器都会想函数中添加一个属性,这个属性就是原型,这个属性对应的是一个对象,这个对象就是原型

*原型对象就相当于一个公共领域,所有同一类的实例都可以访问到这个原型对象作用,通过原型对象添加的属性,这一类的所有实例都可以通过原型对象添加该属性*
	object对象每页原型,但是还是有hasOwnProtoType

toString	
	当在页面打印一个对象实际上输出的是该对象的toString()的返回值
	

##### 垃圾回收

当一个对象没有任何变量和属性对他进行引用,此时该对象我们无法操作,此时该对象就是一个垃圾
和Java相似,JS也有自动的垃圾回收机制,会自动将这些垃圾对象从内存中销毁

##### 数组对象

数组的存储性能比普通对象好
0ar arr = new Array();  ==>var arr = [];
字面量创建数组,在创建的时候指定数组之后的元素
var arr = []1,2,3,4];
数组中的元素可以是任意类型的数据类型,也可以是对象,甚至是一个函数
数组的遍历:
for in 和for循环的区别
前者可以遍历数组中的对象,循环的数组下标typeOf是String类型,后者相对for in 循环优越一点,数组的下标是Number类型

for(var i = 0; i < arr.length; i++){}
?		forEach循环需要一个函数作为参数,数组之后有几个元素,函数就会执行几次
?		执行forEach循环的时候中会传递三个参数:当前正在遍历的元素,当前遍历元素的索引,当前比那里的对象
?		forEach(function (value, index, obj){
?			

		});
		另外forEach在IE8 中不支持,为了考虑不同浏览器的区别,有的时候不能使用forEach循环

数组的方法
	push():向数组的末尾添加一个或多个元素,并返回数组新的长度,自动回将需要添加的元素添加到数组的末尾
	pop():删除数组的最后一个元素并返回数组的长度
	unshift():向数组的开头添加元素,并返回新的数组的长度
	shift():删除数组的第一个元素,并将被删除的数组元素作为返回值
	slice():可以从数组中提取指定元素
			arr.slice(start.end);
			start选定数组的开始位置索引,必选,若为负数则是数组末尾开始的位置，-1 指最后一个元素，-2 指倒数第二个元素，以此类推。
			end选定数组的结束位置索引,可选
	splice() 方法用于插入、删除或替换数组的元素,会将指定元素从原数组中删除,并将被删除的元素作为返回值返回
	concat()方法用于连接两个或多个数组该方法不会改变现有的数组，而仅仅会返回被连接数组的一个副本。
	join()可以将数组转换成一个字符串,不会对原数组产生影响,而是将转换后的字符串作为结果返回
			在join中可以指定一个字符串作为参数,这个字符串称为数组中元素的连接符
	sort()
		可以用于对数组进行排序
		如果要决定排序的顺序,根据回调函数返回值来决定元素的顺序
		返回值大于0,元素位置会发生改变,小于或者等于0,元素的位置都不会发生改变
		例子
			//a代表两个比较元素中前一个元素,b代表后一个元素
			arr.sort(function(a,b){
				return a - b;		//如果a - b 的值大于0,则位置改变,反之就不改变
				return b - a;		//降序操作
			});
				

函数对象的方法
	call 和 apply可以将一个对象指定为第一个参数,此时这个对象将会成为这个函数执行this对象
	以函数调用的方式,this指向是Window(fun()),fun.apply(obj)或者fun.call(obj)的this指向的就是参数obj
	call()方法将实参在对象后面依次传递, fun(obj,2,3);
	
argument参数
	在调用函数的时候,浏览器每次都会传递两个隐含的参数,
	1.函数的上下文对象,this
	2.封装实参的对象argument是一个类数组对象,可以通过索引来获取数据或者获取长度


Date对象
	时间对象,
	如果直接使用构造函数创建的Date对象,则会封装当前代码执行的时间
	getTime获取当前日期对象的时间戳,从格林威治标准时间的1970/1/1 0:0:0开始到当前日期所花费的时间 ,
	格林威治时间加上这个时间差就是当前时间

Math对象
	不是一个构造函数,属于一个工具类对象,封装了一些数学计算的方法和属性

包装类
	 JS中有三个包装了,通过包装类直接将基本数据类型转换为对象
	 使用构造函数创建的都是对象,new Number() new String()
	 两个值是一样的对象是不相等的,== 比较的是内存地址,对象在堆内存中分配的地址不同的
	 String()字符串
	 Number()数字
	 Boolean()布尔值
	 在实际应用中,不会使用基本数据类型的对象,在进行一些比较的时候回出现一些不可预料的结果
	 对象转为布尔值的结果都是false


字符串
	字符串在底层是以字符数组的形式保存的,


使用工厂方法创建对象
	大批量创建相似类似对象 ,将需要创建的属性通过形参传递给工厂对象进行批次两创建对象
	缺点:使用工厂方法创建的对象,使用的构造函数都是Object,所以无法区分出多种不同的类型的对象
	
	构造函数和普通函数没有什么区别,习惯上构造函数的首字母是大写
	构造函数和普通函数的区别是调用方式的区别,普通函数是直接调用, 构造函数是需要使用new关键字
	构造函数的执行流程,
	1.立即创建一个新的对象
	2.新建的对象设置为函数中的this,
	3.逐行执行函数中的代码
	4.将新建的对象作为返回值返回
	
	instanceOf检查一个类是否是另一个对象的实例
	所有的对象都是Object的后台,任何对象都是instanceOfObject的结果都是true,包括windows对象 

运算符
	加法:
	通过运算符对一个或多个值进行运算,并获取返回结果,运算符不会对原变量改变
	typeof就是一个运算符返回的是一个值得类型
	对非number的值信息运算的时候,会将字符串尝试转换number再进行运算
	任何值和null运算的结果都是NaN
	字符串进行相加相当于字符串的拼接
	减法:
	和加法不相同的是,在减法操作中所有的字符串都是会转换成number类型进行算数操作
	例:100 - 1 = 100 - "1";
	乘法*
		对字符串进行操作会将字符串转换成number类型	
		var a = "123";
		a = a -0;	//会将String类型转换为number类型
		和number()函数是相等的
	除法/
		对字符串进行操作会将字符串转换成number类型	
		
	一元运算符
	只需要一个操作符,a = 1+2是二元运算符,有两个操作的数字
	+正号
		不会对数字产生什么影响,
	-负号
		对数字进行负号的取反
	可以通过一元运算符将一些值转换为number类型的值,将其他的数据类型使用+号转换成number类型,原理是和Number()
	函数是一样的
	对于任意数据类型的值,通过一元运算符都可以转变为number数据类型
	
	自增运算符
		a++ 和 ++a
		a++中a的值是等于原变量的值(自增之前的变量的值)
		++a中a的值是等于原变量新值(自增后的值)
		
		例子:
			 var a = 20;
			/**
			 * 此时实际上是执行了两次的赋值操作,先进行a++的操作的值是等于21,a++得值是20,
			 * 此时的a进行二次赋值等于20把第一次操作的值覆盖了
			 */
			a = a++;
			console.log(a);	//a = 20
	自减运算符
		a--的值是等于原变量的值
		--a的值是自减后变量的值
		
	逻辑运算符
		!非		对一个值进行非运算,对一个布尔值进行取反操作
				如果对非布尔值进行会先转换为布尔值然后进行取反操作,可以利用这一特性将其他数据类型转换
				成boolean值,进行两次布尔取反,转换为布尔值(隐式转换)
		&&与	对符合两次的值进行与运算并返回一个结果,
				必须同时为true
				两个值中只要有一个师false就会返回false,只有两个true才是返回true
		||或	只要两个中有一个是true就返回true,只有两个是false才返回false
				当第一个值是true不会检查后面的值,当第一个的值是false时才会对第二个值进行匹配运算
				
		==相等运算符	判断两个值是否相等,返回结果是布尔值,如果两个值类型不同,会自动进行类型转换(隐式转换)
						布尔值true和任何的number类型的值作比较结果都是true
						null和0不想等
		!=		判断两个值是否不相等,
		undefined衍生于null,所有两者是相等的,
		NaN不和任何值相等,包括它本身
		
	不相等运算符==
		判断两个值是否相等给,如果不相等返回true,否则返回false
		不相等也会对类型进行自动转换,转换后相等也会返回false
		
	全等运算符===
		判断两个值是否相等,如果两个值的类型不相等直接返回false
		可以用来获取两个值中的最大值最小值进行比较

条件运算符(三元运算符)
	添加表达式?语句1:语句2
	中心的流程:
		首先会对条件表达式,如果该值为true执行语句1,为false执行语句2
		var a = 10, b = 20;
		a>b ? alert("a big than b ") : alert ("b big than a "); 

Unicode编码
	在字符串中使用\u转义字符
	
流程控制语句
	
				
隐式转换
		实际上是调用了String()或者Number()等函数
		+ -
		var a = "37" - 7;		//会被理解为减法运算
		var n = "37" + 7;  		//会被理解为字符串拼接
		
		转化类型的小技巧
		num - 0					//将变量num转换成数字类型
		num + ""				//加上空字符串就是将num变为字符串类型
	
		"1.23" = 1.23;			//结果是true,会将字符串尝试转换成数字类型进行比较
		
		严格等于 ===
		a === b 				//首先会判断两边的类型,类型不同的返回false,类型相同会比较值
		JavaScript中的对象比较是引用比较,而不是值比较,
		
		null == undefined		//两者是相等的
		num == string 			//字符串会转换成数据number类型
		boolean == ?    			//不管布尔值会和什么作比较首先会将布尔值转换成number类型,true为1,false为0进行比较
		Object == number/string 	//会尝试将对象转换成基本类型,进行比较

包装类型							
		number,string,boolean都有对应的包装类型
		var str = "string";					//这是一个基本类型,没有属性,也不会有方法
		var strObj = new String("string");	//string基本类型对应的包装类
		当将一个基本类型当成对象的方式转换为对应的包装类型对象
		"str"  --------->"strObj"包装类型,该对象就有了属性,此时是一个临时对象,当完成对临时对象的操作的时候
		该对象会被销毁,再次对该对象进行赋值等相关操作的时候,该对象会成为undefined 
	
类型检测
		typeOf :
			适合函数类型和 基本类型的判断 typeof100	//number  typeof true //boolean	 type function  //function
			typeof null //object		typeofNaN //number
			typeof(undefined)	//undefined
			遇到null会失效
			
		instanceOf 
			判断对象类型,基于原型链	,判断前者的对象是否属于后者的类型
			不同的窗口对象IFram是不能用instanceof比较
			适合于自定义对象,也可以用于检测原生对象
		Object.prototype.toString	适合内置对象和基本类型,遇到null和undefined失效
		constru
		duck type

表达式
	能计算出值的任何一种可用程序单元
	对于JavaScript来说是一种js段语,可以使js解释器产生一个值
原始表达式
	常量,直接量		3.14 "test"
	关键字			null , this , true 
	变量			m , b , i 
	原始表达式组合就成了复合表达式
	10 * 20 		复合表达式
	[1,2,3] 		相当于new Array(1,2,3)
	[1, , 2]		相当于[1,undefined,undefined,2]
	
```JavaScript
/*函数表达式:将函数赋值给一个对象
调用表达式:调用函数 函数名加上括号就是调用
对象创建表达式
属性访问表达式*/

function foo() {
}
foo.prototype.x = 1;
var obj = new foo();
obj.x;
obj.hasOwnProperty("x");  				//不是对象的直接属性`      		
obj.__proto__.hasOwnProperty("x");		//拿到对象的原型
	
//全局作用域下,this代表的是window对象(浏览器),在函数方法中,this代表的是方法对象本身
```

block块语句
	花括号定义多个语句
	没有块级作用域
	
函数
	var p ;
	var obj = {x:1,y:2}
	
	for(p in obj ){}


严格模式
	是一种特殊的执行模式,修复了部分语言的不足,提供了更强的错误检查并增强了安全性
	在函数中或者函数开头第一个加上"use strict"
	严格模式不允许使用with语句
	 如果是在全局作用域中（函数外部）给出这个编译指示，则整个脚本都将使用严格模式。
	 

对象
	对象包含一系列的属性,属性是无序的,每个字符串都有一个字符串和对应的value值
对象的等级划分
	javascript任何值或变量都是对象，但是我还需要将javascript中的对象分为一下几个等级
	Object是最高级对象,Function一级对象,String，Array，Date，Number，Boolean，Math等内建对象
	是二级对象,剩下的由用户自主创立的都是低级对象
原型prototype
	prototype是一个属性,本身也是一个对象,JavaScript中所有的函数都具备这个属性,反之具备这个
	属性的都是i函数,函数才拥有这个prototype属性
__proto__和原型链
	__proto__是一个指针
	__proto__的指针指向的是构造对象的prototype属性,
	所有的JavaScript对象都具备这个属性
	__proto__可以访问创建当前对象的上一级对象的prototype属性,当对象访问一个方法或者属性时.
	首先会在自身查找,然后在沿着原型链去查找
	在JavaScript中,几乎所有的对象的原型链的终点都是Object对象的Object.prototype对象
	赋值的操作不会在原型链中向上查找

hasOwnProperty:判断是否在当前对象的原型中,判断属性是否存在,
propertyIsEnumerable:判断某个属性那个是否在某个对象中.判断某个属性是否可以被枚举
Object.defineProperty定义新属性或修改原有的属性。
enumerable 可枚举性
	为false表示不可枚举
	 * for..in循环
	 * Object.keys方法
	 * JSON.stringify方法

Check复选框
	checked = true 使得多选框都是属于选中状态
	=false让多选框属于取消选中状态
	item[i].checked = !checked;	//取反

在事件的响应函数中,函数绑定给谁,this指针指向的就是谁
	
getter和setter方法
	
										
变量作用域
	作用域分为局部变量和全局变量
	函数内部的局部变量可以读取全局变量,而函数外部是无法读取函数内部的局部变量
	JS的作用域不是花括号级的而是函数级的
JS的数据类型
	分为两种:值类型(原始类型),引用类型
	原始类型:存储在栈中的简单数据段,他们的值是直接存储在变量访问的位置
	引用类型:存储在堆中的对象,存储在变量的值是一个引向存储对象的内存指针
	
JSON
	JS中的对象只对JS有效.JS引擎并不能解析其他语言的的数据
	所有的语言都可以解析字符串,数字,不同的语言创建出的对象是不相同的
	JSON的本质是一大串字符串拼接的对象,是特殊格式的字符串,这样所有的语言都能解析识别
	并且可以转换为任意面向对象语言中的对象
	
	在开发中JSON中的作用,不同语言的数据传递,JSON和JS对象的格式基本相同,JSON字符串中的属性名
	必须使用双引号
	
	JSON分类
	1.{}对象
	2.[]数组
	JSON中允许的值:字符串,数值,布尔值,null,对象(普通对象,不能是函数对象),数组

工具类
	JavaScript为我们提供了一个工具类,用于对象和字符串的互相转换
	JSON字符串对象或数组转为JS对象
	JSON.parse(json);
	JS对象转换为JSON字符串
	JSON.stringify(json2);

javascript语言是一门“单线程”的语言，不像java语言，类继承Thread再来个thread.start就可以开辟一个线程,
	javascript就像一条流水线，仅仅是一条流水线而已，要么加工，要么包装，不能同时进行多个任务和流程

innerHTML在js中是双向功能:获取对象的内容或是面向对象插入内容

计算机中堆栈的概念(物理内存)
	都是在计算机的RAM内存中
	1)每个线程都分配一个栈,栈是执行线程所需的内存空间,由栈顶和栈底的概念,
	  栈顶的数据是最先被取出和适应的,后进先出
	2)堆是动态预留的空间,堆没有固定的排序方式和顺序的概念,可以在任何时候使用和释放堆中的数据对象,
	  有许多的堆分配策略
	3)每个线程都有一个栈,而每一个应用程序公用一个堆
	4)栈会自动释放,堆需要手动释放
	
	Stack:
	1.?和堆一样存储在计算机 RAM 中。
	2.?在栈上创建变量的时候会扩展，并且会自动回收。
	3.?相比堆而言在栈上分配要快的多。
	4.?用数据结构中的栈实现。
	5.?存储局部数据，返回地址，用做参数传递。
	6.?当用栈过多时可导致栈溢出（无穷次（大量的）的递归调用，或者大量的内存分配）。
	7.?在栈上的数据可以直接访问（不是非要使用指针访问）。
	8.?如果你在编译之前精确的知道你需要分配数据的大小并且不是太大的时候，可以使用栈。
	9.?当你程序启动时决定栈的容量上限。
	Heap：
	1.?和栈一样存储在计算机RAM。
	2.?在堆上的变量必须要手动释放，不存在作用域的问题。数据可用 delete, delete[] 或者 free 来释放。
	3.?相比在栈上分配内存要慢。
	4.?通过程序按需分配。
	5.?大量的分配和释放可造成内存碎片。
	6.?在 C++ 中，在堆上创建数的据使用指针访问，用 new 或者 malloc 分配内存。
	7.?如果申请的缓冲区过大的话，可能申请失败。
	8.?在运行期间你不知道会需要多大的数据或者你需要分配大量的内存的时候，建议你使用堆。
	9.?可能造成内存泄露。

ajax
	相当于在客户端和服务端之间加了一个抽象层,用户请求和服务器响应异步化,并不是所有的请求都直接
发送给服务器,减缓了服务器的压力,一些简单的数据处理和验证都是交给ajax引擎工作,只有在确认需要提交
服务器的时候ajax引擎才会向服务器提交请求

优点
	页面无刷新提交数据
	异步不打断用户操作与服务器通信
	减少服务器的压力
	界面和应用分离
	

### JSON

JSON是JavaScript Object Notation的缩写，它是一种数据交换格式

- number：和JavaScript的`number`完全一致；
- boolean：就是JavaScript的`true`或`false`；
- string：就是JavaScript的`string`；
- null：就是JavaScript的`null`；
- array：就是JavaScript的`Array`表示方式——`[]`；
- object：就是JavaScript的`{ ... }`表示方式。

JSON的字符串规定必须是UTF-8格式，是通用的数据格式传输语言

toJSON()：序列化对象

JSON.parseJSON（）：反序列化JSON字符串 



### AJAX

**Asynchronous JavaScript and XML**，意思就是用JavaScript执行**异步网络请求**。

同步请求中，form表达提交后，页面会刷新，操作结果会在页面上展示给用户，遇到网络不佳或是某种意外情况，甚至会返回一个404页面

Web的运算原理：一个HTTP请求对于一个页面

