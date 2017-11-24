
function $(args){										
	return new Base(args);
}


function Base(args){
	this.elements=[];	
	if(typeof args=='string'){
		if(args.indexOf(' ')!=-1){							//判断传进来的值是否空格,有就返回位置没有就返回-1
			var elements=args.split(' ');				//把传进来的值以里面的空格为节点,分割成一个数组,所以elements就是一个数组
			var childElements=[];							//存放临时节点对象的数组，解决被覆盖的问题
			var node=[];
			for(var i=0;i<elements.length;i++){
				if (node.length == 0) node.push(document);	//如果默认没有父节点，就把document放入,就比如,第一个参数放.a或放纯标签
				switch(elements[i].charAt(0)){
					case '#':
						childElements=[];							//清理掉临时节点，以便父节点失效，子节点有效
						childElements.push(this.getId(elements[i].substring(1)));
						node=childElements;							//保存父节点，因为childElements要清理，所以需要创建node数组	
					break;
					case '.':
							childElements=[];
							for(var j=0;j<node.length;j++){
								var temps=this.getClass(elements[i].substring(1),node[j]);
								for(var k=0;k<temps.length;k++){
									childElements.push(temps[k]);
								}
							}
							node=childElements;
					break;
					default :
						childElements=[];
						for(var j=0;j<node.length;j++){
							var temps=this.getTagName(elements[i],node[j]);
							for(var k=0;k<temps.length;k++){
								childElements.push(temps[k]);
							}
						}
						node=childElements;
				}	
			}
			this.elements=childElements;
			//alert(this.elements.length);
		}else{
				//find方法查找
				switch(args.charAt(0)){								//截取第一个字符
					case '#' :
						this.elements.push(this.getId(args.substring(1)));			//因为这里getId是返回节点，其它是返回数组
					break;
					case '.' :
						this.elements=this.getClass(args.substring(1));		//这里不能直接给数组赋值this.elements=this.getClass(args.substring(1));	
					break;
					default :
						this.elements=this.getTagName(args);
				}
			}
	} else if (typeof args == 'object') {
		if (args != undefined) {   			 
			this.elements[0] = args;
		}
	}
}


Base.prototype.getId=function(id){																//获取ID方法
	return document.getElementById(id);
}

Base.prototype.getTagName=function(tag,parentNode){
	var node=null;
	var temps=[];
	if(parentNode!=undefined){
		node=parentNode;
	}else{
		node=document;
	}
	var tags=node.getElementsByTagName(tag);									//获取TagName方法
	for(var i=0;i<tags.length;i++){
		temps.push(tags[i]);
	}
	return temps;
}

//获取元素节点个数
Base.prototype.length=function(){
	return this.elements.length
}

Base.prototype.getClass=function(className,parentNode){			//实现了1个参数时，在所有的标签下面查找class=red
	var node=null;
	var temps=[];
	if(parentNode!= undefined){
		node=parentNode;
	}else{
		node=document;
	}
	var all=node.getElementsByTagName('*');
	for(var i=0;i<all.length;i++){
		if((new RegExp('(\\s|^)' +className +'(\\s|$)')).test(all[i].className)){
			temps.push(all[i]);
		}
	}
	return temps;
}



Base.prototype.find=function(str){							//实现了,$('p').find('span').css('color','red'); p标签下查找span标签
	var linshi=[];
	for(var i=0;i<this.elements.length;i++){
		switch(str.charAt(0)){
			case '#':
				linshi.push(this.getId(str.substring(1)));
			break;
			case '.' :
				var temps=this.getClass(str.substring(1),this.elements[i]);
				for(var j=0;j<temps.length;j++){
					linshi.push(temps[j]);
				}
				break;
			default :
				var temps=this.getTagName(str,this.elements[i]);
				for(var j=0;j<temps.length;j++){
					linshi.push(temps[j]);
				}
		}
	}
	this.elements=linshi;
	
	return this;
}

