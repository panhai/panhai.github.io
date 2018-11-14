/*
JQstr，效果的最外层DOM的JQstr
kidTag，效果需要被滚动的整体部分的DOM标签名，默认为ul，找不到指定元素则使用第一子元素
ctrls，Controllers控制器对象，可以使用的属性有
	.prev，向前播放的控制器的JQstr
	.next，向后播放的控制器的JQstr
	.stop，停止的控制器的JQstr
	.start，开始的控制器的JQstr
po，ParameterObject对象，附加参数列表，可以使用的属性有
	.dir，为滚动方向，只可以为u/d/l/r
	.speed，为滚动时间间隔，默认为30，不为0，越大滚动越慢
	.step，为步长，默认为1，在IE下只能通过改动step来达到飞速滚动的效果
	.mstop，鼠标指向时停止开关，默认为true
	.auto，自动播放，默认为true
cbfuns，CallbackFunctions对象，回调函数对象，可以使用的属性有
	.init，完成初始化时执行的函数，不可以直接使用生成的对象名
	.move(t)，每一次滚动时执行的函数，t是子层的JQ对象
如果生成有名对象的话，可以调用的方法有
	var.on，开始滚动
	var.off，停止滚动
	var.roll，同方向转向，左右互转，或上下互转
原理：子DOM的内容部分如果过长（超过最外层DOM的尺寸）则滚动，自动将内容部分复制，滚动到某一范围内时，自动跳转位置，形成连续错觉
注：子DOM内容的每个组成部分可以无所谓尺寸，任意大小
代码会自动查找ID的子元素SUB及SUP，并附加上前后转向动作
*/
function CHIscroll(JQstr,kidTag,ctrls,po,cbfuns)
{
	//使用JQ找得到对象
	function FIND(jqstr){return jqstr && $(jqstr).size();}
	if(!FIND(JQstr))return;
	if(!po)po={};
	if(!cbfuns)cbfuns={};
	if(!ctrls)ctrls={};
	function isPos(n){return n && /^[\+]?[0]*[1-9][\d]*$/.test(n);}

	var o=new Object();
	/*target*/var t=$(JQstr).eq(0);
	if(!kidTag)kidTag="ul";
	/*kid*/var k=t.find(kidTag).eq(0);
	if(!k.size())return;
	/*children*/var ks=k.children();
	/*primary kids num*/var pkn=ks.size();
	//低端浏览器，没有Array.indexOf()函数
	if(!Array.prototype.indexOf)
	Array.prototype.indexOf=function(ele){
		for(var n=0; n<this.length; n++)
		{
			if(ele===this[n]) return n;
		}
		return -1;
	}
	/*direction*/var d=po.dir && (["u","d","l","r"].indexOf(po.dir)>=0) ? po.dir : "l";
	/*speed*/var sp=isPos(po.speed) ? po.speed : 30;
	/*length*/var l=isPos(po.step) ? po.step : 1;
	/*mouseStop*/var ms="mstop" in po ? Boolean(po.mstop) : true;
	var auto="auto" in po ? po.auto : true;
	/*watcher*/var w=0;
	/*prefix*/var p=(d=='l' || d=='u')?"-":"+";
	
	var m,a,c;//margin,attribute,css
	if(d=='l' || d=='r')
	{
		m="marginLeft";
		a="w";
		c="width";
	}
	else
	{
		m="marginTop";
		a="h";
		c="height";
	}
	
	
	//计算元素的外围总尺寸
	function totalSize(jqObj,attr)
	{
		attr=attr.toLowerCase();
		var mapResult;
		if(attr=="w")
		{
			mapResult=jqObj.map(function(){return $(this).outerWidth(true);});
		}
		else if(attr=="h")
		{
			mapResult=jqObj.map(function(){return $(this).outerHeight(true);});
		}
		return eval(mapResult.get().join("+"));
	}
	/*size 外围元素尺寸*/var s;
	/*allSize 子元素总尺寸*/var aS;
	function mes()//messure
	{
		o.off();//先停止所有事件
		if(ms)
		{
			t.unbind("mouseover",o.off);
			t.unbind("mouseleave",o.on);
		}
		
		s=t[c]();//量当前外围尺寸
		aS=totalSize(k.children(),a);//量当前总子元素尺寸
		if(k.children().size()>pkn) aS*=0.5;//如果是复制过的，总子元素尺寸折半
		
		if(s>aS)//如果外围尺寸大于内容尺寸，则不滚动
		{//移除后复制进去的子元素
			if(k.children().size()>pkn)k.children(":gt("+(pkn-1)+")").remove();
			k[c]('auto');
			k.css(m,'0px')
		}
		else
		{//滚动起始，如果只有一组原来的子元素，则追加，防止频繁追加
			if(k.children().size()==pkn)k.append(ks.clone());
			k[c](aS*2)
			if(ms) t.mouseenter(o.off).mouseleave(o.on);
			if(auto)o.on();
		}
	}
	$(window).resize(mes);
	
	function run()
	{
		var n;//next
		var ml=parseInt(k.css(m)) * -1;//margin length
		n=(p=='-')?((ml < aS)?("-="+l):("+="+(aS-l))):((ml > aS-s)?("+="+l):("-="+(aS-l)));
		//if(p=='-') n=(ml < aS)?("-="+l):("+="+(aS-l));
		/*{//正滚时，当可见移动层在原层（第一个层）上，正常进行
			if(ml < aS) n="-="+l;
			//否则要移动到第一个层上的对应位置上，并步进
			else n="+="+(aS-l);
			
		}*/
		//else n=(ml > aS-s)?("+="+l):("-="+(aS-l));
		/*{//反滚时，当可见移动层在新层（第二个层）上，正常进行
			if(ml > aS-s) n="+="+l;
			//否则要移动到第二个层上的对应位置上，并步进
			else n="-="+(aS-l);
			
		}*/
		k.css(m,n);
		if(cbfuns.move) cbfuns.move(k);
	}
	//roll，换向
	o.roll=function(s){p=(s && (s=='-' || s=='+'))?s:(p=="-"?"+":"-");}
	o.on=function(){if(!w)w=setInterval(run,sp);}
	o.off=function(){clearInterval(w);w=0;}
	if(FIND(ctrls.prev)) $(ctrls.prev).click(function(){o.roll('-')});
	if(FIND(ctrls.next)) $(ctrls.next).click(function(){o.roll('+');});
	if(FIND(ctrls.stop)) $(ctrls.stop).click(o.off);
	if(FIND(ctrls.start)) $(ctrls.start).click(o.on);
	
	mes();
	if(cbfuns.init) cbfuns.init();
	return o;
}
