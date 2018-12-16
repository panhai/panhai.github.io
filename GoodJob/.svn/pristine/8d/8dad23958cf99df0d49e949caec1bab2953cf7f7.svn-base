/*
JQstr，效果的最外层DOM的JQstr
kidTag，效果需要被滚动的整体部分的DOM标签名，默认为ul，找不到指定元素则使用第一子元素
dir，方向，默认为l，只可以为l/r/u/d
each，每次移动过的子内容数量，默认为1
po，ParameterObject对象，附加参数列表，可以使用的属性有
	pdir，为滚动方向，只可以为u/d/l/r
	po.delay，为滚动时间间隔，默认为30，不为0，越大滚动越慢
	po.mstop，鼠标指向时停止开关，默认为true
cbfuns，CallbackFunctions对象，回调函数对象，可以使用的属性有
	cbfuns.init，完成初始化时执行的函数，不可以直接使用生成的对象名
	cbfuns.move，每一次滚动时执行的函数，应该可以直接使用生成的对象名
如果生成有名对象的话，可以调用的方法有
	var.on，开始滚动
	var.off，停止滚动
	var.roll，同方向转向，左右互转，或上下互转
	var.prev，向前滚动一个
	var.next，向后滚动一个
原理：
注：子DOM内容的每个组成部分必须同样大小
代码会自动查找ID的子元素SUB及SUP，并附加上前后播放动作
*/

function CHIpage(JQstr,kidTag,dir,po,cbfuns)
{
	var str_int_pos=/^[\+]?[0]*[1-9][\d]*$/;//正整数，+0不算
	if(!$(JQstr).size())return;
	var o=new Object();
	/*target*/var t=$(JQstr).eq(0);
	if(!kidTag)kidTag="ul";
	/*kid*/var k=t.find(kidTag).eq(0);
	if(!k.size())alert("找不到"+kidTag);
	/*children*/var ks=k.children();
	/*watch*/var w=0;
	/*direction*/var d=(("u,d,l,r").indexOf(dir)<0)?"l":dir;
	/*delay*/var dl=(po && ("delay" in po) && str_int_pos.test(po.delay))?eval(po.delay):3000;
	/*mouseStop*/var ms=(po && ("mstop" in po))?Boolean(po.mstop):true;
	/*prefix*/var p=(d=='l' || d=='u')?"-":"+";
	
	var m,c,os;//margin,css,outerSize
	if(d=='l' || d=='r')
	{
		m="marginLeft";
		c="width";
		os="outerWidth";
	}
	else
	{
		m="marginTop";
		c="height";
		os="outerHeight";
	}
	
	/*size*/var s=eval("t."+c+"()");
	/*allSize*/var aS=totalSize(ks,c.substr(0,1));
	/*eachSize*/var eS=eval("ks."+os+"(true)");
	/*total*/var tt=ks.size();
	if(s>aS)return;//如果外围尺寸大于内容尺寸，则不滚动
	
	//计算可以显示出来的子元素个数，在原有子元素队尾，取相同数量的新元素，并将它们复制到原有子元素队列的前方
	/*num*/var n=Math.ceil(s/eS);
	/*newkids*/var nk=ks.slice(tt-n,tt).clone();
	k.children().eq(0).before(nk);
	/*allNum*/var an=tt+n;
	eval("k."+c+"("+(eS*an)+");");
	eval("k.css({'"+m+"':'"+n*-1*eS+"px'})");
	var active=false;
	if(ms)
	{
		t.mouseover(function(){o.off();});
		t.mouseout(function(){o.on();});
	}
	if(t.children("sub").size())//自动查找sub用作“前一个”激活行为控件
	{
		t.children("sub").click(function(){o.prev();});
	}
	if(t.children("sup").size())//自动查找sup用作“后一个”激活行为控件
	{
		t.children("sup").click(function(){o.next();});
	}
	
	function run()
	{
		var n,b=false;//next,bool
		var ml=parseInt(k.css(m)) * -1;//margin length
		if(p=='-')
		{//正向滚动，到达最后位置时，还要正移之前，要把移动层移动到最前边
			if(ml==aS) {b=true;n=0;}
		}
		else
		{//负向滚动，到达最前位置时，还要负移之前，要把移动层移动到最后边
			if(ml==0) {b=true;n="-="+aS;}
		}
		if(b)eval("k.css({'"+m+"':'"+n+"'});");
		if(!active)
		{
			active=true;
			eval("k.animate({'"+m+"':'"+p+"="+eS+"'},'normal','linear',function(){active=false;})");
		}
		if(cbfuns && ("move" in cbfuns)) cbfuns.move();
	}
	//roll，换向
	o.roll=function(){p=p=="-"?"+":"-";}
	o.on=function(){if(!w)w=setInterval(function(){run();},dl);}
	o.off=function(){clearInterval(w);w=0;}
	o.prev=function(b){
		if(!active)
		{
			o.off();
			var x=p;
			p="+";
			run();
			if(!b)p=x;
			o.on();
		}
	}
	o.next=function(b){
		if(!active)
		{
			o.off();
			var x=p;
			p='-';
			run();
			if(!b)p=x;
			o.on();
		}
	}
	o.on();
	if(cbfuns && ("init" in cbfuns)) cbfuns.init();
	return o;
}