//封装动画
Base.prototype.animate=function(obj){		
	for(var i=0;i<this.elements.length;i++){												
		var elements=this.elements[i];		//如果下面直接用this.elements的话，所代表的this对象不同,所以要赋值	
		var attr = obj['attr'] == 'x' ? 'left' : obj['attr'] == 'y' ? 'top' : 
						obj['attr'] == 'w' ? 'width' : obj['attr'] == 'o' ? 'opacity' : obj['attr'] 
						== 'h' ? 'height' : obj['attr']!=undefined ? obj['attr'] : 'left';			//可选，left和top两种值，不传递则默认left
		var step = obj['step'] != undefined ? obj['step'] : 20;		//可选，默认每次运行20像素
		var target = obj['target'];												//必须，增量，运行的目标点
		var type = obj['type'] == 0 ? 'constant' : obj['type'] == 1 ? 'buffer' : 'buffer';
		var start=obj['start']!=undefined ? obj['start'] : attr=='opacity' ? parseFloat(getStyle(elements,attr))*100:
																			   parseInt(getStyle(elements,attr));
		var mul=obj['mul'];
		if(attr=='opacity'){
			elements.style[attr]=start / 100;
		}else{
			elements.style[attr] = start + 'px';							//实现的是点击第二次从start的位置开始
		}
		if(attr=='opacity' && target < parseFloat(getStyle(elements,attr))*100){
			step=-step;															//实现透明度渐变的步数
		}
		else if(target<parseInt(getStyle(elements,attr))){
			step=-step;
		}	
		if (mul == undefined) {				//这句话当同步动画变成单独动画时，加上这句话有点不明
			mul = {};
			mul[attr] = target;
		}
		clearInterval(elements.timer);
			
		
		//timer前面加上elements,实现了多个对象用不同的定时器,防止了运行错误
		elements.timer=setInterval(function(){									//如果这里的timer不加var 代表的是window下的属性

			var flag=true;
			for(var i in mul){
				attr=i=='y' ? 'height' : i== 'x' ? 'left' : i!=undefined ? i : 'left';
				target=mul[i];
				if(type=='buffer'){
					/*step = attr == 'opacity' ? (target - parseFloat(getStyle(element, attr)) * 100) / speed :
														 (target - parseInt(getStyle(element, attr))) / speed;*/
														 //直接这样判断会更简洁省略了if语句
					if(attr=='opacity'){
						step=(target-parseFloat(getStyle(elements,attr))*100) / 6;			//实现了渐变颜色的缓冲运动
						step=step>0 ? Math.ceil(step) : Math.floor(step);
					}else{
						step=(target-parseInt(getStyle(elements,attr))) / 6;
						//step=step>0 ? Math.ceil(step) : step<0 ? Math.floor(step) : Math.floor(step); //这种判断不好
						step=step>0 ? Math.ceil(step) : Math.floor(step);
					}
				}
					/*
				问题1：多个动画执行了多个列队动画，我们要求不管多少个动画只执行一个列队动画
				问题2：多个动画数值差别太大，导致动画无法执行到目标值，原因是定时器提前清理掉了
				
				解决1：不管多少个动画，只提供一次列队动画的机会
				解决2：多个动画按最后一个分动画执行完毕后再清理即可
			*/
					 
			
				if(attr=='opacity'){
					
					if(step==0){
						setOpacity();	
					}
					else if(step>0&&Math.abs(parseFloat(getStyle(elements,attr))*100 - target ) <= step){		
						setOpacity();
					}
					else if(step<0&&(parseFloat(getStyle(elements,attr))*100 - target ) <= Math.abs(step)){
						setOpacity();
					}
					else{
						elements.style[attr] = (parseFloat(getStyle(elements, attr))*100 + step) / 100;
					}	
					
					if (parseInt(target) != parseInt(parseFloat(getStyle(elements, attr)) * 100)) flag = false;
					
				}else{
					if(step==0){
						setTarget();	
					}
					else if(step>0&&Math.abs(parseInt(getStyle(elements,attr)) - target ) <= step){		
						setTarget();
					}
					else if(step<0&&(parseInt(getStyle(elements,attr)) - target ) <= Math.abs(step)){
						setTarget();
					}
					else{
						elements.style[attr] = parseInt(getStyle(elements, attr)) + step + 'px';
					}
					if(target !=parseInt(getStyle(elements, attr))) flag=false;
				}
			}
			if(flag){
				clearInterval(elements.timer);				//解决了问题1,2		
				if(obj.fn!=undefined) obj.fn();				     //实现了动画列队，动画挨个播放
			}
		},50)
		
		function setTarget(){
			elements.style[attr]=target+'px';
			
		}
		function setOpacity(){
			elements.style[attr]=target / 100;
			clearInterval(elements.timer);									
			if(obj.fn!=undefined) obj.fn();					//在定时器末未添加结束运动时的函数
		}
	}
	
	return this;
}

Base.prototype.css=function(attr,value){
	for(var i=0;i<this.elements.length;i++){
		if(arguments.length==1){										
			//return this.elements[i].style[attr];						//这种方法只能获取到标签里面的行内属性,不能获取到css表里的样式
			//return this.elements[i].currentStyle[attr];
			return getStyle(this.elements[i], attr);			//window下的方法 以rgb的形式返回颜色、可以获取css表中的样式
		}
		this.elements[i].style[attr]=value;
	}
	return this;
}

