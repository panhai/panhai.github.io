/*
JQstr，效果的最外层DOM的JQstr
kidTag，效果需要被滚动的整体部分的DOM标签名，默认为ul，找不到指定元素则使用第一子元素
ctrls，Controllers控制器对象，可以使用的属性有
	.prev，向前播放的控制器的JQstr
	.next，向后播放的控制器的JQstr
	.indices，索引的JQstr（1/2/3/4/5...），索引的当前页码会被附加class="active"
	.stop，停止的控制器的JQstr
	.start，开始的控制器的JQstr
po，ParameterObject对象，附加参数列表，可以使用的属性有
	.dir，为滚动方向，只可以为u/d/l/r
	.delay，为滚动时间间隔，默认为30，不为0，越大滚动越慢
	.mstop，鼠标指向时停止开关，默认为true
	.minLi，为最少的显示数量，如果少于这个数量就不执行特效，默认为1
	.auto，是否自动播放，默认为true
cbfuns，CallbackFunctions对象，回调函数对象，可以使用的属性有
	cbfuns.init()，完成初始化时执行的函数，不可以直接使用生成的对象名
	cbfuns.move(JQobj)，每一次滚动时执行的函数，作用在当前指示的子元素上
如果生成有名对象的话，可以调用的方法有
	var.on()，开始滚动，使用后，auto被设置为true
	var.off()，停止滚动
	var.run(ind)，播放到指定索引的位置
	var.prev()，向前滚动一个
	var.next()，向后滚动一个
	var.size()，返回子元素个数
	var.cur()，返回当前作为标志的子元素索引
*/
function CHImovie(JQstr,kidTag,ctrls,po,cbfuns)
{
	//使用JQ找得到对象
	function FIND(jqstr){return jqstr && $(jqstr).size();}
	if(!FIND(JQstr))return;
	if(!po)po={};
	if(!ctrls)ctrls={};
	if(!cbfuns)cbfuns={};
	function isPos(n){return n && /^[\+]?[0]*[1-9][\d]*$/.test(n);}
	
	var o=new Object();
	/*target*/var t=$(JQstr).eq(0);
	if(!kidTag)kidTag="ul";
	/*kid*/var k=t.find(kidTag).eq(0);
	if(!k.size())k=t.children().eq(0);
	/*children*/var ks=k.children();
	/*total*/var tt=maxLi=ks.size();
	if(tt<2)return;//如果子元素不到2个则不滚动
	/*minLi*/var minLi=isPos(po.minLi) ? po.minLi : 1;
	if(tt<minLi)return; else tt-=minLi-1;
	/*watch*/var w=0;
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
	/*delay*/var dl=isPos(po.delay) ? po.delay : 3000;
	/*mouseStop*/var ms="mstop" in po ? Boolean(po.mstop) : true;
	/*auto*/var auto="auto" in po ? po.auto : true;
	/*current*/var cu=aim=0;
	var auto="auto" in po ? po.auto : true;
	
	var m,a,os;//margin,attribute,outerSize
	if(d=='l' || d=='r')
	{
		m="marginLeft";
		a="width";
		os="outerWidth";
	}
	else
	{
		m="marginTop";
		a="height";
		os="outerHeight";
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
	/*allSize*/var aS=totalSize(ks,a.substr(0,1));
	/*eachSize*/var eS=ks[os](true);
	
	k[a](aS);
	k.css(m,'0px');
	var active=false;
	if(ms && auto) t.mouseover(o.off).mouseleave(o.on);
	
	o.show=function(ind)
	{
		cu=(ind==undefined)?cu+1:ind;
		cu+=maxLi;
		cu%=maxLi;
		ks.eq(cu).addClass('cur').siblings().removeClass('cur');
		run(cu);
		if(cbfuns.move) cbfuns.move(ks.eq(cu));
	}
	function run(ind)
	{
		var n,b=false;//next,bool
		var ml=parseInt(k.css(m)) * -1;//margin length
		var need/*need scroll*/=false;
		//如果要显示的元素，不在可视区域内，才滚动
		if(aim > ind)
		{
			need=true;
			aim=ind;
		}
		else if(aim + minLi < ind + 1)
		{
			need=true;
			aim=ind - minLi + 1;
		}
		//保证每次只把目标元素滚动到边界位置
		var f/*focus*/=tt-1>aim ? aim : tt-1;
		
		if(!active && need)
		{
			active=true;
			o.off();
			var ao/*animate object*/={}; ao[m]='-'+ (f*eS) +'px';
			k.animate(ao,'','',function(){
				active=false;
				if(auto)o.on();
			});
		}
		if(typeof(ol)!='undefined')
		{
			ns.not(":eq("+cu+")").removeClass('cur');
			ns.eq(cu).addClass('cur');
		}
	}
	o.on=function(){auto=true;if(!w)w=setInterval(o.show,dl);}
	o.off=function(){clearInterval(w);w=0;}
	o.size=function(){return ks.size();}
	o.prev=function(){
		if(!active)
		{
			o.off();
			o.show(--cu);
			if(auto)o.on();
		}
	}
	o.next=function(){
		if(!active)
		{
			o.off();
			o.show(++cu);
			if(auto)o.on();
		}
	}
	if(FIND(ctrls.indices))
	{
		var ol=$(ctrls.indices);
		var ns=ol.children();
		ns.eq(0).addClass('cur');
		ns.click(function(){o.show($(this).index());});
	}
	if(FIND(ctrls.prev)) $(ctrls.prev).click(o.prev);
	if(FIND(ctrls.next)) $(ctrls.next).click(o.next);
	if(FIND(ctrls.stop)) $(ctrls.stop).click(o.off);
	if(FIND(ctrls.start)) $(ctrls.start).click(o.on);
	
	if(auto)o.on();
	o.show(0);
	if(cbfuns.init) cbfuns.init();
	return o;
}
