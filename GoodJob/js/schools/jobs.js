// JavaScript Document
var f=$(".float2"),timer=0;
function InitFloat()
{
	var F=$(".float");
	$("li",F).click(function(){
		light(this);
	});
	$(window).scroll(function(){
		clearTimeout(timer);
		timer=0;
		timer=setTimeout(messure,100);
	});
	function light(DOM){$(DOM).closest("li").addClass('cur').siblings().removeClass('cur');}
	function messure()
	{
		var Jobs=$("#Jobs").offset().top;
		var Confs=$("#Confs").offset().top;
		var Comps=$("#Comps").offset().top;
		var st=$(window).scrollTop();
		if(st<Jobs)
		{
			f.find(".cur").removeClass('cur');
		}
		else if(st>=Jobs && st<Confs)
		{
			var ind=$("#Jobs h3").index("#Jobs .cur");
			light(f.find('a[href="#Jobs"]').get(ind));
		}
		else if(st>=Confs && st<Comps)
		{
			light(f.find('a[href="#Confs"]'));
		}
		else
		{
			light(f.find('a[href="#Comps"]'));
		}
	}
}
function Float()
{
	var w=$(window),ww=w.width(),wh=w.height(),
		tw=f.width(),th=f.height();
	var right=ttop=0;
	if(ww > 1000 + tw*2 +20) right=(ww-1000)/2-10-tw;
	if(wh>th) ttop=(wh-th)/2;
	f.css({
		right:right+'px'
		,top:ttop+'px'
	});
}