//设置获取css样式表中的样式
function getStyle(duixiang,attr){
	return window.getComputedStyle(duixiang,null)[attr];
}


//添加class样式
Base.prototype.addClass=function(className){
	for(var i=0;i<this.elements.length;i++){
		//if (!this.elements[i].className.match(new RegExp('(\\s|^)' +className +'(\\s|$)'))) {			
		if(!this.elements[i].className.match(new RegExp(className,'ig'))){			//和上面的表达式一样，就是防止冲覅添加同样的class样式
			this.elements[i].className+=' '+className;	//这里如果只用=的话，会直接把className的值给替换掉,所以用+=
		}
	}
	return this;
}

//移除class样式
Base.prototype.removeClass=function(className){
	for(var i=0;i<this.elements.length;i++){
		if(this.elements[i].className.match(new RegExp(className,'ig'))){
			this.elements[i].className=this.elements[i].className.replace(new RegExp(className,'ig'),' ');
			//为什么这里直接这样不行this.elements[i].className.replace(new RegExp(className,'ig'),' ');
		}
	}
	return this;
}

//添加link或style的CSS规则     基本不会用
Base.prototype.addRule = function (num, selectorText, cssText, position) {
	var sheet = document.styleSheets[num];
	if (typeof sheet.insertRule != 'undefined') {//W3C
		sheet.insertRule(selectorText + '{' + cssText + '}', position);
	} else if (typeof sheet.addRule != 'undefined') {//IE
		sheet.addRule(selectorText, cssText, position);
	}
	return this;
}

//移除link或style的CSS规则		基本不会用
Base.prototype.removeRule = function (num, index) {
	var sheet = document.styleSheets[num];
	if (typeof sheet.deleteRule != 'undefined') {//W3C
		sheet.deleteRule(index);
	} else if (typeof sheet.removeRule != 'undefined') {//IE
		sheet.removeRule(index);
	}
	return this;
}
//获取某个节点并返回他的节点对象
Base.prototype.getElements=function(num){		
		return this.elements[num];
}

//获取某一节点的属性
Base.prototype.attr=function(attr,value){
	for( var i=0;i<this.elements.length;i++){
		if(arguments.length==1){
			//return this.elements[i][attr];									//这种方法只能获取标签自带的属性
			return this.elements[i].getAttribute(attr);			//getAttribute可以获取自定义的属性
		}else{
			//this.elements[i].getAttribute(attr)=value;			//getAttribute不能直接赋值
			this.elements[i].setAttribute(attr,value);
		}
	}
	return this;
}

//获取某一节点在节点数组中是第几个
Base.prototype.index=function(){
	var children = this.elements[0].parentNode.children;  //用children会忽略空白节点childNode不会忽略
	for( var i=0;i<children.length;i++){
		if(this.elements[0]==children[i]) return i;
	}
}

//获取当前元素节点的下一个元素节点
Base.prototype.next = function () {
	for (var i = 0; i < this.elements.length; i ++) {
		this.elements[i] = this.elements[i].nextSibling;
		if (this.elements[i] == null) throw new Error('找不到下一个同级元素节点！');
		if (this.elements[i].nodeType == 3) this.next();
	}
	return this;
};

Base.prototype.eq=function(num){					
	var element=this.elements[num];
	this.elements=[];
	this.elements[0]=element;
	return this;
}


//设置表单字段元素
Base.prototype.form=function(name){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i]=this.elements[i][name];
	}
	return this;
}

//表单字段内容的获取和设置
Base.prototype.value=function(str){
	for(var i=0;i<this.elements.length;i++){
		if(arguments.length==0){
			return this.elements[i].value;
		}
		this.elements[i].value=str;
	}
	return this;
}

//删除左右空格
//删除左后空格
function trim(str) {
	return str.replace(/(^\s*)|(\s*$)/g, '');
}

//设置事件发生器
Base.prototype.bind=function(event,fn){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].addEventListener(event,fn,false);
	}
	return this;
}

Base.prototype.click=function (fn){						//设置鼠标点击事件
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].addEventListener('click',fn,false);
	}
	return this;
}

//设置鼠标移入移出事件
Base.prototype.hover=function(over,out){
	for(var i=0;i<this.elements.length;i++){
		//this.elements[i].onmouseover=over;
		//this.elements[i].onmouseout=out;	
		this.elements[i].addEventListener('mouseover',over,false);	
		this.elements[i].addEventListener('mouseout',out,false);	
	}
}

