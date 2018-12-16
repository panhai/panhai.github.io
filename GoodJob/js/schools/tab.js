/*
JQstr，效果的最外层DOM的JQstr
dtTag，各标题栏，点击它们会使对应的内容栏收缩或展开
ddTag，各内容栏，它们是会显示或隐藏的部分
po，参数对象，可以使用的属性有
	.way，激活方式，默认为mouseenter，即鼠标悬停时产生效果，还可以为click
	.auto，自动播放，默认为false
	.delay，自动播放的间隔，默认为3000
	.mstop，鼠标悬停时播放停止，默认为true
cbfuns，CallbackFunctions对象，回调函数对象，可以使用的属性有
	.init(dt0,dd0)，完成初始化时执行的函数，不可以直接使用生成的对象名
	.hide(dt_others,dd_others)，每一次缩回时执行的函数，dt是被隐藏的标题栏JQ对象，dd是被隐藏的内容栏JQ对象
	.show(dt_cur,dd_cur)，每一次展开时执行的函数，dt是被显示的标题栏JQ对象，dd是被显示的内容栏JQ对象
如果生成有名对象的话，可以调用的方法有
	var.show(i)，激活第i个标题，显示第i个内容
	var.on，开始自动播放，使用后auto被设置为true
	var.off，暂停自动播放
被激活的标题栏被附加class="active"
*/
function CHItab(JQstr,dtTag,ddTag,po,cbfuns)
{
	if(!JQstr || !$(JQstr).size() || !dtTag || !ddTag)return;
	if(!po)po={};
	if(!cbfuns)cbfuns={};
	function isPos(n){return n && /^[\+]?[0]*[1-9][\d]*$/.test(n);}

	var delay=isPos(po.delay) ? po.delay : 3000;
	var mstop="mstop" in po ? Boolean(po.mstop) : true;
	var auto=po.auto ? po.auto : false;
	
	var o=new Object();
	var t=$(JQstr).eq(0);
	var tb=t.find(dtTag);
	var cn=t.find(ddTag);
	if(tb.size()!=cn.size() || !tb.size())
	{
		alert("标签数量"+tb.length()+"与内容数量"+cn.length()+"不同！");
		return;
	}
	//低端浏览器，没有Array.indexOf()函数
	if(!Array.prototype.indexOf)
	Array.prototype.indexOf=function(ele){
		for(var n=0; n<this.length; n++)
		{
			if(ele===this[n]) return n;
		}
		return -1;
	}
	function get(DOM){return tb.index(DOM);}
	
	if(po.way=='click') tb.click(function(){o.show(this)});
	else tb.mouseenter(function(){o.show(this)});
	o.show=function(obj){
		cur=get(obj);
		tb.not(obj).removeClass("cur");
		$(obj).addClass("cur");
		cn.not(":eq("+cur+")").hide();
		if(cbfuns.hide)cbfuns.hide(tb.not(obj),cn.not(":eq("+cur+")"));
		cn.eq(cur).show();
		if(cbfuns.show)cbfuns.show(tb.eq(cur),cn.eq(cur));
	}
	var timer=0;
	o.on=function(){
		auto=true;
		var l=tb.size();
		if(!timer)timer=setInterval(function(){
			o.show(tb.get(cur));
			cur=(cur+1)%l;
		},delay);
	}
	o.off=function(){clearInterval(timer);timer=0;}
	if(mstop && auto) t.mouseenter(o.off).mouseleave(o.on);
	var cur=0;
	o.show(tb.get(0));
	if(auto)o.on();
	if(cbfuns.init) cbfuns.init(tb.eq(0),cn.eq(0));
	return o;
}