//设置显示
Base.prototype.show=function(){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].style.display='block';
	}
	return this;
}

//设置隐藏
Base.prototype.hide=function(){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].style.display='none';
	}
	return this;
}

//设置物体居中
Base.prototype.center=function(width,height){
	var top=(document.documentElement.clientHeight- height)/2+getScroll().top;
	var left=(document.documentElement.clientWidth - width)/2+getScroll().left;
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].style.top=top+'px';
		this.elements[i].style.left=left+'px';
	}
	return this;
}

//设置锁屏遮罩
Base.prototype.lock=function(){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].style.width=window.innerWidth+getScroll().left+'px';
		this.elements[i].style.height=window.innerHeight+getScroll().top+'px';
		this.elements[i].style.display='block';
		document.documentElement.style.overflow='hidden';					//使窗口拖拽不会拖到滚动条里面
		//scrollTop();																				//这里如果直接用,会在遮罩的瞬间使scrollTop=0,当滚动条滚动时，就失去效果
																											//所以这个函数要写在scroll事件下才有效果
		window.addEventListener('scroll',scrollTop,false);
	}
	return this;
}

//取消遮罩
Base.prototype.unlock = function () {
	for (var i = 0; i < this.elements.length; i ++) {
		this.elements[i].style.display = 'none';
		document.documentElement.style.overflow = 'auto';
		window.removeEventListener('scroll',scrollTop,false);
		//scrollTop()=null;
	}
	return this;
}

Base.prototype.html=function(str){					//同时实现了获取innerHTML和设置innerHTML
	for(var i=0;i<this.elements.length;i++){		
		if(arguments.length==0){								//就是说如果函数传进来的参数为0
			return this.elements[i].innerHTML;
		}
		this.elements[i].innerHTML=str;
	}
	return this;
}

//触发浏览器窗口事件
Base.prototype.resize = function (fn) {
	for(var i=0;i<this.elements.length;i++){
			var _this=this.elements[i];
			//window.onresize =function(){
				window.addEventListener('resize',function(){
					fn();
					if(_this.offsetLeft>window.innerWidth + getScroll().left - _this.offsetWidth){
						_this.style.left=window.innerWidth  + getScroll().left- _this.offsetWidth+'px';
					}else if(_this.offsetLeft<0+getScroll().left){
						_this.style.left=getScroll().left+'px';
					}
					if(_this.offsetTop>window.innerHeight  + getScroll().top- _this.offsetHeight){
						_this.style.top=window.innerHeight + getScroll().top - _this.offsetHeight+'px';
					}else if(_this.offsetTop<0+getScroll().top){	
						_this.style.top=getScroll().top+'px';	
					}			//防止浏览器缩的非常小后,再放大会把图片和登录框挤出去
				},false)	
		};
	return this;
}

//插件入口		把插件单独写成一个js文件	如果想用哪个插件就直接在html文件中加载相应插件的js文件即可
Base.prototype.extend=function(name,fn){
	Base.prototype[name]=fn;
}

//让滚动条等于0				//这里就是解决登录框随滚动条的滑动而滑动
function scrollTop() {
	document.documentElement.scrollTop = 0;			//谷歌不支持
	document.body.scrollTop = 0;									//谷歌支持
}

//切换效果
Base.prototype.toggle=function(){
	for(var i=0;i<this.elements.length;i++){
		(function(elements,args){
			var count=0;
			elements.addEventListener('click',function(){
				args[count++].call(this);						//这里的call this有点不懂
				if(count>=args.length) count=0;
			},false);
		})(this.elements[i],arguments);		//这里是函数的传值
	}
	return this;
}



//跨浏览器获取滚动条高度
function getScroll(){
		return {
			top:document.documentElement.scrollTop ||document.body.scrollTop,	//这里返回的是个对像，要在第一个后边加逗号
			left:document.documentElement.scrollLeft ||document.body.scrollLeft	
		}
}


function inArray(array,value){
	for(var i in array){
		if(array[i]===value) return true;
	}	
	return false;
}

//预加载图片
//获取某一节点的下一节点的索引
function nextIndex(current,parent){
	var length = parent.children.length;
	if(current==length-1) return 0;
	return parseInt(current)+1;						//因为参数传值是传进来的字符串,这里要转化成数字型进行计算
}
//获取某一节点的上一节点的索引
function prevIndex(current,parent){
	var length = parent.children.length;
	if(current==0) return length-1;
	return parseInt(current)-1;
}



















